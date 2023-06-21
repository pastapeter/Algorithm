import sys
import copy
from collections import deque

input = sys.stdin.readline

# 아직 보여주지 않은 문자 중 추가했을 때의 문자열이
# 사전 순으로 가장 앞에 오도록 하는 문자를 보여주는 것

string = list(input().rstrip())
alphabet = [
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
    "N",
    "M",
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
answer = [""] * len(string)
# 풀이법
# 가장 작은 알파벳
# 해당 알파벳에 뒷배열에서 가장 작은 알파벳
# 중요한 것은 큰 문제를 작은 것으로 나눠서 처리하라


def solution(arr, start):
    if not arr:
        return
    min_alphabet = min(arr)
    min_index = arr.index(min_alphabet)
    answer[start + min_index] = min_alphabet
    print("".join(answer))
    solution(arr[min_index + 1 :], start + min_index + 1)
    solution(arr[:min_index], start)


solution(string, 0)
