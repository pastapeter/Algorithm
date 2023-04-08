import sys
from collections import deque

input = sys.stdin.readline

# 문제 15685
# 단순히 규칙을 찾으면 되는 문제이다.
# 세대가 올라갈때, 0세대 중 시작지점을 제외한 나머지를 거꾸로한다면,
# 세대에서 그릴 새로운 드래곤 커브를 찾을 수 있다.
# 그러면 이제 돌리기만 하면되는데, 
# 돌리는 것은 시계방향으로 돌리면 되므로, dx, dy에 규칙에 맞게 적어주면 된다.
# 그리고 set을 활용해서 x,y 좌표 중복값을 뺴주고
# 사각형을 찾으면 된다.

n = int(input())
# x, y, d, g -> 시작점, 시작방향, 세대
dx = [1,0,-1,0]
dy = [0,-1,0,1]
infos = []
res = set()
ans = 0
for i in range(n):
    infos.append(list(map(int, input().split())))

for info in infos:
    x, y = info[0], info[1]
    dir = info[2]
    gen = info[3]

    queue = deque()
    queue.append((x, y, dir))
    new = (x + dx[dir], y+ dy[dir], dir)
    queue.append(new)

    for g in range(gen):

        dirs = []
        for poped in list(queue)[1:]:
            dirs.append(poped[2])
        
        newDirs = [ (i + 1)%4 for i in dirs[::-1] ]

        for i in newDirs:
            lastEle = queue[len(queue)-1]
            x = lastEle[0]
            y = lastEle[1]
            nx = x + dx[i]
            ny = y + dy[i]
            queue.append((nx, ny, i))
    
    for ele in queue:
        res.add((ele[0], ele[1]))


for coor in res:
    temp = [coor, (coor[0]+1, coor[1]), (coor[0], coor[1]+1), (coor[0]+1, coor[1]+1)]
    if len(res.intersection(set(temp))) == 4:
        ans += 1

print(ans)


