import sys

input = sys.stdin.readline

n = int(input())
board = []
for _ in range(n):
    board.append(list(map(int, input().split())))
total = 0
for y in board:
    total += sum(y)
ans = int(1e9)

def calculate(row, col, d1, d2):
    global total, ans
    one, two, three, four = 0, 0, 0, 0

    col1 = col+1
    for r in range(row+d1):
        if r >= row:
            col1 -= 1
        one += sum(board[r][:col1])

    col2 = col + 1
    for r in range(row+d2+1):
        if r > row:
            col2 += 1
        two += sum(board[r][col2:])
    
    col3 = col-d1
    for r in range(row+d1, n):
        three += sum(board[r][:col3])
        if r < row+d1+d2:
            col3 += 1
    
    col4 = (col+d2)-n
    for r in range(row+d2+1, n):
        four += sum(board[r][col4:])
        if r <= row+d1+d2:
            col4 -= 1

    five = total - (one + two + three + four)
    arr = [one, two, three, four, five]
    arr.sort()

    ans = min(ans, arr[4] - arr[0])


def check(r,c,d1,d2):
    if 0<= r+d1-1 < n and 0 <= r+d2-1 < n and 0<= c-d1+d2-1<n:
        if 0 <= c-d1 and c+d2 < n and r+d1+d2 < n:
            calculate(r,c,d1,d2)


for r in range(n-2):
    for c in range(1, n-1):
        for d1 in range(1, n-1):
            for d2 in range(1, n-1):
                check(r,c,d1,d2)

print(ans)