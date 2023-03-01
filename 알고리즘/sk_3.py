import sys
si = sys.stdin.readline
n = int(si())
a = [list(map(int, si().split())) for _ in range(n)]
dir = ((1, 0), (0, 1), (-1, 0), (0, -1))
sx, sy = 0, 0  # 시작 위치
total_blank = 0  # 총 빈 칸의 개수
for i in range(n):
    for j in range(n):
        if a[i][j] == 2:
            sx, sy = i, j
        if a[i][j] != 0:
            total_blank += 1
ans = False  # 가능한 방법이 있는가?
def in_range(x, y):
    return 0 <= x < n and 0 <= y < n
def get_cells(x, y, k):  # x, y 에서 k 방향으로 쭈우우욱 갔을 때, 지나는 위치들 & 도착점
    res = []
    while True:
        nx, ny = x + dir[k][0], y + dir[k][1]
        if not in_range(nx, ny) or a[nx][ny] != 1:  # 더 이상 진행할 수 없는 경우
            break
        x, y = nx, ny
        res.append((x, y))
    return x, y, res
def backtracking(x, y, cnt):  # cnt := 지금까지 남긴 흔적의 개수
    global ans
    if cnt == total_blank:
        ans = True
        return
    if ans:  # 이미 가능한 방법을 찾았다면, 더 이상 탐색할 필요가 없다.
        return
    
    for k in range(4):
        nx, ny, cells = get_cells(x, y, k)  # x, y 에서 k 방향으로 이동했을 때, 새롭게 남기는 흔적 위치들
        if not cells:
            continue
        
        for cx, cy in cells:  # k 번 방향으로 이동할 때 생기는 흔적 남기기
            a[cx][cy] = 2
        
        backtracking(nx, ny, cnt + len(cells))
        for cx, cy in cells:  # k 번 방향으로 이동할 때 생기는 흔적 복원하기
            a[cx][cy] = 0
backtracking(sx, sy, 1)
if ans:
    print("YES")
else:
    print("NO")