import sys

input = sys.stdin.readline

# 기존 방법이 틀렸던 이유
# 중간에 로직이 잘못되었다.
# 이 분의 로직이 조금 괜찮았던 것은
# Tag의 열리고 닫힘의 index를 파악하고 내부적으로 파악했던것
# 근데 아무래도 <></> 은 Stack느낌이 크다.
# 그렇기에 전의 로직에서 열림친구만 적용시켜주는 것도 고려할만하다.


def div(html):
    if "</div>" not in html:
        text = "title : " + html[html.index('"') + 1 : html.rindex('"')]
        print(text)


def p(html):
    starts, ends = find_start_end(html)
    texts = ""

    for i, val in enumerate(starts[1:]):
        start = val
        end = ends[i]

        texts += html[end + 1 : start]

    text = " ".join(texts.split())

    print(text)


def open(html):
    starts, ends = find_start_end(html)
    p_start = 0
    p_end = 0

    for i, val in enumerate(starts):
        start = val
        end = ends[i]
        if "<div title=" in html[start : end + 1]:
            div(html[start : end + 1])
        if "</p>" in html[start : end + 1]:
            p_end = end
            p(html[p_start : p_end + 1])
        elif "<p>" in html[start : end + 1]:
            p_start = start


def find_start_end(html):
    starts = []
    ends = []

    for i, val in enumerate(html):
        if val == "<":
            starts.append(i)
        elif val == ">":
            ends.append(i)

    return [starts, ends]


s = input()
open(s)
