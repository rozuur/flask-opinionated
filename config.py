import os


class Config(object):
    API_URL_PREFIX = "flask-opinionated"
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'you-will-never-guess'
