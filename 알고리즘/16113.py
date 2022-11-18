import sys
input = sys.stdin.readline

N = int(input())
signal = input()
map = [[0]*(N//5) for _ in range(5)]
signalIdx = 0

def str2Num(str):
    if str == '#':
        return 1
    else: return 0

for y in range(5):
    for x in range(N//5):
        map[y][x] = str2Num(signal[signalIdx])
        signalIdx += 1

    print(map[y])

def isEmpty(index):
    for y in range(5):
        if map[y][index] == 1:
            return False
    return True

def isFull(index):
    for y in range(5):
        if map[y][index] == 0:
            return False
    return True

def isZero(start, end):
    mid = (start + end) // 2
    startList = []
    for i in range(5):
        startList.append(map[i][mid])
    return isFull(start) and isFull(end) and startList == [1,0,0,0,1]

def isOne(start):
    if start+1 < N//5:
        return isFull(start) and isEmpty(start+1)
    return isFull(start)

def istwo(start, end):
    return map[1][start] == 0 and map[3][end] == 0

def isThree(start, end):
    startList = []
    for i in range(5):
        startList.append(map[i][start])
    return isFull(end) and startList == [1,0,1,0,1]

def isFour(start, end):
    mid = (start + end) // 2
    startList = []
    for i in range(5):
        startList.append(map[i][mid])
    return isFull(end) and startList == [0,0,1,0,0]

def isFive(start, end):
    return map[3][start] == 0 and map[1][end] == 0

def isSix(start, end):
    return isFull(start) and map[1][end] == 0

def isSeven(start, end):
    startList = []
    for i in range(5):
        startList.append(map[i][start])
    return isFull(end) and startList == [1,0,0,0,0]

def isEight(start, end):
    mid = (start + end) // 2
    startList = []
    for i in range(5):
        startList.append(map[i][mid])
    return isFull(start) and isFull(end) and startList == [1,0,1,0,1]

def isNine(start, end):
    mid = (start + end) // 2
    midList = []
    startList = []
    for i in range(5):
        midList.append(map[i][mid])
        startList.append(map[i][start])
    return isFull(end) and midList == [1,0,1,0,1] and startList == [1,1,1,0,1]

def findNum(start, end):
    boolist = []
    funcList = [isZero, isOne, istwo, isThree, isFour, isFive, isSix, isSeven, isEight, isNine]

    for i in range(len(funcList)):
        if i == 1:
            boolist.append(funcList[i](start))
        else:
            boolist.append(funcList[i](start, end))
    return boolist.index(True)

def solution():
    answer = ""
    pointer = 0
    while pointer < N//5:
        if not isEmpty(pointer):
            if pointer + 2 >= N//5:
                if isOne(pointer):
                    answer += '1'
                    pointer += 2
            else:
                number = findNum(pointer, pointer+2)
                if number == 1: pointer += 2
                else: pointer += 4
                answer += f'{number}'
        else :
            pointer += 1
        

    return answer

print(solution())







