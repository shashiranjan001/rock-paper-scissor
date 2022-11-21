from flask import Blueprint, jsonify
from . import rockPaperScissor


home = Blueprint('home', __name__)


# @home.route('/home')
# @home.route('/', methods=['GET', 'POST'])
# def homepage():
#     return "hello"

@home.route('/', defaults={'randomStr': ''}, methods=['GET'])
@home.route('/<path:randomStr>')
def deafult_handler(randomStr):
    response = jsonify(randomStr + ": " + rockPaperScissor(randomStr))
    response.status_code = 200
    return response     


# @home.route('/about')
# def about():
#     return render_template('about.html', title='About')
