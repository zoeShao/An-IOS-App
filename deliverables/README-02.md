# LGBT YouthLine/Rainbow Warriors

## Description 
LGBT youthline provides various supporting resources and events information on their website. However, their website is only compatible with PC. It is a hard time if user want to access the website on a mobilephone. Our app is able to display the resources and events on a mobilephone in a friendly way by reorganizing the layout, adding bookmarks.

## Key Features
### Home Page:
In the Home Page, user can have a overview of the organization. The app provide two buttons to contact the youthline organizers (by phone or messages) and link to youthline social medias. User can also view some latest posts of youthline. By pressing each post, user can see the detail of the post.

### Resources Page:
In this page, user are able to browse all the helping resources provided by LGBT youthline in a mobilephone friendly way. By pressing the each resource, user can see the detail of the resources. The app provides the filter for the resources.

### Event Page:
In the event page, user can see all the events (both the upcoming ones and the past ones). By pressing the each event, user can see the detail of the event.
Also, user can mark some resources as "like", so they can save it to their phone and read them later.

### Me Page:
This page authenticates the user using Firebase. The user requires to registered using email. If the email is not in the database, it will ask the user to create a new account then log in. After logging in, the user is enabled to see their user name and login email in the dashboard. Also, the user can log out using the log out button.

## Back-end:
We will use assignment 1 as the starting point to build the backend.
The Backend will provide database access. Database will preserve after app restart.

* Front-End mobile app can fetch event, resources and homepage data from Backend.
* Front-End mobile app can save which resources or event has been bookmarked by which user to Backend.

Backend also has GUI for admin to update the database.
* Admin can see all event, resources and homepage data thought GUI Admin page.
* Admin can delete any event, resources and homepage data thought GUI Admin page.
* Admin can add event, resources and homepage data thought GUI Admin page.

### Desige Choices
### FireBase
* Because we are not professional Developer yet, so we want to keep away from touching or storing sensitive data, like user email or password. So, we use Firebase firmwork developed by Google as our user authorization and management system, user's email and hashed password will be stored on firebase server instead of us.
* We embed the firebase login kit in our App, which work like a black box, after user login, the black box will return a unique user identifier(UUID) to the our App, so the App can send or request data from our server without letting us know who he\she is.

### Database
We are using CSV to serialize our database. There are serveral advantages of using CSV file.
* CSV file is easily programmatically manipulate, since it is simple text file.
* Import CSV file is fast and less memory consuming.
* CSV file is easy to generate by lots of language.

# API
## Event 
#### Fetch All Event
"GET" at "/event": Return the event in JSON format.
```json
{ "Events" : [{
                       "title"         : "String - Event title",
                       "source"        : "String - Facebook, Twitter, ...",
                       "release_date"  : "String - Time that this event was created",
                       "b_content"     : "String - Short content that displayed in main page",
                       "image_url"     : "String - URL to event image",
                       "main_content"  : "String - Main Content",
                       "address"       : "String - Event address",
                       "event_date"    : "String - Date that event will be held",
                       "event_time"    : "String - Time that event will be held",
                       "map"           : "String - Reserved keyword",
                       "event_website" : "String - URL to the event website"
                      }]
        }
```
#### Fetch User Favoriate Event
"GET" at "/event_w_fav/<int:uid>": Return Events with additional key "fav". "True" indicate this event is favoriated by this user.
```json
    { "Events" : [{
                       "title"         : "String - Event title",
                       "source"        : "String - Facebook, Twitter, ...",
                       "release_date"  : "String - Time that this event was created",
                       "b_content"     : "String - Short content that displayed in main page",
                       "image_url"     : "String - URL to event image",
                       "main_content"  : "String - Main Content",
                       "address"       : "String - Event address",
                       "event_date"    : "String - Date that event will be held",
                       "event_time"    : "String - Time that event will be held",
                       "map"           : "String - Reserved keyword",
                       "event_website" : "String - URL to the event website",
                       "fav"           : "favoriate indicator"
                      }]
        }
```

#### Post new Event
"POST" at "/event": The event will be add to the database in backend.
```json
{ 
  "title"       : "etitle", 
  "source"      : "esource", 
  "release_date": "edate",
  "b_content"   : "econtent", 
  "image_url"   : "eimage", 
  "main_content": "emain",
  "address"     : "eaddress", 
  "event_date"  : "eEventDate", 
  "event_time"  : "eEventTime",
  "map"         : "None", 
  "event_website":"eEventW"
}
```

#### Delete Event
"Delete" at "/event": Backend will the event which event id is "eid"
```json
      {
        "eid": "String - eid"
      }
```

## Resources
#### Fetch All Resources
"Get" at "/resources": return the resources in JSON Format
```json
    { "Resources":
            [
                { "category": "String - category",
                  "contents":
                  [
                    {
                        "title"       : "String - event title",
                        "resource_url": "String - event url",
                        "img"         : "String - image url",
                        "rid"         : "String - Event unique ID"
                    }
                  ]
                }
            ]
    }
```
#### Fetch User Favoriate Resources
"Get" at "/resources_w_fav/<int:uid>": return the resources favoriated by user with uid
```json
    {
        "Resources": [
                          {
                            "img": "image url", 
                            "resource_url": "resources url", 
                            "rid": "0", 
                            "title": "Settlement.Org: Sexual Orientation and Gender Identity"
    }
```

#### Delete Resources
"Delete" at "/resources": Delete resources which unique id is rid.
```json
      {"rid":"rid"}
```

#### Post new Resources
"Post" at "/Resources": Add resources to backend database
```json
    {
     "category"     : "category", 
     "title"        : "title", 
     "resource_url" : "resource url", 
     "img"          : "image url"
    }
```
## HomePage
#### Fetch Home
"Get" at "/home": Return the homepage element in JSON Formate
```json
    [{"title"        : "String - new title  (optional)",
      "time"         : "String - time",
      "news_content" : "String - news content",
      "image"        : "String - url to image (optional)"
    }
    ]
```

#### Post Home
"Post" at "/home": Add homepage element to backend database
```json
      {
       "title"        : "title", 
       "time"         : "time", 
       "news_content" : "news content", 
       "image"        : "image"
       }
```

### Delete Home
"Delete" at "/home": Delete the home element which id is "hid"
```json
    {"hid":"hid"}
```

## Admin Password Verifycation
"POST" at "/pw": Verify if password is correct.
```json
    {"password":"password"}
```

# Instructions
## Deploy Back-end
### docker
To start:

`docker build -t youthline-backend .`

`docker run -d --name youthline-backend-container -p 80:80 youthline-backend:latest`

`docker start youthline-backend-container`

To stop/remove container:

`docker stop youthline-backend-container`

`docker rm youthline-backend-container`

To restart container:
`docker stop youthline-backend-container;docker rm youthline-backend-container;docker build -t youthline-backend .;docker run -d --name youthline-backend-container -p 80:80 youthline-backend:latest;docker start youthline-backend-container`

### heroku
`heroku login`

`heroku create --app youthline-test-server`

`heroku container:login`

`heroku container:push web --app youthline-test-server`

`heroku container:release web --app youthline-test-server`

`heroku open --app youthline-test-server`

### Heroku URL: 

http://youthline-test-server.herokuapp.com/

## Deploy The Full App
 * If we try to deploy our application in AppStroe, we need to have Apple developer membership, which will cost 119 CAD per year. We cannot reach our partner for several weeks. At this situation, we cannot use AppStore to do universal deploy, we can only use Xcode to deploy in developer environment.
 ### Option1:
* Step 1: Clone the project repo to a Mac computer.
* Step 2: Download Xcode.
* Step 3: Open terminal, type the following command to install the CocoaPods lib using by our app.
> gem install cocoapods
* Step 4: cd the terminal to the "YourthLine" directory under the git repo directory.
* Step 5: type the following command to install the CocoaPods lib under "YourthLine" directory, the main project directory.
> pod install
* Step 6: Double clicks "YouthLine.xcworkspace" under the "YourthLine" directory.
* Step 7: In the Xcode window, press "Command" + "," to open preference menu, go to "Component" tab, download the iOS 12 Simulator.
* Step 8: Click the "Run" buttom at the top left corner of Xcode. Now the code should compile and simulator will pop-up after the compilation success.
* Final Step: Now you can explore the app with mouse.
### Option2:
*Our team can provide a iphone which deploy the App to demonstrate each function
