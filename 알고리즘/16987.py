import sys

input = sys.stdin.readline

# 틀린제출 -> 5
# 계란으로 계란치면, 내구도는 상대 계란의 무게만큼
# if 내구도 <= 0: 깨짐
# 왼쪽 계란
# 계란으로 깨지지 않은 다른 계란을 친다.
# 손에 든 계란이 깨졌거나 깨지지 않은 다른 계란이 없으면 치지 않고 넘어간다.
# 내려놓고, 3번 과정을 진행한다.
eggs = []
n = int(input())
answer = 0

for i in range(n):
    s, w = map(int, input().split())
    eggs.append([s, w])


def backtracking(hand, eggs):
    global answer
    if hand == n:
        temp = 0
        for e in eggs:
            if e[0] <= 0:
                temp += 1
        answer = max(answer, temp)
        return

    if eggs[hand][0] <= 0:
        backtracking(hand + 1, eggs)
    else:
        flag = False
        for i in range(n):
            if i == hand:
                continue
            elif eggs[i][0] > 0:
                flag = True
                eggs[i][0] -= eggs[hand][1]
                eggs[hand][0] -= eggs[i][1]
                # 계란을 왼쪽부터 차례로 들어서 한번씩만 아무계란 치는거라서
                # 쳤으면 옆으로 이동해야함...
                # 문제를 잘읽자
                backtracking(hand + 1, eggs)
                eggs[i][0] += eggs[hand][1]
                eggs[hand][0] += eggs[i][1]

        if flag == False:
            backtracking(hand + 1, eggs)


backtracking(0, eggs)
print(answer)
