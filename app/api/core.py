from flask import jsonify, request

from app.api import bp


@bp.route("/headers")
def view_headers():
    headers = dict(request.headers.items())
    return jsonify(headers)
