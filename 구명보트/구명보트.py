from collections import deque

def solution(people, limit):
    answer = 0
    people.sort()
    q = deque(people)

    while q:
        if len(q) >= 2:
            if q[0] + q[-1] <= limit:
                q.pop()
                q.popleft()
                answer += 1
            else:
                q.pop()
                answer += 1
        else:
            if q[0] <= limit:
                q.pop()
                answer += 1

    return answer