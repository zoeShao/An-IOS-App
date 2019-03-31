# App Backend
We will use assignment 1 as the starting point to build the backend.
The Backend will provide database access. Front-End mobile app can fetch data from Backend.
Backend also has GUI for admin to update the database.

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

## Fetch All Event
"Get" at /event

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
