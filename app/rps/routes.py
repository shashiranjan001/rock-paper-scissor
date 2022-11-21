from flask import Blueprint, jsonify
from . import rockPaperScissor


rps = Blueprint('rps', __name__)

@rps.route('/', defaults={'randomStr': ''}, methods=['GET'])
@rps.route('/<path:randomStr>')
def rps_handler(randomStr):
    response = jsonify(randomStr + ": " + rockPaperScissor(randomStr))
    response.status_code = 200
    return response     
