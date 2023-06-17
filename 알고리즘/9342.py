import sys
import re

input = sys.stdin.readline

T = int(input())
answers = []
p = re.compile("^[A-F]?A+F+C+[A-F]?$")
for i in range(T):
    if p.match(input().rstrip()):
        print("Infected!")
    else:
        print("Good")
