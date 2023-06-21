import sys

input = sys.stdin.readline

# 잃어버린 괄호
# 그리디 문제임
# 괄호를 쳐서 값을 최소로 만들고 싶다라고 하면
# 음수뒤에는 무조건 괄호를 치고 음수 앞에도 괄호를 치면 돤다는것 된다는 생각을 갖고 풀기
# 50-50-50-50 -> 50-(50)-(50)-(50) 55-(50+40)

exp = input().rstrip()
new_exp = ""
isopen = False
for i in range(len(exp)):
    if exp[i].isdigit():
        new_exp += exp[i]
    elif exp[i] == "-":
        if isopen == False:
            new_exp += exp[i]
            new_exp += "("
            isopen = True
        else:
            new_exp += ")"
            new_exp += exp[i]
            new_exp += "("
            isopen = True
    else:
        new_exp += exp[i]
if isopen == True:
    new_exp += ")"


def solution():
    stack = []
    operand_stack = []
    num = ""
    for i in range(len(new_exp)):
        if new_exp[i].isdigit():
            num += new_exp[i]
        else:
            if num != "":
                number = int(num)
                stack.append(number)
                num = ""
            if new_exp[i] == "+":
                operand_stack.append(new_exp[i])
            elif new_exp[i] == "-":
                operand_stack.append(new_exp[i])
            elif new_exp[i] == "(":
                stack.append(new_exp[i])
            else:
                new_stack = []
                while stack[-1] != "(":
                    if len(stack) == 0:
                        break
                    poped = stack.pop()
                    new_stack.append(poped)
                    if len(new_stack) == 2:
                        b = new_stack.pop()
                        a = new_stack.pop()
                        oper = operand_stack.pop()
                        if oper == "+":
                            stack.append(a + b)
                        else:
                            stack.append(a - b)
                if len(new_stack) == 1:
                    operand_stack.pop()
                    stack.append(new_stack.pop() * -1)
                if stack[-2] == "(":
                    del stack[-2]
    if num != "":
        stack.append(int(num))
    if len(stack) > 1:
        answer = 0
        for i in stack:
            answer += i
        print(answer)
    else:
        print(stack[0])


solution()
