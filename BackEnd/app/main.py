from flask import Flask, jsonify, request, redirect, url_for
from flask_cors import CORS
import os

# Start the app and setup the static directory for the html, css, and js files.
app = Flask(__name__, static_url_path='', static_folder='static')
CORS(app)

eventDB = None
resourcesDB = None
admin_pw = None

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
        #print(self.core)

    # return all records in Json
    # {"Events" : [list of single event]}
    def getAllAsJSON(self):
        lst = []
        # for in core
        for record in self.core:
            json = {}
            # format in json
            for i in range(len(self.tags)):
                key = self.tags[i]
                value = record[i]
                json[key] = value
            # add to list
            lst.append(json)

        #print(lst)
        return {"Events" : lst}

    def clear(self):
        self.core.clear()
        self.tags.clear()


# If new CSV file uploaded to server, use it to build new db
def reload_DB():
    global eventDB, resourcesDB
    eventDB.clear()
    eventDB.loadFromFile("./data/event.csv")


def read_admin_pw():
    file = open("./data/pw")
    admin_pw = file.read()
    return admin_pw


# setup everything before running the server
def init():
    global eventDB, resourcesDB, admin_pw

    admin_pw = read_admin_pw()
    print("Admin Password:" + admin_pw)

    eventDB = DB()
    eventDB.loadFromFile("./data/event.csv")

# Setup everything
init()


@app.route('/')
def index():
    return redirect("/admin_login.html")

# @app.route('/password/<password>')
# def verify_pw(password):
#     if password == "youthlinel2019":
#         return redirect("/upload.html")
#     else:
#         return "wrong password"


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
        {

        }
    """

    return jsonify(None)

@app.route('/event')
def fetch_all_event():
    """ Expected JSON Format:
        { "title"        : String - Event title,
          "source"       : String - Facebook, Twitter, ...,
          "release_date" : String - Time that this event was created,
          "b_content"    : String - Short content that displayed in main page
          "image_url"    : String - URL to event image,
          "main_content" : String - Main Content,
          "extra" : { "address"       : String - Event address,
                      "event_date"    : String - Date that event will be held,
                      "event_time"    : String - Time that event will be held,
                      "map"           : String - Reserved keyword,
                      "event_website" : String - URL to the event website
                    }
        }
    """

    return jsonify(eventDB.getAllAsJSON())


if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host='0.0.0.0', debug=True, port=os.environ.get('PORT', 80))
