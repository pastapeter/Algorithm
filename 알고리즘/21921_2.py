# X일 동안 가장 많이 들어온 방문자 수와 그 기간들
# X일 동안 가장 많이 들어온 방문자수
# 0일 경우 SAD 출력
import sys

input = sys.stdin.readline

# 지난 일수 N, X는 일 동안

n, x = map(int, input().split())
visitors = list(map(int, input().split()))

start = 0
end = start + x
temp_answer = sum(visitors[start:end])
answers = [temp_answer]
while end < n:
    temp_answer -= visitors[start]
    start += 1
    end += 1
    temp_answer += visitors[end - 1]
    answers.append(temp_answer)

answer = max(answers)
if answer == 0:
    print("SAD")
else:
    print(answer)
    print(answers.count(answer))
