# App Backend
We will use assignment 1 as the starting point to build the backend.
The Backend will provide database access. Database will preserve after app restart.

Front-End mobile app can fetch event, resources and homepage data from Backend.
Front-End mobile app can save which resources or event has been bookmarked by which user to Backend.

Backend also has GUI for admin to update the database.
Admin can see all event, resources and homepage data thought GUI Admin page.
Admin can delete any event, resources and homepage data thought GUI Admin page.
Admin can add event, resources and homepage data thought GUI Admin page.

# docker
To start:

`docker build -t youthline-backend .`

`docker run -d --name youthline-backend-container -p 80:80 youthline-backend:latest`

`docker start youthline-backend-container`

To stop/remove container:

`docker stop youthline-backend-container`

`docker rm youthline-backend-container`

To restart container:

`docker stop youthline-backend-container;docker rm youthline-backend-container;docker build -t youthline-backend .;docker run -d --name youthline-backend-container -p 80:80 youthline-backend:latest;docker start youthline-backend-container`

# heroku
`heroku login`

`heroku create --app youthline-test-server`

`heroku container:login`

`heroku container:push web --app youthline-test-server`

`heroku container:release web --app youthline-test-server`

`heroku open --app youthline-test-server`

# Heroku URL: 

http://youthline-test-server.herokuapp.com/

# API

## Event 
### Fetch All Event
"GET" at /event
```json
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
```

## Post new Event
"Post" at /event

## Delete Event
"Delete" at /event

## Fetch All Resources
"Get" at /resources

## Delete Resources
"Delete" at /resources

## Post new Resources
"Post" at /Resources

## Fetch Home
"Get" at /home

## Delete Home
"Delete" at /home

## Post Home
"Post" at /home
## Admin Password Verifycation
"POST" at /pw
## Delete Resources
