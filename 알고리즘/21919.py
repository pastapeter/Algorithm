import math

n = int(input())
nums = list(map(int, input().split()))


def isPrime(num):
    if num < 4:
        return True
    else:
        for i in range(2, int(math.sqrt(num)) + 1):
            if num % i == 0:
                return False
    return True


answers = []
cnt = 0
for num in nums:
    if isPrime(num):
        cnt += 1
        answers.append(num)
if cnt == 0:
    print(-1)
else:
    answer = 1
    for i in set(answers):
        answer *= i
    print(answer)
