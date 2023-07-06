import sys
from itertools import combinations

input = sys.stdin.readline
dx = [-1, 1, 0, 0]
dy = [0, 0, 1, -1]

n = int(input())
board = []
for i in range(n):
    board.append(list(map(int, input().split())))
answer = 1e9

coor = []
for y in range(n):
    for x in range(n):
        coor.append((x, y))

combis = list(combinations(coor, 3))


def check(x, y):
    return x >= 0 and x < n and y >= 0 and y < n


def flower_open(x, y):
    open_answer = [(x, y)]
    for i in range(4):
        nx = x + dx[i]
        ny = y + dy[i]
        open_answer.append((nx, ny))
    return open_answer


for combi in combis:
    visited = [[0] * n for _ in range(n)]
    total_leaves = []
    fflag = True
    for flower in combi:
        flag = True
        leaves = flower_open(flower[0], flower[1])
        for leaf in leaves:
            if not check(leaf[0], leaf[1]):
                flag = False
                break
            if visited[leaf[1]][leaf[0]] == 1:
                flag = False
                break
            visited[leaf[1]][leaf[0]] = 1
        if flag == False:
            fflag = False
            break
        total_leaves.append(leaves)
    if fflag:
        temp = 0
        for ll in total_leaves:
            for l in ll:
                temp += board[l[1]][l[0]]
        answer = min(answer, temp)

print(answer)
