from flask import Flask
from app.config import TestingConfig, DevelopmentConfig, ProductionConfig
import os
from app.errors.handlers import errors
from app.rps.routes import rps

# Initilise the flask app
app = Flask(__name__)
app.config.from_object(DevelopmentConfig)

app.register_blueprint(errors)
app.register_blueprint(rps)


# Factory function for creating app used while testing
def create_app(mode):
    app = Flask(__name__)
    app.config.from_object(DevelopmentConfig if mode == 'dev' else TestingConfig)

    from app.errors.handlers import errors
    from app.rps.routes import rps

    app.register_blueprint(errors)
    app.register_blueprint(rps)

    return app
