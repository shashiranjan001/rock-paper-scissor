from project import create_app

def test_default_handler():
    app = create_app()
    response = app.test_client().get("/home")
    print(response.data)
    assert 1==2
