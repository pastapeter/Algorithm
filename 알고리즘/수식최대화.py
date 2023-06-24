from itertools import permutations
import re

# 절대값 변환


def operate(o, a, b):
    if o == "+":
        return a + b
    elif o == "-":
        return a - b
    elif o == "*":
        return a * b


def calculate(expression, order):
    expression = re.split("([^0-9])", expression)
    answers = []
    for o in order:
        s = []
        for exp in expression:
            if s and s[-1] == o:
                operation = s.pop()
                s[-1] = operate(operation, int(s[-1]), int(exp))
            else:
                s.append(exp)
        expression = s
    return abs(expression[0])


def solution(expression):
    oper_order_list = []
    answer = 0

    for p in list(permutations(["*", "+", "-"], 3)):
        answer = max(answer, abs(calculate(expression, p)))

    return answer
