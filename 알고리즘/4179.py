import sys
from collections import deque

# 이 문제는 근데 약간 문제에 흠이 있는게
# 지훈이가 불을 못봤을때 불이 먼저 움직이면 죽는거 아님? 이라는 생각이 들었다.
# 하지만 각 단계에서 지훈이가 불을 먼저봤다고 생각하고, 움직인다고 가정한다.
# 그래서 처음에 start를 선정할떄, 지훈이를 무조건 앞에다 두고
# 그 뒤에 불의 움직임을 두는 게 좋다.
# 그리고 시간을 같이 tracking 하면서 지훈이가 빠져나갈 수 있게한다.
# 보드 자체에 지훈이가 간자리를 표시하기 떄문에 거기는 불이 번질 수 있다.
# 그리고 여러 J가 board에 있을지라도 J 1개가 살아남거나, 어려개가 살아남더라도 min만 구하면 되는 문제이다.

input = sys.stdin.readline
dx = [-1, 1, 0, 0]
dy = [0, 0, 1, -1]

r, c = map(int, input().split())
board = []
visited = [[0] * c for _ in range(r)]
answer = 1e9
for y in range(r):
    board.append(list(map(str, input().rstrip())))


def check(x, y):
    return x >= 0 and x < c and y >= 0 and y < r


def escape(x, y):
    return x == 0 or y == 0 or x == c - 1 or y == r - 1


def bfs(starts):
    global answer
    queue = deque()
    for start in starts:
        queue.append(start)

    while queue:
        poped = queue.popleft()

        if board[poped[1]][poped[0]] == "F":
            for i in range(4):
                nx = poped[0] + dx[i]
                ny = poped[1] + dy[i]

                if not check(nx, ny):
                    continue
                if board[ny][nx] == "#":
                    continue
                if board[ny][nx] == "." or board[ny][nx] == "J":
                    board[ny][nx] = "F"
                    queue.append((nx, ny, poped[2] + 1))

        elif board[poped[1]][poped[0]] == "J":
            if escape(poped[0], poped[1]):
                answer = min(answer, poped[2])
            for i in range(4):
                nx = poped[0] + dx[i]
                ny = poped[1] + dy[i]

                if not check(nx, ny):
                    continue
                if board[ny][nx] == "#":
                    continue
                if board[ny][nx] == ".":
                    board[ny][nx] = "J"
                    queue.append((nx, ny, poped[2] + 1))


first = deque()
for y in range(r):
    for x in range(c):
        if board[y][x] == "J":
            first.appendleft((x, y, 1))
        elif board[y][x] == "F":
            first.append((x, y, 1))

bfs(list(first))
if answer == 1e9:
    print("IMPOSSIBLE")
else:
    print(answer)
