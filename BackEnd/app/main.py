from flask import Flask, jsonify, request
from flask_cors import CORS
import os

# Start the app and setup the static directory for the html, css, and js files.
app = Flask(__name__, static_url_path='', static_folder='static')
CORS(app)

@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/resources/category/<cat>')
def fetch_res_cat(cat):

    return jsonify(None)

@app.route('/resources/all')
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
    json = {"test":"test"}

    return jsonify(json)

if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host='0.0.0.0', debug=True, port=os.environ.get('PORT', 80))