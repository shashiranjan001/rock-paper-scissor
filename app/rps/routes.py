from flask import Blueprint, jsonify
from . import rockPaperScissor
import json


rps = Blueprint('rps', __name__)

# Handler for rock paper scissor
# Accept request for all path with verb GET
# Store the path in to randomStr variable
@rps.route('/', defaults={'randomStr': ''}, methods=['GET'])
@rps.route('/<path:randomStr>')
def rps_handler(randomStr):
    output = rockPaperScissor(randomStr)
    response = jsonify(output)
    response.status_code = 200
    return response     
