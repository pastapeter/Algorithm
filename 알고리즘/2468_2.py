import sys
import copy
from collections import deque

input = sys.stdin.readline

n = int(input())
board = []
for i in range(n):
    board.append(list(map(int, input().split())))

maxInt = 0
minInt = 101
answer = 1


def check(x, y):
    return x >= 0 and x < n and y >= 0 and y < n


def bfs(height):
    new_board = copy.deepcopy(board)

    for y in range(n):
        for x in range(n):
            if new_board[y][x] <= height:
                new_board[y][x] = height

    dx = [-1, 1, 0, 0]
    dy = [0, 0, 1, -1]
    visited = [[0] * n for _ in range(n)]

    result = 0
    for y in range(n):
        for x in range(n):
            if new_board[y][x] != height and visited[y][x] == 0:
                result += 1
                q = deque()
                q.append([x, y])
                visited[y][x] = 1
                while q:
                    now = q.popleft()
                    for i in range(4):
                        nx = now[0] + dx[i]
                        ny = now[1] + dy[i]

                        if (
                            check(nx, ny)
                            and visited[ny][nx] == 0
                            and new_board[ny][nx] != height
                        ):
                            q.append([nx, ny])
                            visited[ny][nx] = 1
    return result


for y in range(n):
    maxInt = max(maxInt, max(board[y]))
    minInt = min(minInt, min(board[y]))

for height in range(minInt, maxInt + 1):
    answer = max(answer, bfs(height))

print(answer)
