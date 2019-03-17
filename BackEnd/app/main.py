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

    return jsonify(None)

@app.route('/event')
def fetch_all_event():
    json = {"test":"test"}
    
    return jsonify(json)

if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host='0.0.0.0', debug=True, port=os.environ.get('PORT', 80))