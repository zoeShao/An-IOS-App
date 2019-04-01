# Import everything we need
from flask import Flask, jsonify, request, redirect, url_for
from flask_cors import CORS

# model
import os
import csv
import hashlib

# Start the app and setup the static directory for the html, css, and js files.
app = Flask(__name__, static_url_path='', static_folder='static')
CORS(app)

# Global Varible
eventDB = None
resourcesDB = None
homeDB = None
userManager = None
admin_pw = None

# If in production env?
heroku_env = False
if heroku_env:
    prefix = "./app/"  # heroku env
else:
    prefix = ""  # local python env


class UserManager:
    """
    UserDB:     uid,    name,   email,  fav_event,     fav_res      password_hash
                int     String  String  [int: rid]     [int: rid]   hash
    """
    def __init__(self, path):
        self.users = []  # list of dictionary
        self.uid_counter = 0

    def get_next_uid(self):
        ret = self.uid_counter
        self.uid_counter += 1

        return ret

    def UUIDtoUID(self):
        pass

    def addUser(self, username, email, password):
        user_id = self.get_next_uid()
        user = {
                "uid": user_id,
                "username": username,
                "email": email,
                "password_hash": hashlib.sha256(password.encode('utf-8')).hexdigest(),
                "fav_event": [],
                "fav_res": []
                }
        self.users.append(user)

        return user_id


    def delUser(self, uid):
        pass

    def addEventFav(self, uid, rid):
        for user in self.users:
            if user["uid"] == uid:
                user["fav_event"].append(rid)
                return True
        # print("No such a user" + str(uid))
        return False

    def addResFav(self, uid, rid):
        for user in self.users:
            if user["uid"] == uid:
                user["fav_res"].append(rid)
                return True
        # print("No such a user" + str(uid))
        return False

    def delEvetnFav(self, uid, rid):
        pass

    def delResFav(self, uid, rid):
        pass

    def isEventFav(self, uid, rid):
        for user in self.users:
            if user["uid"] == uid:
                if rid in user["fav_event"]:
                    return True
        # print("No such a user" + str(uid))
        return False

    def isResFav(self, uid, rid):
        for user in self.users:
            if user["uid"] == uid:
                if rid in user["fav_res"]:
                    return True

        # print("No such a user" + str(uid))
        return False

class DB:
    """
    This is the DBMS of the backend, it support:
        loading from csv file,
        save to csv file,
        add new record to database,
        delete record from database.
    """
    # init
    def __init__(self):
        self.core = [] # list of list
        self.tags = []
        self.rid_counter = 0  # rowid
        self.path = ""

    # Private method
    # return the next available RowID
    def get_next_rid(self):
        ret = self.rid_counter
        self.rid_counter += 1
        return ret

    # load from csv file
    def loadFromCSV(self, path):
        # save the path
        self.path = path

        # drop the previous db first
        self.drop()

        # open file, setup csv reader
        file = open(path)
        reader = csv.reader(file, delimiter=',')
        rows = []
        for row in reader:
            rows.append(row)

        # read the first line
        header = rows[0]
        for tag in header:
            self.tags.append(tag)

        # for the rest
        for line in rows[1:]:
            # split
            record = []
            record.append(self.get_next_rid())  # assign rid to each record
            for item in line:
                record.append(item)
            # add to core
            self.core.append(record)

        # print("DB loaded.")

    # Save current DB to csv file
    def saveToCSV(self):

        path = self.path

        # remove the previous file
        os.remove(path)

        # open file
        file = open(path, "w")

        # write the first line tags into file
        tags = ""
        for tag in self.tags[:-1]:
            tags += "\"" + tag + "\","
        tags += "\"" + self.tags[-1] + "\"\n"
        file.write(tags)

        # write the rest line
        for record in self.core:
            line = ""
            for item in record[1:-1]:  # skip the rid part
                line += "\"" + item + "\","
            line += "\"" + record[-1] + "\"\n"
            file.write(line)

        file.close()

        # remove the last "\n"
        file = open(path, "ab")
        # remove the "\n" for the last line
        file.seek(-1, 2)
        file.truncate()

        file.close()

        # print("DB saved")

    def getAll(self):
        """
        Get all records
        :return: a list of dictionary which contain the tag and it's value
        """
        lst = []
        # for in core
        for record in self.core:
            dict = {}
            # format in json
            for i in range(len(self.tags)):
                key = self.tags[i]
                value = record[i + 1]  # we don't want to include the rid here
                dict[key] = value
            # add to list
            lst.append(dict)

        return lst

    def getAllWithRid(self):
        """
        Get all records with ROWID
        :return: a list of dictionary which contain the tag and it's value + ROWID
        """
        lst = []
        # for in core
        for record in self.core:
            dict = {}
            # Add rid
            key = "rid"
            value = record[0]
            dict[key] = str(value)

            # Add the rest
            for i in range(len(self.tags)):
                key = self.tags[i]
                value = record[i + 1]  # we don't want to include the rid here
                dict[key] = value
            # add to list
            lst.append(dict)

        return lst

    def getByRid(self, target_rid):
        """
        Get record by it's rid
        :param target_rid: row id
        :return: return the record if found, return None if no rid match
        """
        for record in self.core:
            if record[0] == target_rid:
                return self.tags, record
        return None

    def add(self, lst):
        """
        Add record to database.
        :param lst: list of element in current order corresponding to tags
        :return: If operation success return True, otherwise return False.
        """
        if len(lst) != len(self.tags):
            return False
        record = []
        record.append(self.get_next_rid())
        record += lst

        # add the database
        self.core.append(record)

        self.saveToCSV()
        return True

    def delete(self, target_rid):
        """
        Delete record according to the ROWID
        :param target_rid: RowID
        :return: If operation success return True, otherwise return False.
        """
        target_rid = int(target_rid)
        for index in range(len(self.core)):
            if self.core[index][0] == target_rid:
                self.core.pop(index)
                self.saveToCSV()
                return True

        return False

    # Drop the database
    def drop(self):
        self.core.clear()
        self.tags.clear()


# If new CSV file uploaded to server, use it to build new db
def reload_DB():
    global eventDB, resourcesDB
    eventDB.drop()
    eventDB.loadFromFile(prefix + "data/event.csv")
    resourcesDB.drop()
    resourcesDB.loadFromFile(prefix + "data/res.csv")
    homeDB.drop()
    homeDB.loadFromFile(prefix + "data/home.csv")


def read_admin_pw():
    file = open(prefix + "data/pw")
    admin_pw = file.read()
    return admin_pw


# Tester of DB
def DB_tester():
    db = DB()
    db.loadFromCSV(prefix + "data/test.csv")
    print(db.getAll())
    print(db.getAllWithRid())
    db.delete("0")
    db.saveToCSV(prefix + "data/test_save.csv")

# running db tester
# DB_tester()

# setup everything before running the server
def init():
    global eventDB, resourcesDB, homeDB, userManager, admin_pw

    admin_pw = read_admin_pw()

    eventDB = DB()
    eventDB.loadFromCSV(prefix + "data/event.csv")
    resourcesDB = DB()
    resourcesDB.loadFromCSV(prefix + "data/res.csv")
    homeDB = DB()
    homeDB.loadFromCSV(prefix + "data/home.csv")
    userManager = UserManager(prefix + "data/users.csv")

    # for test
    user1id = userManager.addUser("user1", "user1@email.com", "user1password")
    # print(user1id)
    userManager.addEventFav(user1id, 0)
    userManager.addEventFav(user1id, 2)
    # print(userManager.users)
    userManager.addResFav(user1id, 0)
    userManager.addResFav(user1id, 2)

# Setup everything before accept any request
init()


@app.route('/')
def index():
    return redirect("/admin_login.html")


##################################################################
##########################  password   ###########################
##################################################################


@app.route('/pw', methods=['POST'])
def pw():
    password = request.json["password"]
    password_hash = hashlib.sha256(password.encode('utf-8')).hexdigest()
    if password_hash == admin_pw:
        return jsonify({"pw_ok": "T",
                        "upload_url":"/upload.html"})
    else:
        return jsonify({"pw_ok": "F"})


##################################################################
##########################    home     ###########################
##################################################################


@app.route('/home')
def home():
    """
    Expected JSON Format:
    [{title        : String - new title  (optional),
      time         : String - time,
      news_content : String - news content,
      image        : String - url to image (optional)
    },
    ...
    ]
    """
    raw = homeDB.getAll()
    json = []
    json.append(raw[-1])
    json.append(raw[-2])
    json.append(raw[-3])
    json.append(raw[-4])
    json.append(raw[-5])
    json.append(raw[-6])
    json.append(raw[-7])
    json.append(raw[-8])


    return jsonify(json)


@app.route('/home', methods = ['POST'])
def addHome():
    result = []
    title = request.json["title"]
    time = request.json["time"]
    news_content = request.json["new_content"]
    image = request.json["image"]
    result.append(title)
    result.append(time)
    result.append(news_content)
    result.append(image)
    homeDB.add(result)
    return ("True")

@app.route('/home', methods = ['DELETE'])
def deleteHome():
    hid = request.json["hid"]
    resourcesDB.delete(hid)
    return("True")

##################################################################
########################    resources     ########################
##################################################################


@app.route('/resources')
def fetch_all_resources():
    """
    Expected JSON Format:
        { "Resources":
            [
                { "category": String
                  "contents":
                  [
                    {
                        "title"       : String
                        "resource_url": String
                        "img"         : String
                    },
                    {
                        second content...
                    }
                  ]
                },
                {
                    second category...
                }
            ]

        }
    """
    json = {"Resources":[]}
    raw = resourcesDB.getAllWithRid()
    cat_set = dict()

    for record in raw:
        type = record["category"]
        if type in cat_set.keys():
            cat_set[type].append(record)
        else:
            cat_set[type] = [record]

    # Now all records had been split
    for cat in cat_set.items():  # For each category
        cat_name = cat[0]
        cat_json = {"category": cat_name,
                    "contents": []}
        for record in cat[1]:  # For each record in each category
            each_content = {}
            each_content["rid"] = record["rid"]
            each_content["title"] = record["title"]
            each_content["resource_url"] = record["resource_url"]
            each_content["img"] = record["img"]
            cat_json["contents"].append(each_content)
        json["Resources"].append(cat_json)

    # Create cat all
    cat_all = {"category": "all",
               "contents": []}


    for record in raw:
        each_content = {}
        each_content["rid"] = record["rid"]
        each_content["title"] = record["title"]
        each_content["resource_url"] = record["resource_url"]
        each_content["img"] = record["img"]
        cat_all["contents"].append(each_content)

    json["Resources"].append(cat_all)

    return jsonify(json)

@app.route('/resources_w_fav/<int:uid>')
def fetch_res_with_fav(uid):
    raw = resourcesDB.getAllWithRid()
    json = {"Resources":[]}
    for record in raw:
        if userManager.isResFav(uid, int(record["rid"])):
            each_content = {}
            each_content["rid"] = record["rid"]
            each_content["title"] = record["title"]
            each_content["resource_url"] = record["resource_url"]
            each_content["img"] = record["img"]
            json["Resources"].append(each_content)

    return jsonify(json)

@app.route('/resources_w_fav/', methods=['POST'])
def add_res_fav():
    uid = request.json["uid"]
    rid = request.json["rid"]

    userManager.addResFav(uid, rid)

    return jsonify(request.json)


@app.route('/resources', methods = ['POST'])
def addResource():
    temp = []
    category = request.json["category"]
    title = request.json["title"]
    url = request.json["resource_url"]
    img = request.json["img"]
    temp.append(category)
    temp.append(title)
    temp.append(url)
    temp.append(img)
    resourcesDB.add(temp)
    return("True")


@app.route('/resources', methods=['DELETE'])
def deleteResource():
    temp = request.json["rid"]
    print(temp)
    resourcesDB.delete(temp)
    return("true")

@app.route('/resources/rid', methods=['GET'])
def allResourceRid():
    records = resourcesDB.getAllWithRid()
    return jsonify(records)



##################################################################
########################       Event      ########################
##################################################################
@app.route('/event')
def fetch_all_event():
    """ Expected JSON Format:
        { "Events" : [{
                       "title"        : String - Event title,
                       "source"       : String - Facebook, Twitter, ...,
                       "release_date" : String - Time that this event was created,
                       "b_content"    : String - Short content that displayed in main page
                       "image_url"    : String - URL to event image,
                       "main_content" : String - Main Content,
                       "address"       : String - Event address,
                       "event_date"    : String - Date that event will be held,
                       "event_time"    : String - Time that event will be held,
                       "map"           : String - Reserved keyword,
                       "event_website" : String - URL to the event website
                      }, ...]
        }
    """

    return jsonify({"Events": eventDB.getAllWithRid()})

@app.route('/event_w_fav/<int:uid>')
def fetch_event_with_fav(uid):
    raw = eventDB.getAllWithRid()
    ret = []
    for record in raw:
        if userManager.isEventFav(uid, int(record["rid"])):
            record["fav"] = "True"
        else:
            record["fav"] = "False"
        ret.append(record)

    return jsonify(ret)

@app.route('/event_w_fav/', methods=['POST'])
def add_event_fav():
    uid = int(request.json["uid"])
    rid = int(request.json["rid"])

    userManager.addEventFav(uid, rid)

    return jsonify(request.json)

@app.route('/event/rid', methods=['GET'])
def allEventRid():
    records = eventDB.getAllWithRid()
    return jsonify(records)


@app.route('/event', methods = ['POST'])
def getEvent():
    if("eid" in request.json):
        pass
    else:
        temp = []
        title = request.json["title"]
        source = request.json["source"]
        release_date = request.json["release_date"]
        b_content = request.json["b_content"]
        image_url = request.json["image_url"]
        main_content = request.json["main_content"]
        address = request.json["address"]
        event_date = request.json["event_date"]
        event_time = request.json["event_time"]
        map = request.json["map"]
        event_website = request.json["event_website"]
        temp.append(title)
        temp.append(source)
        temp.append(release_date)
        temp.append(b_content)
        temp.append(image_url)
        temp.append(main_content)
        temp.append(address)
        temp.append(event_date)
        temp.append(event_time)
        temp.append(map)
        temp.append(event_website)
        eventDB.add(temp)
        return("True")


@app.route('/event', methods = ['DELETE'])
def deleteEvent():
    temp = request.json["eid"]
    eventDB.delete(temp)
    print(temp)
    return("true")


##################################################################
#####################         User         #######################
##################################################################
@app.route('/users', methods=['POST'])
def add_user():
    uuid = request.json["uuid"]

    userManager.addUserWithUID(uid, "username", "email", "password")

    return jsonify(request.json)



if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host='0.0.0.0', debug=True, port=os.environ.get('PORT', 80))
