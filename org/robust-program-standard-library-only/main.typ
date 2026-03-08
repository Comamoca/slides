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
- 親がPythonで育ての親はNimとGo 
- 一番記憶に残っているコードのミスは`int(input)`()

#speaker-note[
  3時間溶かした
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
      とりあえず最低限型ヒントを書ける環境はある
  ]
]

#speaker-note[
]

== とりあえず型ヒントを書きまくる

#align()[
  #align()[
      全ての値に型ヒントを付けまくる
      - dataclass
      - typing
      - list
      - tuple
  ]
]

== 標準ライブラリにあるデータ構造
  #align()[
    #align()[
        - collections
        - array
    ]
  ]

#speaker-note[
  今回は使わなかったが標準で便利なデータ構造がある
  arrayは最近知った
]

== collections

#align()[
  #text(size: 19pt)[
      - namedtuple:\
      名前付きフィールドを持つタプルのサブクラスを作成するファクトリ関数
      - deque:\
      両端における append や pop を高速に行えるリスト風のコンテナ
      - ChainMap:\
      複数のマッピングの一つのビューを作成する辞書風のクラス
      - Counter:\
      ハッシュ可能 なオブジェクトを数え上げる辞書のサブクラス
  ]
]

== collections

#align()[
  #text(size: 19pt)[
      - OrderedDict:\
      項目が追加された順序を記憶する辞書のサブクラス
      - defaultdict:\
      ファクトリ関数を呼び出して存在しない値を供給する辞書のサブクラス
      - UserDict:\
      辞書のサブクラス化を簡単にする辞書オブジェクトのラッパ
      - UserList:\
      リストのサブクラス化を簡単にするリストオブジェクトのラッパ
      - UserString:\
      文字列のサブクラス化を簡単にする文字列オブジェクトのラッパ
  ]
]

#speaker-note[
    collectionsの詳細はFluent Pythonが詳しい
]

== データ構造だけでも戦えそう

#align(center)[
  #align(horizon)[
      #text(size: 1.5em)[データ構造 + アルゴリズム = プログラム]
  ]
]

== 堅牢は型だけじゃない

#align()[
  #text()[    
      - 適切なデータ構造の選択
      - データ構造に合ったアルゴリズムの実装
      - もちろん型ヒントも大事
  ]
]

#focus-slide[
  #text("堅牢なプログラムは堅牢なデータ構造から", fill: white, size: 0.9em)
]

== なんとか完成

#align()[
  #align()[
      自分: スクリプト完成しました。\
      上司: 良い感じだね。
      自分: うす\
      上司: 疑問に思ってたけど、なんでわざわざクラス使ってるの？\
  ]
]

== まとめ
-  堅牢さの担保に型は重要
- でも堅牢は型ありきじゃない
- 正しいデータ型と型ヒントで堅牢を実現しよう
- 就職先はちゃんと考えて決めよう
