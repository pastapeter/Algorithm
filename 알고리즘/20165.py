# 도미노 (1, 5 높이)
# 공격먼저
# K인 도미노가 넘어가면, 그방향으로 K-1개가 날라감
# 도미노는 연쇄적으로 넘어감
# 넘어진 도미노가 있는 칸을 공격한 경우 아무 일이 일어나지 않음

# 수비
# 넘어져있는 도미노 새울수있음, 넘어지지않은 도미노 세우면 아무일도 안일어남

from collections import deque

dir = {"E": 1, "W": 0, "S": 2, "N": 3}
dx = [-1, 1, 0, 0]
dy = [0, 0, 1, -1]
n, m, r = map(int, input().split())
board = []
fall_board = [[1] * m for _ in range(n)]
answer = 0


def check(x, y):
    return x >= 0 and x < m and y >= 0 and y < n


def attack(x, y, dir):
    global answer
    if fall_board[y][x] == 0:
        return
    cnt = board[y][x]
    fall_board[y][x] = 0
    queue = deque()
    queue.append((x, y))
    while queue:
        poped = queue.pop()
        answer += 1
        x = poped[0]
        y = poped[1]
        poped_height = board[poped[1]][poped[0]]
        for i in range(poped_height):
            nx = x + dx[dir] * i
            ny = y + dy[dir] * i
            if check(nx, ny):
                if fall_board[ny][nx] != 0:
                    queue.append((nx, ny))
                    fall_board[ny][nx] = 0


def defense(x, y):
    fall_board[y][x] = 1


for i in range(n):
    board.append(list(map(int, input().split())))
for i in range(r):
    ay, ax, d = map(str, input().split())
    ay, ax, d = int(ay) - 1, int(ax) - 1, dir[d]
    fy, fx = map(int, input().split())
    fy, fx = fy - 1, fx - 1
    attack(ax, ay, d)
    defense(fx, fy)
print(answer)
for y in range(n):
    for x in range(m):
        if fall_board[y][x] == 1:
            print("S", end=" ")
        else:
            print("F", end=" ")
    print()
