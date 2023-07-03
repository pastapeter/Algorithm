import sys
from collections import deque
import copy

input = sys.stdin.readline

# 빨간구슬만
# 동시에 같은칸 X
# 더이상 구슬이 움직이지 않을때까지
# 왼, 오, 아래, 위
dx = [-1, 1, 0, 0]
dy = [0, 0, 1, -1]

n, m = map(int, input().split())
# . 빈칸, # 벽, 0 구멍, R은 빨간 구슬의 위치, B는 파란 구슬의 위치
board = []
for y in range(n):
    board.append(list(input().rstrip()))

visited_red = [[0] * m for _ in range(n)]
visited_blue = [[0] * m for _ in range(n)]

# 두개의 공을 움직이는 경우, 어떻게 해야하는지에 대한 문제이다.
# 새로운 문제였기에, 꽤 어려웠다.
# 두개의 공을 움직이는 경우, Visited 배열을 각각 운영해야한다.
# queue를 다르게 운영? 해도 괜찮을 것 같긴하다.
# 중요한 것은 공 2개가 동일 선상에 있을때,
# 위치 판단이다.
# 처음에는 방향에 있어서 앞에있는 것을 먼저움직이는 방법이 있다.
# 이 방법을 썻다가 그러면 R,B까지 운영해야해서
# 둘다 움직이고, 더 많이 움직인 것이 뒤에 있는 공이라고 생각하고, 더 많이 움직인 것을
# 한칸 물린다.


def check(x, y):
    return board[y][x] != "#"


# 이 get_cells 라는 함수는 외워두는 것이 좋다.
def get_cells(start, dir):
    x = start[0]
    y = start[1]
    cells = []

    while True:
        nx = x + dx[dir]
        ny = y + dy[dir]
        if not check(nx, ny):
            return x, y, cells
        if board[ny][nx] == "O":
            return nx, ny, [(nx, ny)]
        x = nx
        y = ny
        cells.append((x, y))

    return x, y, cells


def move_ball(red_ball, blue_ball, dir):
    x1, y1, cells1 = get_cells(red_ball, dir)
    x2, y2, cells2 = get_cells(blue_ball, dir)

    if x1 == x2 and y1 == y2:
        if board[y1][x1] != "O":
            if len(cells1) > len(cells2):
                x1 -= dx[dir]
                y1 -= dy[dir]
            else:
                x2 -= dx[dir]
                y2 -= dy[dir]
    return x1, y1, x2, y2


# 이렇게 하는 bfs가 방향이 정해진 bfs이다.
# dfs로도 풀릴 수 있을 것 같다.
def bfs(red_start, blue_start):
    queue = deque()
    queue.append((red_start[0], red_start[1], blue_start[0], blue_start[1], 0))
    visited_red[red_start[1]][red_start[0]] = 1
    visited_blue[blue_start[1]][blue_start[0]] = 1

    while queue:
        # 하나만 움직일 수 있다.
        poped = queue.popleft()
        red_x, red_y, blue_x, blue_y = poped[0], poped[1], poped[2], poped[3]

        if poped[4] > 10:
            return -1

        if board[red_y][red_x] == "O" and board[blue_y][blue_x] != "O":
            return poped[4]

        # bfs에서 좀 중요한 점은 board배열을 변경하면 골치아파진다는 것이다.
        for i in range(4):
            new_rx, new_ry, new_bx, new_by = move_ball(
                (red_x, red_y), (blue_x, blue_y), i
            )

            if visited_red[new_ry][new_rx] == 1 and visited_blue[new_by][new_bx] == 1:
                continue
            visited_red[new_ry][new_rx] == 1
            visited_blue[new_by][new_bx] == 1
            # 이 경우, 무조건 return 하는 것이 아니라, 다른경우에 해답이 있을 수 있기에,
            # continue 시킨다.
            if board[new_by][new_bx] == "O" and board[new_ry][new_rx] != "O":
                continue
            if board[new_ry][new_rx] == "O" and board[new_by][new_bx] == "O":
                continue
            queue.append((new_rx, new_ry, new_bx, new_by, poped[4] + 1))

    return -1


red = (0, 0)
blue = (0, 0)
for y in range(n):
    for x in range(m):
        if board[y][x] == "R":
            red = (x, y)
        elif board[y][x] == "B":
            blue = (x, y)

print(bfs(red, blue))
