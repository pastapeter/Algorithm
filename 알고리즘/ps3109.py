import sys

input = sys.stdin.readline
r, c = map(int, input().split())
board = [list(input().strip()) for _ in range(r)]

dx = [1,1,1]
dy = [-1,0,1]
complete = 0
ans = 0

def inRange(x,y):
    return 0 <= x < c and 0 <= y < r

def getCells(x, y, dir):
    cells = []
    while True:
        nx = x + dx[dir]
        ny = y + dy[dir]
        if not inRange(nx, ny) or board[ny][nx] == "x" or board[ny][nx] == "-":
            break
        x = nx
        y = ny
        cells.append((nx, ny))
    # nx = x + dx[dir]
    # ny = y + dy[dir]
    # if not inRange(nx, ny) or board[ny][nx] == "x" or board[ny][nx] == "-":
    #     return 0, 0, cells
    # x = nx
    # y = ny
    # cells.append((nx, ny))
    return x, y, cells

def backtracking(x, y, cnt):
    global ans
    complete = ans
    if x == c-1:
        ans += 1
        return
    
    for i in range(3):
        # lx, ly, cells = getCells(x,y,i)
        # if len(cells) == 0: continue
        # for cx, cy in cells:
        #     board[cy][cx] = "-"
        # backtracking(lx, ly, cnt+len(cells))
        nx = x + dx[i]
        ny = y + dy[i]
        if inRange(nx, ny) and board[ny][nx] == ".":
            if complete != ans: return
            board[ny][nx] = "-"
            backtracking(nx,ny,cnt+1)

for i in range(r):
    backtracking(0,i,1)

print(ans)