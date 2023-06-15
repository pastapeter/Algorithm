# 각자리 숫자에서 홀수의 개수를 종이에 적고
# 수가 1자리면 종료
# 수가 2자리면, 2개로 나눠서 합을 구하여 새로운 수를 생각
# 풀이시간: 32분
# 중요한 것은 n개의 자리수에서 3개로 분할한다는 것은 분할할수 있는 자리에서 2개를 뽑겠다는 소리임
# (n-1)C2를 하면 자를때 가위가 들어갈 index를 뜻함
# 이 아이디어 말고는 그냥 재귀로 풀면 끝나는 문제

from itertools import combinations

n = int(input())
# n = list(map(int, input()))
answers = []


def solution(n, cnt):
    n = list(map(int, str(n)))
    for i in n:
        if i % 2 == 1:
            cnt += 1
    if len(n) == 1:
        answers.append(cnt)
        return
    elif len(n) == 2:
        solution(n[0] + n[1], cnt)
    else:
        # 5라면 113, 122, 212, 221
        # 1234 중 2개 고르는거네
        nums = [i for i in range(1, len(n))]
        for indices in list(combinations(nums, 2)):
            index = sorted(indices)
            a = int("".join(map(str, n[: index[0]])))
            b = int("".join(map(str, n[index[0] : index[1]])))
            c = int("".join(map(str, n[index[1] :])))
            solution(a + b + c, cnt)


solution(n, 0)
print(min(answers), max(answers))
