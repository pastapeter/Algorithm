
# 0번쨰 벨트에서 로봇을 올릴 수 있고, N-1 위치에서 로봇을 내릴 수 있다.
# 1.벨트가 각 칸 위에 있는 로봇과 함께 한 칸 회전한다.
# 2.가장 먼저 벨트에 올라간 로봇부터, 벨트가 회전하는 방향으로 한 칸 이동할 수 있다면 이동한다. 만약 이동할 수 없다면 가만히 있는다.
# 로봇이 이동하기 위해서는 이동하려는 칸에 로봇이 없으며, 그 칸의 내구도가 1 이상 남아 있어야 한다.
# 3.올리는 위치에 있는 칸의 내구도가 0이 아니면 올리는 위치에 로봇을 올린다.
# 4.내구도가 0인 칸의 개수가 K개 이상이라면 과정을 종료한다. 그렇지 않다면 1번으로 돌아간다.

# 그냥 간단한 구현 문제이다.
# python은 deque를 사용해야하는 문제이다.
# 그리고 1, 2번 진행과정에서 N-1위치에 로봇이 올 수 있기에, 그 과정 1개씩 끝나면 로봇이 n-1위치에 있는지 확인한다.
# 가장 먼저 벨트에 올라간 로봇 -> 큐에서 가장 뒤에꺼부터 조사한다.

# 시간복잡도: O(2N * K * 0을 제외한 내구성 리스트의 최소값)

import sys
from collections import deque

input = sys.stdin.readline

n, k = map(int, input().split())
A = list(map(int, input().split()))
containers = deque()
for a in A:
    containers.append([False, a])

def isterminated():
    temp = 0
    for container in containers:
        if container[1] == 0:
            temp += 1
    return temp >= k
        

def rotate():
    poped = containers.pop()
    containers.appendleft(poped)

def moveRobot():
    #가장 먼저 벨트에 올라간 로봇부터, 벨트가 회전하는 방칸이동할 수  있으면 이동
    for i in range(n):
        if containers[n - i][0] and containers[n - i + 1][1] >= 1 and containers[n - i + 1][0] == False :
            containers[n - i][0] = False
            containers[n - i + 1][0] = True
            containers[n - i + 1][1] -= 1

def loadRobot():
    if containers[0][1] >= 1:
        containers[0][0] = True
        containers[0][1] -= 1

def removeRobot():
    if containers[n-1][0]: 
        containers[n-1][0] = False

turn = 0
while True:

    turn += 1
    rotate() # O(N)
    removeRobot() #O(1)
    moveRobot() #O(N)
    removeRobot()
    loadRobot()
    if isterminated():
        break
    

print(turn)
