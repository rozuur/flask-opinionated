from flasgger import Swagger

from app import create_app
from config import Config

conf = Config()
app = create_app(conf)


def swagger_config():
    title = conf.API_URL_PREFIX.replace('-', ' ').capitalize()
    return {
        "headers": [
        ],
        "title": title,
        "description": "",
        "termsOfService": "",
        "specs": [
            {
                "endpoint": 'swagger_spec',
                "route": f"/{conf.API_URL_PREFIX}/api/v1/swagger_spec",
                "rule_filter": lambda rule: True,  # all in
                "model_filter": lambda tag: True,  # all in
            }
        ],
        "static_url_path": "/flasgger_static",
        "swagger_ui": True,
        "specs_route": f"/{conf.API_URL_PREFIX}/api/v1/swagger"
    }


swagger = Swagger(app, config=swagger_config())
