from flask import Flask, jsonify, request
from flask_cors import CORS
import os

# Start the app and setup the static directory for the html, css, and js files.
app = Flask(__name__, static_url_path='', static_folder='static')
CORS(app)

# This is your 'database' of scripts with their blocking info.
# You can store python dictionaries in the format you decided on for your JSON
   # parse the text files in script_data to create these objects - do not send the text
   # files to the client! The server should only send structured data in the sallest format necessary.

#[scripts 1 [script_text, [Part 1. start, end, [[actor_id, blocking],...]]
#                         [Part 2. ]          ]
# scripts 2 []
#    .
#    .
#    .
# scripts n []]
# scripts = [["That's it Claudius, I'm leaving!Fine! Oh..he left already..", [[0,  31, {1:5, 2:2}],
#                                                                             [32, 58, {1:0, 2:3}]]],
#            ["This is my monologue..oh woe is me...", [[0, 36, {1:2}]]]
#            ]


################## This is a database example ##################
# scripts = [
#     {"script_text":"That's it Claudius, I'm leaving!Fine! Oh..he left already..",
#      "partition":
#          [
#              {
#                  "start":0,
#                  "end":31,
#                  "blockings":{1:5, 2:2}
#              },
#              {
#                  "start":32,
#                  "end":58,
#                  "blockings":{1:0, 2:3}
#              }
#          ]
#      },
#     {"script_text": "This is my monologue..oh woe is me...",
#      "partition":
#          [
#              {
#                  "start": 0,
#                  "end": 31,
#                  "blockings":{1: 5, 2: 2}
#              }
#          ]
#      }
# ]

scripts = []

#actors = {1:"Hamlet", 2:"Claudius"}

actors = {}

# function to load script from file to memory
def init_database(csv_path, script_prefix, scripts_count):
    # init names
    csv = open(csv_path)
    for line in csv.read().splitlines():
        line_split = line.split(",")
        actors[int(line_split[0])] = line_split[1]

    # init script
    path = "./app/script_data/"
    for i in range(1, scripts_count + 1):
        # read the script file
        file_path = path + script_prefix + str(i) + ".txt"
        file = open(file_path, "r")
        lines = file.read().splitlines()

        # create script dict in memory
        script = {}

        # script_text
        script["script_text"] = lines[2]  # third line is the script text
        # partition
        script["partition"] = []
        for line in lines[4:]:
            line_split = line[3:].split(",")
            start = line_split[0]
            end = line_split[1]
            blockings = {}
            for actor_pos in line_split[2:]:
                name, pos = actor_pos.split("-")
                name = name[1:]
                for actor_id, actor_name in actors.items():
                    if name == actor_name:
                        blockings[actor_id] = int(pos)
            script["partition"].append({"start":start, "end":end, "blockings":blockings})

        # at last add script to scripts
        scripts.append(script)

        file.close()
    return

# Call to load script from file to memory
init_database("./app/actors.csv", "hamlet", 2)

# function to update particular script
def update_script(script, script_num):

    prefix = "./app/script_data/hamlet"
    test_prefix = "./app/test/hamlet" # for debug purpose

    path = prefix + str(script_num+1) + ".txt"

    # del the original file
    os.remove(path)

    # open a new file
    new_file = open(path, "w")

    # write the script num to first line
    new_file.write(str(script_num+1) + "\n")

    # write a new line
    new_file.write("\n")

    # write the script text
    new_file.write(script["script_text"] + "\n")

    # write a new line
    new_file.write("\n")

    # write partition
    parts = script["partition"]
    for i in range(0, len(parts)):
        # write header
        new_file.write(str(i+1)+". ")

        # write start
        new_file.write(str(parts[i]["start"])+",")

        # write end
        new_file.write(str(parts[i]["end"])+",")

        # write blockings
        pin = None
        for actor_id, position in parts[i]["blockings"].items():
            mystring = actors[actor_id] + "-" + str(position)
            new_file.write(" "+mystring)
            pin = new_file.tell()
            new_file.write(",")
        new_file.seek(pin)
        new_file.write("\n")
    new_file.seek(pin)
    new_file.truncate()
    # close file
    new_file.close()

    return



### DO NOT modify this route ###
@app.route('/')
def hello_world():
    return 'Theatre Blocking root route'

### DO NOT modify this example route. ###
@app.route('/example')
def example_block():
    example_script = "O Romeo, Romeo, wherefore art thou Romeo? Deny thy father and refuse thy name. Or if thou wilt not, be but sworn my love And I’ll no longer be a Capulet."

    # This example block is inside a list - not in a dictionary with keys, which is what
    # we want when sending a JSON object with multiple pieces of data.
    return jsonify([example_script, 0, 41, 4])


''' Modify the routes below accordingly to 
parse the text files and send the correct JSON.'''

## GET route for script and blocking info
@app.route('/script/<int:script_id>')
def script(script_id):
    # right now, just sends the script id in the URL


    json = {"script":scripts[script_id-1],
            "actors":actors}


    return jsonify(json)


## POST route for replacing script blocking on server
# Note: For the purposes of this assignment, we are using POST to replace an entire script.
# Other systems might use different http verbs like PUT or PATCH to replace only part
# of the script.
@app.route('/script', methods=['POST'])
def addBlocking():
    # right now, just sends the original request json
    allblocks = request.json["allBlocks"]
    scriptNum = int(request.json["scriptNum"]) - 1
    orig_script = scripts[scriptNum ]
    orig_parts = orig_script["partition"]

    for part_num in range(0,len(allblocks)):
        # check if position match
        part_actors = allblocks[part_num]["actors"]
        orig_part_actors = orig_parts[part_num]["blockings"]

        # convert part_actors
        for actor in part_actors:
            actor_name = actor[0]
            for key, value in actors.items():
                if value == actor_name:
                    actor[0] = key
            actor_pos = actor[1]
            if actor_pos == " " or actor_pos == "":
                actor[1] = 0
            else:
                actor[1] = int(actor[1])

        # compare
        for key, value in orig_part_actors.items():
            for actor_id, actor_pos in part_actors:
                if key == actor_id and actor_pos != value:
                    scripts[scriptNum]["partition"][part_num]["blockings"][key] = actor_pos

    # write script to file
    newScript = scripts[scriptNum]
    update_script(newScript, scriptNum)

    return jsonify([request.json, scripts])



if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host='0.0.0.0', debug=True, port=os.environ.get('PORT', 80))

