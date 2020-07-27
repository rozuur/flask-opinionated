from flask import current_app

from app.api import bp


@bp.route("/core/health")
def health():
    return {"status": "ok"}


@bp.route("/core/info")
def info():
    version = current_app.config["VERSION"]
    git = current_app.config["GIT"]
    return {"version": version, "git": git}
