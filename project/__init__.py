from flask import Flask

def create_app(config_filename=None):
    # Create the Flask application
    app = Flask(__name__)
    return app
    
app = create_app() 