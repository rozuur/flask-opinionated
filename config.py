import configparser
import os

basedir = os.path.abspath(os.path.dirname(__file__))


def _read_config(path):
    config = configparser.ConfigParser()
    try:
        with open(path) as f:
            config.read_file(f)
        return config
    except FileNotFoundError:
        return None


def _version():
    config = _read_config(os.path.join(basedir, "bumpversion.cfg"))
    if not config:
        return ""
    return config["bumpversion"]["current_version"]


def _git():
    config = _read_config(os.path.join(basedir, "git.cfg"))
    if not config:
        return {}
    return dict(config["git"])


class Config(object):
    API_URL_PREFIX = "flask-opinionated"
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'you-will-never-guess'
    VERSION = _version()
    GIT = _git()
