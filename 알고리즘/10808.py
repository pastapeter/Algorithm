s = input()
answer = [0 for _ in range(26)]
for i in s:
    answer[ord(i) - ord("a")] += 1
answer = list(map(str, answer))
print(" ".join(answer))
