import sys
from collections import deque
from functools import cmp_to_key

sys.setrecursionlimit(10**6)

input = sys.stdin.readline
dx = [-1, 1, 0, 0]
dy = [0, 0, -1, 1]
# n크기 공간
# m마리 물고기, 아기상어 1마리
# 아기상어 크기 2
# 1초에 상하좌우
# 큰물고기가 있는 칸은 못지나감
# 크기가 같은 물로기는 먹을 수없다, 물고기가 있는 칸은 지나갈 수있음
# 먹을 수있는 물고기 1마리? 그 물고기
# 먹을 수 있는 물고기가 1보다 많다.?
# 가장위, 가장 왼쪽

# 중요한 점 (재귀로 풀음)
# BFS로 조건에 맞는 가장 가까운 곳을 찾는다.
# 거기로 이동한다.
# 거기서 다시 BFS로 조건에 맞는 가장 가까운 곳을 찾는다.
# 더이상 갈곳이 없을때 탈출한다.
# BFS를 계속돌리면서 가장가까운 곳을 찾아야 한다.
# 이런 유형도 있다는 것을 인지하고 있어야 한다.

# 상어가 먹은 먹이, 상어의 크기, 현재 위치, 다음 위치까지 가는 시간을 모두 Tracking 하고 있어야한다.
# 그렇기 때문에, Queue에 이렇게 5개의 정보를 모두 집어넣고 돌려야한다.


n = int(input())
board = []
for i in range(n):
    board.append(list(map(int, input().split())))
start = (0, 0)

for y in range(n):
    for x in range(n):
        if board[y][x] == 9:
            start = (x, y)


def compare(lhs, rhs):
    if lhs[3] > rhs[3]:
        return 1
    elif lhs[3] == rhs[3]:
        if lhs[2] > rhs[2]:
            return 1
        elif lhs[2] == rhs[2]:
            if lhs[1] > rhs[1]:
                return 1
            elif lhs[1] == rhs[1]:
                if lhs[0] > rhs[0]:
                    return 1
                else:
                    return -1
            else:
                return -1
        else:
            return -1
    else:
        return -1


def check(x, y):
    return x >= 0 and x < n and y >= 0 and y < n


answer = 0


def bfs(start, shark, eat_cnt):
    global answer
    visited = [[0] * n for _ in range(n)]
    visited[start[1]][start[0]] = 1
    board[start[1]][start[0]] = 0
    queue = deque()
    queue.append((start[0], start[1], 0, shark, eat_cnt))
    destin = []

    while queue:
        poped = queue.popleft()
        x = poped[0]
        y = poped[1]
        time = poped[2]
        shark_size = poped[3]
        eat = poped[4]

        if eat == shark_size:
            shark_size += 1
            eat = 0
        destin.append((x, y, time, shark_size, eat))

        for i in range(4):
            nx = x + dx[i]
            ny = y + dy[i]
            if not check(nx, ny):
                continue
            if not visited[ny][nx]:
                if board[ny][nx] == shark_size or board[ny][nx] == 0:
                    queue.append((nx, ny, time + 1, shark_size, eat))
                    visited[ny][nx] = 1
                elif board[ny][nx] < shark_size:
                    queue.append((nx, ny, time + 1, shark_size, eat + 1))
                    visited[ny][nx] = 1
    new_destin = []
    for i in destin:
        if i[4] > eat_cnt or i[3] > shark:
            new_destin.append(i)
    new_destin.sort(key=cmp_to_key(compare))
    if new_destin:
        board[new_destin[0][1]][new_destin[0][0]] = 0
        answer += new_destin[0][2]
        bfs((new_destin[0][0], new_destin[0][1]), new_destin[0][3], new_destin[0][4])
    else:
        return


bfs(start, 2, 0)
print(answer)
