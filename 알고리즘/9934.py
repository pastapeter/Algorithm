# 트리 순회?
# 중위 순회에 대한 것은
# 가운데를 나누면서 재귀를 생각하면된다
# 그 외 다른 Tree 순회는 맨앞 뺴고 두개로 나누거나
# 맨뒤 뺴고 2개로 나누면서 재귀를 돌면
# 웬만하면 해결되는듯함

k = int(input())
nums = list(map(int, input().split()))
n = pow(2, k)

answers = [[] for _ in range(k)]


def get_parent(elements, depth):
    n = len(elements)
    answers[depth].append(elements[n // 2])
    if n == 1:
        elements[0]
        return
    get_parent(elements[: n // 2], depth + 1)
    get_parent(elements[n // 2 + 1 :], depth + 1)


get_parent(nums, 0)
for answer in answers:
    print(*answer)
