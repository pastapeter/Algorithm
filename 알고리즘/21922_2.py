import sys
from collections import deque

sys.setrecursionlimit(10**7)
input = sys.stdin.readline
dx = [-1, 1, 0, 0]
dy = [0, 0, 1, -1]
n, m = map(int, input().split())
board = []

air_board = [[[0 for _ in range(m)] for _ in range(n)] for _ in range(4)]
for i in range(n):
    board.append(list(map(int, input().split())))
aircondition = []
for y in range(n):
    for x in range(m):
        if board[y][x] == 9:
            aircondition.append((x, y))


def check(x, y):
    return x >= 0 and x < m and y >= 0 and y < n


def cd(i, dir):
    if i == 0 or i == 9:
        return dir
    elif i == 1:
        if dir == 1:
            return 0
        elif dir == 0:
            return 1
        else:
            return dir
    elif i == 2:
        if dir == 2:
            return 3
        elif dir == 3:
            return 2
        else:
            return dir
    elif i == 3:
        if dir == 0:
            return 2
        elif dir == 1:
            return 3
        elif dir == 2:
            return 0
        else:
            return 1
    elif i == 4:
        if dir == 0:
            return 3
        elif dir == 1:
            return 2
        elif dir == 2:
            return 1
        else:
            return 0


def bfs(start):
    queue = deque()
    for i in range(4):
        queue.append((start[0], start[1], i))
        air_board[i][start[1]][start[0]] = True

    while queue:
        poped = queue.popleft()
        nx = poped[0] + dx[poped[2]]
        ny = poped[1] + dy[poped[2]]

        if not check(nx, ny):
            continue

        ndir = cd(board[ny][nx], poped[2])
        if air_board[ndir][ny][nx] == 0:
            air_board[ndir][ny][nx] = 1
            queue.append((nx, ny, ndir))


for y in range(n):
    for x in range(m):
        if board[y][x] == 9:
            bfs((x, y))

answer = 0
for y in range(n):
    for x in range(m):
        if (
            air_board[0][y][x] == 1
            or air_board[1][y][x] == 1
            or air_board[2][y][x] == 1
            or air_board[3][y][x] == 1
        ):
            answer += 1

print(answer)
