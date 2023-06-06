import sys
from collections import deque

input = sys.stdin.readline

first = deque(map(int, input().rstrip()))
second = deque(map(int, input().rstrip()))
third = deque(map(int, input().rstrip()))
forth = deque(map(int, input().rstrip()))

# N: 0, S: 1
# 2, 6 idx

chain = {1: first, 2: second, 3: third, 4: forth}
visited = [False, False, False, False, False]


def change(index, dir):
    if dir == 1:
        temp = chain[index].pop()
        chain[index].appendleft(temp)
    else:
        chain[index].append(chain[index].popleft())


def rotate(index, dir):
    if not visited[index]:
        visited[index] = True
        if index == 4:
            if chain[index][6] != chain[index - 1][2]:
                change(index, dir)
                rotate(index - 1, -dir)
            else:
                change(index, dir)
        elif index == 1:
            if chain[index][2] != chain[index + 1][6]:
                change(index, dir)
                rotate(index + 1, -dir)
            else:
                change(index, dir)
        else:
            if (
                chain[index][6] != chain[index - 1][2]
                and chain[index][2] != chain[index + 1][6]
            ):
                change(index, dir)
                rotate(index - 1, -dir)
                rotate(index + 1, -dir)
            elif chain[index][6] != chain[index - 1][2]:
                change(index, dir)
                rotate(index - 1, -dir)
            elif chain[index][2] != chain[index + 1][6]:
                change(index, dir)
                rotate(index + 1, -dir)
            else:
                change(index, dir)


k = int(input())
answer = 0
for i in range(k):
    visited = [False, False, False, False, False]
    num, dir = map(int, input().split())
    rotate(num, dir)

if chain[1][0] == 1:
    answer += 1
if chain[2][0] == 1:
    answer += 2
if chain[3][0] == 1:
    answer += 4
if chain[4][0] == 1:
    answer += 8


print(answer)
