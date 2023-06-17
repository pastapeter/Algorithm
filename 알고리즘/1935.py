n = int(input())
exp = list(input())
nums = []
alpha = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
]
for i in range(n):
    nums.append(input())

for i in range(len(exp)):
    if exp[i].isalpha():
        exp[i] = nums[alpha.index(exp[i])]


def solution():
    stack = []
    for i in range(len(exp)):
        if exp[i].isdigit():
            stack.append(exp[i])
        else:
            a = float(stack.pop())
            b = float(stack.pop())
            if exp[i] == "*":
                stack.append(b * a)
            elif exp[i] == "+":
                stack.append(b + a)
            elif exp[i] == "/":
                stack.append(b / a)
            else:
                stack.append(b - a)
    print(f"{stack[0]:.2f}")


solution()
