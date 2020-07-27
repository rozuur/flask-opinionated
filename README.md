# Tutorial

Follow [The Flask Mega-Tutorial Part I: Hello, World!](https://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-i-hello-world)

# Local Development

Application runs on port **12121**

Invoke `./develop_using.sh` script with corresponding environment. 
For local development use `./develop_using.sh local`.

### Docker

To build docker image run `docker build . -f ./tools/Dockerfile`

To run the app at port 8000 use `docker run --rm -it -p12121:12121 $(docker build -q . -f ./tools/Dockerfile)`

### uwsgi
To test locally run `uwsgi --ini uwsgi.ini --http :12121`

# Testing