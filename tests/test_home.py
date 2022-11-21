from app import create_app


def test_same_winner_for_same_input():
    """
    GIVEN a Flask application configured for testing
    WHEN the '/' page is requested (GET)
    THEN check that the response is same for same 
    """
    flask_app = create_app('testing')

    # Create a test client using the Flask application configured for testing
    with flask_app.test_client() as test_client:
        response1 = test_client.get('/random-str')
        assert response1.status_code == 200
        response2 = test_client.get('/random-str')
        assert response2.status_code == 200
        assert response1.data == response2.data

    with flask_app.test_client() as test_client:
        response1 = test_client.post('/random-str')
        assert response1.status_code == 405

def test_wrong_method():
    """
    GIVEN a Flask application configured for testing
    WHEN the '/' page is requested (POST)
    THEN check that the response is has status code 405
    """
    flask_app = create_app('testing')

    # Create a test client using the Flask application configured for testing
    with flask_app.test_client() as test_client:
        response1 = test_client.post('/random-str')
        assert response1.status_code == 405             