import sys
from collections import deque

input = sys.stdin.readline
dic = {')':'(', ']':'['}
numdic = {}


def solution():
    stack = deque()
    x = input()
    for i in x:
        if len(stack) == 0:
            stack.append(i)
        elif i in list(dic.keys()):
            if stack[-1] == dic[i]:
                poped = stack.pop()
                stacklen = len(stack)
                if poped == '(':
                    new = numdic.get(stacklen+1, 1) * 2
                    if new > 2: del(numdic[stacklen+1])
                    numdic[len(stack)] = numdic.get(len(stack), 0) + new
                else:
                    new = numdic.get(stacklen+1, 1) * 3
                    if new > 3: del(numdic[stacklen+1])
                    numdic[len(stack)] = numdic.get(len(stack), 0) + new
            
            else:
                return 0
        else:
            stack.append(i)
    if len(stack) != 1:
        return 0
    return numdic[0]
    

print(solution())