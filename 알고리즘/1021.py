import sys
from collections import deque

input = sys.stdin.readline

q = deque()


def command(c):
    if c == 1:
        q.popleft()
    elif c == 2:
        q.append(q.popleft())
    else:
        q.appendleft(q.pop())


n, m = map(int, input().split())
q = deque([i for i in range(1, n + 1)])
targets = list(map(int, input().split()))
answer = 0
for target in targets:
    if q[0] == target:
        command(1)
    if target in q:
        idx = q.index(target)
        c = 1
        if idx <= len(q) // 2:
            c = 2
        else:
            c = 3
        while q[0] != target:
            command(c)
            answer += 1
        command(1)

print(answer)
