import sys
import copy

input = sys.stdin.readline

T = int(input())
answer = 1e9


def change(_board, i):
    board = copy.deepcopy(_board)
    if i == 0:
        board[0][0] = -board[0][0]
        board[0][1] = -board[0][1]
        board[0][2] = -board[0][2]
    elif i == 1:
        board[1][0] = -board[1][0]
        board[1][1] = -board[1][1]
        board[1][2] = -board[1][2]
    elif i == 2:
        board[2][0] = -board[2][0]
        board[2][1] = -board[2][1]
        board[2][2] = -board[2][2]
    elif i == 3:
        board[0][0] = -board[0][0]
        board[1][0] = -board[1][0]
        board[2][0] = -board[2][0]
    elif i == 4:
        board[0][1] = -board[0][1]
        board[1][1] = -board[1][1]
        board[2][1] = -board[2][1]
    elif i == 5:
        board[0][2] = -board[0][2]
        board[1][2] = -board[1][2]
        board[2][2] = -board[2][2]
    elif i == 6:
        board[0][0] = -board[0][0]
        board[1][1] = -board[1][1]
        board[2][2] = -board[2][2]
    else:
        board[0][2] = -board[0][2]
        board[1][1] = -board[1][1]
        board[2][0] = -board[2][0]
    return board


def dfs(board, cnt, depth):
    global answer
    total = 0
    for y in range(3):
        total += sum(board[y])
    if depth == 8:
        if total == 9 or total == -9:
            answer = min(answer, cnt)
        return
    if total == 9 or total == -9:
        answer = min(answer, cnt)
        return
    new_board = change(board, depth)
    dfs(new_board, cnt + 1, depth + 1)
    dfs(board, cnt, depth + 1)


for _ in range(T):
    board = []
    answer = 1e9
    for y in range(3):
        board.append(list(input().rstrip().split()))

    for y in range(3):
        for x in range(3):
            if board[y][x] == "T":
                board[y][x] = 1
            elif board[y][x] == "H":
                board[y][x] = -1

    dfs(board, 0, 0)
    if answer == 1e9:
        print(-1)
    else:
        print(answer)
