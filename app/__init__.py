from flask import Flask
from app.config import TestingConfig, DevelopmentConfig, ProductionConfig
import os
# blueprints
from app.errors.handlers import errors
from app.home.routes import home


app = Flask(__name__)
app.config.from_object(DevelopmentConfig)

app.register_blueprint(errors)
app.register_blueprint(home)


def create_app(mode):
    app = Flask(__name__)
    app.config.from_object(DevelopmentConfig if mode == 'dev' else TestingConfig)

    from app.errors.handlers import errors
    from app.home.routes import home

    app.register_blueprint(errors)
    app.register_blueprint(home)

    return app
