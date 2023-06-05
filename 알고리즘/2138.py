import sys

input = sys.stdin.readline

n = int(input())
s = list(map(int, input().rstrip()))
t = list(map(int, input().rstrip()))

# 000 111 001 010
# 가운데만 하려면 가운데, 왼, 오 or 가운데, 오, 왼
# visited 각각 들고있으면 되나>?
# 근데 N이 너무커서 백트는 좀 어려움
# dp? 그리디?
# 부분최적해를 구해야하는데, 어떻게 부분 최적해를 결정할지 고려한다.
# 부분 최적해는 이전 전구 전체를 비교하지 않고, 바로 직전 인덱스의 전구를 비교하여 스위치 켤지 말지를 정할 수 있단다.

# <그냥 같으면 안바꿔도 되고, 다르면 바꿔야한다>
# 근데 왜 전꺼를 비교하는 것일까?
# 전것을 비교하는 이유는 현재것은 다음것에서도 변경이 가능하지만,
# 전것은 현재 인덱스에서 마지막으로 변경이 가능하기 때문이다
# 그래서 전것을 비교했을때, 전것이 같다면 안바꿔도되는것이고,
# 전것을 비교했을때, 다르다면, 현재인덱스에서 바꿔야할 것이다.
# 그러면 왜 첫번째를 안누르고, 누르고 차이가 다르다?
# 두경우에 따라 뒤쪽에 눌러야하는 경우의 수가 바뀐다?

# 000 -> 010
# 111 -> 100
# 110 -> 001 -> 010


def change(A, B):
    a_copy = A[:]
    press = 0
    for i in range(1, n):
        if a_copy[i - 1] == B[i - 1]:
            continue
        press += 1
        for j in range(i - 1, i + 2):
            if j < n:
                a_copy[j] = 1 - a_copy[j]
    if a_copy == B:
        return press
    else:
        return 1e9


res = change(s, t)

s[0] = 1 - s[0]
s[1] = 1 - s[1]
res = min(res, change(s, t) + 1)
if res != 1e9:
    print(res)
else:
    print(-1)
