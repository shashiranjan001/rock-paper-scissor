def rockPaperScissor(randomStr: str) -> str:
    p1_val = hash(randomStr, 31)%3
    p2_val = hash(randomStr, 29)%3

    if p1_val == p2_val:
        return "The match is drawn"
    if p1_val < p2_val:
        if p2_val - p1_val == 2:
            return "Player 2 won !"
        return "Player 1 won !"
    if p1_val - p2_val == 2:
        return "Player 1 won !"
    return "Player 2 won !"

def hash(input: str, p: int) -> int:
    hash_so_far = 0
    pow = 1
    modulo =10**9 + 7
    for i in range(len(input)):
        hash_so_far = (hash_so_far + (1 + ord(input[i]) - ord('a')) * pow) % modulo
        pow = (pow * p) % modulo
    return hash_so_far 
