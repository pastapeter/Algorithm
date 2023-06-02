import sys

input = sys.stdin.readline

# 0의개수, 1의 개수는 모두 짝수
# 절반의 0이랑 절반의 1을 지울거임
# 사전순으로 가장 빠른 것을 구하시오

S = input()
zeroCnt = 0
oneCnt = 0
for num in S:
    if num == "0":
        zeroCnt += 1
    elif num == "1":
        oneCnt += 1
zeroCnt = zeroCnt / 2
oneCnt = oneCnt / 2
temp = ""
for num in reversed(S):
    if zeroCnt > 0 and num == "0":
        zeroCnt -= 1
        continue
    temp += num
temp2 = ""
for num in reversed(temp):
    if oneCnt > 0 and num == "1":
        oneCnt -= 1
        continue
    temp2 += num

print(temp2[:-1])
