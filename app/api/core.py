import typing

from flask import current_app

from app.api import bp


@bp.route("/core/health")
def health() -> typing.Dict[str, typing.Any]:
    """Returns health status of app
    ---
    tags:
      - core
    responses:
        200:
            description: successful response
    """
    return {"status": "ok"}


@bp.route("/core/info")
def info() -> typing.Dict[str, typing.Any]:
    """Returns version and git info
        ---
        tags:
          - core
        responses:
            200:
                description: successful response
        """
    version = current_app.config["VERSION"]
    git = current_app.config["GIT"]
    return {"version": version, "git": git}
