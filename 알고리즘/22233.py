import sys

input = sys.stdin.readline

# 10개
# 지워진다
n, m = map(int, input().split())
s = set()
for i in range(n):
    s.add(input().rstrip())

post = []
for i in range(m):
    post.append(list(input().rstrip().split(",")))

for words in post:
    for word in words:
        if word in s:
            s.remove(word)
    print(len(s))
