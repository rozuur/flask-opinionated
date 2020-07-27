from app.api import bp


@bp.route("/core/health")
def health():
    return {"status": "ok"}


@bp.route("/core/info")
def info():
    return {"status": "ok"}
