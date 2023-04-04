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
    rotate()
    removeRobot()
    moveRobot()
    removeRobot()
    loadRobot()
    if isterminated():
        break
    

print(turn)
