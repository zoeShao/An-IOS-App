from flask import Flask, jsonify, request, redirect, url_for
from flask_cors import CORS
import os

# Start the app and setup the static directory for the html, css, and js files.
app = Flask(__name__, static_url_path='', static_folder='static')
CORS(app)

eventDB = None
resourcesDB = None
admin_pw = None

heroku_env = False

if heroku_env:
    prefix = "./app/"  # heroku env
else:
    prefix = ""  # local python env


class DB:
    # init
    def __init__(self):
        self.core = [] # list of list
        self.tags = []
        self.rid_counter = 0  # rowid

    def get_next_rid(self):
        ret = self.rid_counter
        self.rid_counter += 1
        return ret

    # load from csv file
    def loadFromCSV(self, path):
        # drop the previous db first
        self.drop()

        # open file
        file = open(path)
        lines = file.read().splitlines()

        # read the first line
        header = lines[0]
        for tag in header.split(","):
            self.tags.append(tag)

        # for the rest
        for line in lines[1:]:
            # split
            record = []
            record.append(self.get_next_rid())  # assign rid to each record
            for item in line.split(','):
                record.append(item)
            # add to core
            self.core.append(record)

        print("DB loaded.")

    # Save current DB to csv file
    def saveToCSV(self, path):
        # remove the previous file
        os.remove(path)

        # open file
        file = open(path, "w")

        # write the first line tags into file
        tags = ""
        for tag in self.tags[:-1]:
            tags += tag + ","
        tags += self.tags[-1] + "\n"
        file.write(tags)

        # write the rest line
        for record in self.core:
            line = ""
            for item in record[1:-1]:  # skip the rid part
                line += item + ","
            line += record[-1] + "\n"
            file.write(line)

        file.close()

        file = open(path, "ab")
        # remove the "\n" for the last line
        file.seek(-1, 2)
        file.truncate()

        file.close()

        print("DB saved")

    def getAll(self):
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

    def add(self, lst):
        record = []
        record.append(self.get_next_rid())
        record += lst

        # add the database
        self.core.append(record)

    def delete(self, target_rid):
        target_rid = int(target_rid)
        for index in range(len(self.core)):
            if self.core[index][0] == target_rid:
                self.core.pop(index)
                return

    # Drop the database
    def drop(self):
        self.core.clear()
        self.tags.clear()


# If new CSV file uploaded to server, use it to build new db
def reload_DB():
    global eventDB, resourcesDB
    eventDB.clear()
    eventDB.loadFromFile(prefix + "data/event.csv")
    resourcesDB.clear()
    resourcesDB.loadFromFile(prefix + "data/res.csv")


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
    db.saveToCSV(prefix + "data/test_save.csv")

# running db tester
# DB_tester()

# setup everything before running the server
def init():
    global eventDB, resourcesDB, admin_pw

    admin_pw = read_admin_pw()
    print("Admin Password:" + admin_pw)

    eventDB = DB()
    eventDB.loadFromCSV(prefix + "data/event.csv")
    resourcesDB = DB()
    resourcesDB.loadFromCSV(prefix + "data/res.csv")

# Setup everything
init()


@app.route('/')
def index():
    return redirect("/admin_login.html")


@app.route('/pw', methods=['POST'])
def pw():
    password = request.json["password"]
    if password == admin_pw:
        return redirect("/upload.html")
    else:
        return "wrong password"


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
    raw = resourcesDB.getAll()
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
            each_content["title"] = record["title"]
            each_content["resource_url"] = record["resource_url"]
            each_content["img"] = record["img"]
            cat_json["contents"].append(each_content)
        json["Resources"].append(cat_json)

    return jsonify(json)

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

    return jsonify({"Events": eventDB.getAll()})


if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host='0.0.0.0', debug=True, port=os.environ.get('PORT', 80))
