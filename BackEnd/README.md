# App Backend
# docker
To start:

`docker build -t youthline-backend .`

`docker run -d --name youthline-backend-container -p 80:80 youthline-backend:latest`

`docker start youthline-backend-container`

To stop/remove container:

`docker stop youthline-backend-container`

`docker rm youthline-backend-container`

# heroku
`heroku login`

`heroku create --app <app-server-name>`

`heroku container:login`

`heroku container:push web --app <app-server-name>`

`heroku container:release web --app <app-server-name>`

`heroku open --app <app-server-name>`

# Heroku URL: 

https://