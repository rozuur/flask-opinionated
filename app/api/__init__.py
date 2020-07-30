""" Defines blueprint for api

   isort:skip_file
"""
from flask import Blueprint

bp = Blueprint("api", __name__)

# The bottom import is a workaround to circular imports,
# a common problem with Flask applications.
from app.api import core
