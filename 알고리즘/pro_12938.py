
def solution(n, s):
    answer = []
    if n > s: return [-1]
    temp = s // n
    answer = [s//n]*n
    remain = s%n
    for i in range(remain):
        answer[n - i - 1] += 1

    return answer

print(solution(2, 9))
print(solution(2, 1))
print(solution(2, 8))
