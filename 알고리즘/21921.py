import sys

input = sys.stdin.readline

# X일동안 가장 많이 들어온 방문자 수와 그 기간들!
# X일 동안 가장 많이 들어온 방무자 수와 기간 개수
# 그냥 간단한 two pointer이다.
# 투포인터의 가장 중요한점 => 꿈틀거리는지렁이라는것!

n, x = map(int, input().split())
nums = list(map(int, input().split()))
max_people = 0
answer = 0

start = 0
end = 0
temp = nums[start]
while start <= end and end < n:
    if end - start + 1 < x:
        end += 1
        temp += nums[end]
    else:
        if end - start + 1 == x:
            max_people = max(max_people, temp)
            end += 1
            if end < n:
                temp += nums[end]
        elif end - start + 1 > x:
            temp -= nums[start]
            start += 1

start = 0
end = 0
temp = nums[start]
while start <= end and end < n:
    if end - start + 1 < x:
        end += 1
        temp += nums[end]
    else:
        if end - start + 1 == x:
            if temp == max_people:
                answer += 1
            end += 1
            if end < n:
                temp += nums[end]
        elif end - start + 1 > x:
            temp -= nums[start]
            start += 1

if max_people == 0:
    print("SAD")
else:
    print(max_people)
    print(answer)
