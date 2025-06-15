#import "@preview/touying:0.6.1": *
// #import themes.simple: *
#import "../../lib/theme.typ": *
#import "../../lib/color.typ": *
#import "@preview/codelst:2.0.2": sourcecode

#show: comamoca-theme.with(total-slides: 9, primary: unnamed-blue)

#let icode(name) = text(fill: faff-pink, raw(block: false, name.text))

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
          text("Gleamという選択肢", size: 2em),
          text("6/15 関数型まつり 2日目"),
        )
        #v(2em)
        #stack(dir: ltr, image("./images/icon.png", width: 10%), h(0.5em), text("こまもか", size: 1.4em))
    ]
    ]
  ]
)

== 自己紹介

#stack([こまもか], text("Twitter: @Comamoca_"), spacing: 9pt)


#align(center)[
  #v(1em)
  #image("./images/icon.png", width: 20%)
  #text("\ Twitterから来ました! /")
]

#center-image("./images/gleam-reverse-lookup.png")
#center-image("./images/gleam-poem.png") 
#center-image("./images/gleam-articles-list.png") 
#center-image("./images/gleam-garnet.png")

== 注意点
Gleam v1.11.0を前提にしています。 \
Gleam Playgroundは現時点でv1.11.0に対応していないため、一部構文はエラーになる可能性があります。
主に#icode[echo]キーワードなどが該当します。

また、 表示の都合上importなどを省略している箇所があります。

== Gleamとは

Louis Pilfold氏が開発している、静的型付けの関数型言語\
シンプルな構文とErlang VMに基づいた並列性が特徴

#pagebreak()

#focus-slide[
    シンプル...Goと何が違うの？
]

== Gleamとは

  #center-image("./images/6-years-with-gleam.png", width: 55%)
  #align(center)[#text("https://crowdhailer.me/2024-10-04/6-years-with-gleam/", 10pt)]

  #pagebreak()

  #align(horizon)[
      #quote(block: true, attribution: [Louis Pilfold])[
          Gleam is Go ideas but from the perspective of a FP nerd instead of a C nerd
      ]
  ]

  #pagebreak()

== 意訳するなら

#align(horizon)[
    #quote(block: true, attribution: [Louis Pilfold])[
        GleamはGoの設計思想を取り入れているけど、Cオタクの視点じゃなくてFPオタクの視点で解釈した言語だ。
    ]
]

== Gleamの特徴

- シンプルな構文
- 関数型言語由来の関数が多いためコードがスッキリする
- エラーメッセージが親切
- Erlang VM / JS Runtimeで動く

== エラーメッセージの例

#block(
    stroke: 1pt,
    inset: 0.55em,
    radius: 5pt, 
    fill: white,
  )[
#text(size: 14pt, fill: black, font: "UDEV Gothic NF")[
```text
              error: Unknown variable
                ┌─ /src/main.gleam:3:8
                │
              3 │   echo prson
                │        ^^^^^ Did you mean person?

              The name prson is not in scope here.

              warning: Unused variable
                ┌─ /src/main.gleam:2:7
                │
              2 │   let person = "Jhon"
                │       ^^^^^^ This variable is never used

              Hint: You can ignore it with an underscore: _person.
              ```
]]

== LSP

#list(
  [型アノテーションの追加],
  [#icode[import]文の自動追加],
  [#icode[case]における不足してるパターンの追加],
  [パイプ形式でへの自動変換],
)

#center-image("images/2024-07-14-gleam-release-v1-3-0.png")

== 構文

- ifとかforがない
- コールバックの構文糖(use構文)
- ブロック構文
- パターンマッチ
- パイプライン演算子

== use構文
これ一つで

- 例外処理
- 非同期処理
- early return
- middleware

などが表現できる

#center-image("images/gleam-use-syntax.png")

== 例えば

#sourcecode()[
```rust
let val = True
case True {
  True -> "これはTrue"
  False -> "これはFalse"
}
```
]

#pagebreak()

#sourcecode()[
 ```rust
 import gleam/list
 
 pub fn main() {
  list.range(0, 10)
  |> list.map(fn (n) { n * 2 })
  |> list.filter(fn (n) {n % 3 == 0})
  |> echo
 }
 ```]

#center-image("./images/gleam-tour-for-typescript-user.png")

== 開発環境
#align(center)[
    #box(radius: 5pt, stroke: faff-pink)[
        #center-image("./images/install-gleam.png", width: 55%)
    ]
]

#align(center)[#text("https://gleam.run/getting-started/installing/", 10pt)]

== インストール
- brew
- AUR
- apt
- scoop
- Nix

== 拡張機能
- VSCode
- Vim
- Emacs
- Zed

#focus-slide[
    Gleamのエコシステム
]

== Webサーバー
- #icode[gleam/http]
- #icode[mist]
- #icode[wisp]

== ルーティング

#sourcecode()[
```rust
import gleam/string_tree
import hello_world/app/web
import wisp.{type Request, type Response}

pub fn handle_request(req: Request) -> Response {
  // ["tasks", "2"]
  case wisp.path_segments(req) {
    [] -> index(req)
    ["hello"] -> greet(req)
    ["tasks", id] -> show_task(req, id)
    _ -> wisp.not_found()
  }
}
```]

== ミドルウェア

#sourcecode()[
[
```rust
pub fn greet_middleware(req: Request, handler: fn (Request) -> Response) -> Response {
  io.println("Hello!")
}

pub fn handle_request(req: Request) -> Response {
  use req <- greet_middleware(req)

  case wisp.path_segments(req) {
    [] -> index(req)
    _ -> wisp.not_found()
  }
}
```]]

== Lustre
- TEAベースのWebフレームワーク
- 表示単位が純粋関数なため*どこでも*レンダリングできる
- CSR, SSR, SSGが可能
- 開発がLustre dev toolsで完結する
- GitHub 1.6K ⭐

#center-image("./images/gleam-lustre.png")

#focus-slide[
    実例
]

== Gleam Packages
#center-image("./images/gleam-packages.png", width: 65%)

== Gloogle
#center-image("./images/gleam-gloogle.png", width: 65%)

== kirakira
#center-image("./images/gleam-kirakira.png", width: 65%)

== これからの展望
- 更なる開発支援機能の追加
- コード生成技術の発達
- フルスタックフレームワークの発達
- 新たなコンパイルターゲットの登場

== 寄付について
現在Louis Pilfold氏は*フルタイム*でGleamを開発しているのですが、残念ながら財政状況は良くないらしいです... \
*GitHub Sponsors経由*で寄付を行えるので、Gleamを気に入ったらぜひ寄付をお願いします。

#center-image("./images/gleam-sponsors.png", width: 70%)
#align(center)[#text(size: 10pt, "ちなみに、寄付を行なうとブログの一番下に名前が載ります。")]
