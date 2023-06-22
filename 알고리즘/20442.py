import sys

input = sys.stdin.readline

# R로만 이뤄진 문자열은 ㅋㅋ루ㅋㅋ, 근데 빈문자열은 ㅋㅋ루ㅋㅋ 문자열이 아니다?
# 양끝에 K를 하나씩 붙인 문자열은 ㅋㅋ루ㅋㅋ
# ㅋㅋ루ㅋㅋ가 없는 경우

# KRKK
# RRKRR
s = list(input().rstrip())
lk = []  # 왼쪽에 k의 개수
rk = []  # 오른쪽에 k의 개수
kcnt = 0
# r의 위치에서 k의 갯수
for i in s:
    if i == "K":
        kcnt += 1
    elif i == "R":
        lk.append(kcnt)
# 그래서 n번째 R에서 왼쪽 k의 개수를 확인가능
kcnt = 0
for i in reversed(s):
    if i == "K":
        kcnt += 1
    elif i == "R":
        rk.append(kcnt)
rk.sort(reverse=True)
# 마찬가지로 n번째 R에서 오른쪽 k의 개수를 확인가능

left = 0
right = len(rk) - 1
max_int = 0

# k말고 R부터 돌리는듯 왜냐면, R 안에 있는 k는 부분 집합이라 신경쓰지 않음
while left <= right:
    # R~R 사이 + 각 R옆에 k의 개수 중 작은것
    max_int = max(max_int, (right - left + 1) + (2 * min(lk[left], rk[right])))
    # 이렇게 하면
    # RKKRRRRRKK 와 같은 것도 커버가 가능하다
    # 왜냐면 맨앞R로 시작했을떄는7인데, 중간 R부터 시작하면, 9까지 될 수있음
    # 뒤에 k가 더많으면
    # 앞에R를 뒤로 땡김
    # 왜냐면 중간에 k가 5개가 들어가있을수도있음
    if lk[left] < rk[right]:
        left += 1
    # 근데 그랬다가 왼쪽 k가 더 많아지면, 오른쪽에 남아있는 k를 쓰기 위해서 r를 한칸 땡김
    else:
        right -= 1

print(max_int)
