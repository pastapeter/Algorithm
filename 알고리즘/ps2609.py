import sys

input = sys.stdin.readline

def GCD(x, y):
    while y:
        x, y = y, x % y
    return x

def LCM(x, y):
    return x * y // GCD(x, y)

