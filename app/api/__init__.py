from flask import Blueprint

bp = Blueprint("api", __name__)

# The bottom import is a workaround to circular imports, a common problem
# with Flask applications. Also ignore static analysis checks using #noqa
from app.api import core  # noqa
