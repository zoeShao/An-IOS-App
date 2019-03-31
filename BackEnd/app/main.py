from flask import Flask, jsonify, request, redirect, url_for
from flask_cors import CORS
import os

# Start the app and setup the static directory for the html, css, and js files.
app = Flask(__name__, static_url_path='', static_folder='static')
CORS(app)

eventDB = None
resourcesDB = None
admin_pw = None

# prefix = ""
prefix = "./app/"


class DB:
    # init
    def __init__(self):
        self.core = [] # list of list
        self.tags = []

    # load from csv file
    def loadFromFile(self, path):
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
            for item in line.split(','):
                record.append(item)
            # add to core
            self.core.append(record)

        print("DB loaded.")

    def getAll(self):
        lst = []
        # for in core
        for record in self.core:
            dict = {}
            # format in json
            for i in range(len(self.tags)):
                key = self.tags[i]
                value = record[i]
                dict[key] = value
            # add to list
            lst.append(dict)

        return lst

    def clear(self):
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


# setup everything before running the server
def init():
    global eventDB, resourcesDB, admin_pw

    admin_pw = read_admin_pw()
    print("Admin Password:" + admin_pw)

    eventDB = DB()
    eventDB.loadFromFile(prefix + "data/event.csv")
    resourcesDB = DB()
    resourcesDB.loadFromFile(prefix + "data/res.csv")

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
