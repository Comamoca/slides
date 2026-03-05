#import "@preview/touying:0.6.1": *
// #import themes.simple: *
#import "../../lib/theme.typ": *
#import "../../lib/color.typ": *
#import "@preview/codelst:2.0.2": sourcecode

#show: comamoca-theme.with(
    total-slides: 9,
    primary: unnamed-blue,
    // pympress用のスピーカーノートを生成
    // config-common(show-notes-on-second-screen: right),
)

#let icode(name) = text(fill: faff-pink, raw(block: false, name.text))
#let ref-url(url) = align(center)[#text("https://gleam.run/getting-started/installing/", 10pt)] 

#let codelst-sourcecode = sourcecode
#let sourcecode = codelst-sourcecode.with(
  frame: block.with(
    fill: underwater-blue,
    stroke: 1pt + faff-pink,
    radius: 5pt,
    inset: (x: 10pt, y: 5pt)
  )
)

#let center-image(path, width: 80%) = align(center, pad(y: 1em, align(center, image(
  path,
  width: width,
))))
#set page(fill: underwater-blue)
#set text(font: "Noto Sans", fill: white)

#set list(spacing: 1.2em)

// #set text(font: "UDEV Gothic NF")
#show regex("[\p{scx:Han}\p{scx:Hira}\p{scx:Kana}]"): set text(
  font: "UDEV Gothic NF",
)

#title-slide(
  [
    #align(center)[
      #block[
        #set align(left)
        #v(3em)
        #stack(
          dir: ttb,
          spacing: 1em,
          text("標準ライブラリ縛りでも堅牢なコードを書きたい", size: 2em),
          text("堅牢.py #2"),
        )
        #v(2em)
        #stack(dir: ltr, image("./images/icon.png", width: 10%), h(0.5em), text("こまもか", size: 1.4em))
    ]
    ]
  ]
)

== 自己紹介
- 最初に触った言語がPython
- 今はPythonで飯を食べている
- 最近はスマホに篠澤広を住まわせてる

#speaker-note[
]

#focus-slide[ 
  #text("堅牢なコードを書きたい！", fill: white, size: 1.3em)
]

#focus-slide[ 
  #text("Pydantic使えば？", fill: white, size: 2em)
]

#focus-slide[
  #text("終", fill: white, size: 6em)
]

== そうもいかない時がある

#align()[
  #align()[
      上司: PythonでLambdaのスクリプト書いて。\
      自分: うす\
      上司: あ、ライブラリは申請制だからね。\
      自分: え\
      上司: コードはAWSコンソールで直接書いて\
      自分: え\
  ]
]

#speaker-note[
]

== なんとか堅牢にコードを書きたい

#align()[
  #align()[
      手元の環境\
      - コードはコピペすることにしたのでVSCodeは使える
      - 組み込みのPylanceで型チェックは効く 
      - Python 3.11(typingは一式使える)

      とりあえず最低限型ヒントを書く環境はある
  ]
]

#speaker-note[
]

== まとめ
