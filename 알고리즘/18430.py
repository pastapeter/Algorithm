import sys

sys.stdin.readline

s = list(input().rstrip())
stack = []
int_stack = []
answer = 0
temp = 0
for i in range(len(s)):
    if s[i] == "(":
        stack.append(s[i])
        temp += 1
    else:
        # 레이저일때 앞에 짤린것을 다 더해줘야함
        if stack[-1] == "(" and s[i - 1] == "(":
            stack.pop()
            temp -= 1
            answer += temp
        else:
            # 이건 그냥 철근이 끝났기에
            # 마지막 answer에 더해주고
            # 짤릴때는 처리를 해주지 않기 위해 -= 1 해준다.
            answer += 1
            temp -= 1

print(answer)
