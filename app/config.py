import os
import string
import random


letters = string.ascii_letters

# Base config class
class BaseConfig(object):
    """base config"""
    SECRET_KEY = os.environ.get("secret_key", ''.join(
        [random.choice(string.ascii_letters + string.digits) for n in range(16)]))

# Testing config class
# Sets testing to true
class TestingConfig(BaseConfig):
    """testing config"""
    TESTING = True
    SQLALCHEMY_DATABASE_URI = ''
    DEBUG = True

# Development config class
# Sets Debug to true
class DevelopmentConfig(BaseConfig):
    """dev config"""
    DEBUG = True

# Production config class
# Debugging is set off
class ProductionConfig(BaseConfig):
    """production config"""
