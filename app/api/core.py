from app.api import bp


@bp.route("/health")
def health():
    return {"status": "ok"}
