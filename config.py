import configparser
import os

import typing

basedir = os.path.abspath(os.path.dirname(__file__))


def _read_config(path: str) -> configparser.ConfigParser:
    config = configparser.ConfigParser()
    try:
        with open(path) as f:
            config.read_file(f)
    except FileNotFoundError:
        pass
    return config


def _version() -> str:
    config = _read_config(os.path.join(basedir, "bumpversion.cfg"))
    if not config.sections():
        return ""
    return config["bumpversion"]["current_version"]


def _git() -> typing.Dict[str, str]:
    config = _read_config(os.path.join(basedir, "git.cfg"))
    if not config.sections():
        return {}
    return dict(config["git"])


class Config(object):
    API_URL_PREFIX = "flask-opinionated"
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'you-will-never-guess'
    VERSION = _version()
    GIT = _git()
