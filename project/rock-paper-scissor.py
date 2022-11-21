from flask import jsonify
from . import app


@app.route('/home')
def home():
    return 'Hello World!'

# @app.route('/', defaults={'randomStr': ''}, Methods=["GET"])
# @app.route('/<path:randomStr>')
# def deafult_handler(randomStr):
#     out = rockPaperScissor(randomStr)
#     print("Winner = %d" % out)
#     response = jsonify("The winner for string '%s': player %d" % (randomStr, out))
#     response.status_code = 200
#     return response 

def rockPaperScissor(randomStr: str) -> int:
    p1_val = hash(randomStr, 31)%3
    p2_val = hash(randomStr, 29)%3

    print("p1 = %d | p2 = %d" % (p1_val, p2_val))

    if p1_val == p2_val:
        return 0
    if p1_val < p2_val:
        if p2_val - p1_val == 2:
            return 2
        return 1
    if p1_val - p2_val == 2:
        return 1
    return 2

def hash(input: str, p: int) -> int:
    hash_so_far = 0
    pow = 1
    modulo =10**9 + 7
    for i in range(len(input)):
        hash_so_far = (hash_so_far + (1 + ord(input[i]) - ord('a')) * pow) % modulo
        pow = (pow * p) % modulo
    return hash_so_far 
