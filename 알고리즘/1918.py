import sys

input = sys.stdin.readline
exp = input().rstrip()

# 1. ()를 확인한다.
# 2. * / 인지 확인하고 먼저 들어온, 같은 우선순위에 있는 * /은 모두 결과 문자열에 추가
# 3. 그리고 현재 문자 다시 스텍에 추가
# 4. +, - 인지 확인한다. +, - 은 이들보다 낮은 우선순위의 연산자가 없으므로 우선순위가 높은 것들은
# 모두 결과 문자열에 추가해준다.
# 5. )를 발견하면 ( 와 ) 사이에 있는 모둔 연산ㄴ자들을 결과 문자열에 추가하고 ( 를 pop한다.
# 어쩃든 stack을 이용하는 이유는 stack에서 pop되는 연산자가 우선시되는것임
# 그래서 pop시켜서 즉각 바로 result 배열에 추가해주는것임

result = ""
stack = []
for s in exp:
    if s.isalpha():
        result += s
    else:
        if s == "(":
            stack.append(s)
        elif s == "*" or s == "/":
            while stack and (stack[-1] == "*" or stack[-1] == "/"):
                result += stack.pop()
            stack.append(s)
        elif s == "+" or s == "-":
            while stack and stack[-1] != "(":  # 연산자 우선순위가 낮고, (로 인해서 연산자 우선순위가 높지 않다면
                # 연산자 우선을 먼저 꺼내서 후위연산식에 추가해줘야함
                result += stack.pop()
            stack.append(s)  # 근데 괄호 안에 있어서, 연산자 우선순위가 높다면, 일단 stack에 추가
            # 그리고 다음라운드에서 또 '+', '-' 나온다면, 굳이 순서비교 필요없고 바로 result에 추가
        elif s == ")":  # ) 가 들어올경우는 (까지 일단 다 pop시켜야함
            while stack and stack[-1] != "(":
                result += stack.pop()
            stack.pop()
while stack:
    result += stack.pop()
print(result)
