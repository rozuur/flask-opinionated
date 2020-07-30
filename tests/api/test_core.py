def test_health(client, app):
    url_prefix = app.config["API_URL_PREFIX"]
    # test that viewing the page renders without template errors
    assert client.get(f"/{url_prefix}/api/v1/core/health").status_code == 200
    assert client.get(f"/{url_prefix}/api/v1/core/info").status_code == 200
