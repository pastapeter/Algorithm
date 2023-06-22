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


def airflow(x, y, dir):
    nx = x + dx[dir]
    ny = y + dy[dir]
    if check(nx, ny) and air_board[dir][ny][nx] == 0:
        air_board[dir][ny][nx] = 1
        if board[ny][nx] == 0 or board[ny][nx] == 9:
            airflow(nx, ny, dir)
        else:
            if board[ny][nx] == 1:
                if dir == 0 or dir == 1:
                    return
                else:
                    airflow(nx, ny, dir)
            elif board[ny][nx] == 2:
                if dir == 2 or dir == 3:
                    return
                else:
                    airflow(nx, ny, dir)
            # 좌 우, 아래 위 0 1 2 3
            elif board[ny][nx] == 3:
                if dir == 0:
                    airflow(nx, ny, 2)
                elif dir == 1:
                    airflow(nx, ny, 3)
                elif dir == 2:
                    airflow(nx, ny, 0)
                elif dir == 3:
                    airflow(nx, ny, 1)
            elif board[ny][nx] == 4:
                if dir == 0:
                    airflow(nx, ny, 3)
                elif dir == 1:
                    airflow(nx, ny, 2)
                elif dir == 2:
                    airflow(nx, ny, 1)
                elif dir == 3:
                    airflow(nx, ny, 0)


def solution():
    for c in aircondition:
        for i in range(4):
            airflow(c[0], c[1], i)
    for c in aircondition:
        air_board[0][c[1]][c[0]] = 1


solution()
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


# for y in range(n):
#     print(air_board[y])
print(answer)
