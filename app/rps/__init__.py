
# Mapping Rock, Paper and Scissor to 0,1,2 respectively
rps_dict = {0: 'Rock', 1: 'Scissor', 2: 'Paper'}

# Generate a game
# Generates values for both players
# Return winner based on the above values
def rockPaperScissor(randomStr: str):
    # Generate hased number for player 1 using prime number 31
    p1_val = hash(randomStr, 31)%3

     # Generate hased number for player 2 using prime number 29
    p2_val = hash(randomStr, 29)%3
    
    p1 = "player_1:" + rps_dict[p1_val]
    p2 = "player_2:" + rps_dict[p2_val]  

    return [p1,p2,rps(p1_val, p2_val)]

# Calculate hash of string based on a prime number p
def hash(input: str, p: int) -> int:
    hash_so_far = 0
    pow = 1
    modulo =10**9 + 7
    for i in range(len(input)):
        hash_so_far = (hash_so_far + (1 + ord(input[i]) - ord('a')) * pow) % modulo
        pow = (pow * p) % modulo
    return hash_so_far 

# Algorithm for deciding rock paper scissor winner
def rps(p1_val, p2_val : int) -> str:
    if p1_val == p2_val:
        return "The match is drawn"
    if p1_val < p2_val:
        if p2_val - p1_val == 2:
            return "Player 2 won !"
        return "Player 1 won !"
    if p1_val - p2_val == 2:
        return "Player 1 won !"
    return "Player 2 won !"
