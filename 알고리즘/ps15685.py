import sys
from collections import deque

input = sys.stdin.readline

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
    
    print(queue)
    for ele in queue:
        res.add((ele[0], ele[1]))


for coor in res:
    temp = [coor, (coor[0]+1, coor[1]), (coor[0], coor[1]+1), (coor[0]+1, coor[1]+1)]
    if len(res.intersection(set(temp))) == 4:
        ans += 1

print(ans)


