import sys
from collections import deque

input = sys.stdin.readline
r,c,t = map(int, input())
dx = [1, -1, 0 , 0]
dy = [0, 0, 1, -1]

# 공기청정기 설치 위치는 -1
board = []
for _ in range(r):
    board.append(list(map(int, input().split())))

# isrange
def isRange(x: int, y: int):
    return 0 <= x < c and 0 <= y < r

# 미세먼지 확산
def bfs(x: int,y: int):
    queue = deque()
    visited = set()
    queue.append([x,y])
    visited.add([x,y])

    while queue:
        poped = queue.popleft()
        x = poped[0]
        y = poped[1]
        spread = []

        for i in range(4):

            nx = x + dx[i]
            ny = y + dy[i]

            if not isRange(nx, ny):
                continue
            if board[ny][nx] != -1 and board[ny][nx] not in visited:
                spread.append([nx, ny])
        
        # 확산되는 양은 A // 5
        spreadAmount = board[y][x] // 5
        # y, x에 남은 양은 -= 확산양 * spread 갯수
        board[y][x] -= spreadAmount * len(spread)
        # 빼줬으면, 확산시켜야함 -> 각 칸에 더하기
        for coor in spread:
            board[coor[1]][coor[0]] += spreadAmount

# 공기청정기 작동
dx = [1, 0, -1, 0]
dy = [0, -1, 0, 1]
def surqulateUP(x:int, y:int, dir: int, temp: int):

    nx = x + dx[dir]
    ny = y + dy[dir]
    
    if board[ny][nx] != -1:
        return
    
    if not isRange(nx, ny):
        surqulateUP(x, y, (dir+1)%5, board[y][x])
    else:
        next = board[ny][nx]
        board[ny][nx] = temp
        surqulateUP(nx, ny, dir, next)
        