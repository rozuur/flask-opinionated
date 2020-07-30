import pytest

from app import create_app
from config import Config


def test_creation():
    conf = Config()
    conf.API_URL_PREFIX = "invalid with spaces"
    with pytest.raises(ValueError, match="url_prefix"):
        create_app(conf)
