import re

from flask import Flask

from config import Config


def create_app(config_class: Config) -> Flask:
    app = Flask(__name__)
    app.config.from_object(config_class)
    url_prefix = config_class.API_URL_PREFIX
    if not re.match("^[a-zA-Z0-9-]+$", url_prefix):
        raise ValueError(f"url_prefix={url_prefix} has invalid characters")

    # Expose endpoints from api module
    from app.api import bp as api_bp

    app.register_blueprint(api_bp, url_prefix=f"/{url_prefix}/api/v1")

    return app
