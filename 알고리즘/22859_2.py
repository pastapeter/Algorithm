# HTML 파싱할때는 델리미터로 꼭 </p> </div> 를 쓰세요


def parse(html):
    print("title : " + html[len('<div title="') : html.index('">')])
    html = html[html.index('">') + 2 :]
    html = html.split("</p>")

    for texts in html[:-1]:
        sentence = ""
        tag = False

        for text in texts:
            if text == "<":
                tag = True
            elif text == ">":
                tag = False
                continue

            if not tag:
                sentence += text
        print(" ".join(sentence.split()))


if __name__ == "__main__":
    html = input()
    # html = '<main><div title="title_name_1"><p>paragraph 1</p><p>paragraph 2 <i>Italic Tag</i> <br > </p><p>paragraph 3 <b>Bold Tag</b> end.</p></div><div title="title_name_2"><p>paragraph 4</p><p>paragraph 5 <i>Italic Tag 2</i> <br > end.</p></div></main>'

    html = html[len("<main>") : -len("</main>")]
    html = html.split("</div>")

    # print(*html, sep="\n")

    for paragraph in html:
        if paragraph:
            parse(paragraph)
