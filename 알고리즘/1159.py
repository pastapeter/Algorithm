# 5명 선발
# 성 < 5 -> end

team = [0 for _ in range(26)]
n = int(input())
for i in range(n):
    team[ord(input()[0]) - ord("a")] += 1

answer = ""
for i in range(len(team)):
    if team[i] >= 5:
        answer += chr(i + ord("a"))

if answer == "":
    print("PREDAJA")
else:
    print(answer)
