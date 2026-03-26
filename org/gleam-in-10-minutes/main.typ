#import "@preview/touying:0.6.1": *
// #import themes.simple: *
#import "../../lib/theme.typ": *
#import "../../lib/color.typ": *
#import "@preview/codelst:2.0.2": sourcecode

#show: comamoca-theme.with(
    total-slides: 12,
    primary: unnamed-blue,
    // pympress用のスピーカーノートを生成
    // config-common(show-notes-on-second-screen: right),
)

#let icode(name) = text(fill: faff-pink, raw(block: false, name.text))
#let ref-url(url) = align(center)[#text(url, 10pt)]

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
          text("Gleam 10分入門", size: 2em),
          text("新卒N年目のLT交流会！"),
        )
        #v(2em)
        #stack(dir: ltr, image("./images/icon.png", width: 10%), h(0.5em), text("こまもか", size: 1.4em))
    ]
    ]
  ]
)

== 自己紹介

#grid(
  columns: (1fr, 2fr),
  gutter: 2em,
  align: (center + horizon, top),
  image("./images/icon.png", width: 6em),
  [
    こまもか

    Twitter: \@Comamoca\_

    - 去年の4月から新卒でITエンジニアをしている
    - 平均月1回はアイマスのライブに行く生活をしている
    - このスライドはEmacsとTypstで作っている
  ],
)

#speaker-note[
]

#focus-slide[ 
  #text("好きな技術", fill: white, size: 2em) 
]

#focus-slide[ 
  #text("Gleam", size: 2em) 
]

== Gleamとは

静的型付けの関数型プログラミング言語

- JavaScript / BEAM(Erlang VM)で動く
- コンパイルが結構速い
- シンプルな構文
- 親切なエラーメッセージ

#speaker-note[
  + ロンドン在住のLouis Pilfold氏が中心に開発
  + 2024年3月にv1.0がリリースされプロダクション対応となった
]

== コンパイルターゲット

Gleamは2つのターゲットにコンパイルできる

#align(horizon)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 2em,
    [
      Erlangターゲット
      - BEAM上で動作
      - サーバーサイド
      - OTPとの連携
    ],
    [
      JavaScriptターゲット
      -  ブラウザで動作
      - フロントエンド開発
      - Node.js / Deno / Bun対応
    ]
  )
]

#speaker-note[
  + 同じコードをErlangにもJSにもコンパイルできる
  + フロントエンドとバックエンドをGleam一本で書けるフルスタック開発が可能
  + JSコンパイルはv1.11.0で30%高速化された
]

== BEAMとは
Erlangの実行基盤

- 並列性: 軽量プロセスを大量に生成可能
- 耐障害性: プロセスの監視・再起動(OTP)
- 分散処理: ノード間通信が組み込み
- DiscordとかWhatsAppとかで使われている

#speaker-note[
  + BEAMはErlang/Elixirが長年使ってきた仮想マシン
  + 軽量プロセス（goroutineに似た概念）を何百万も作れる
  + Supervisorによってプロセスがクラッシュしても自動復旧する
  + GleamはこのBEAMの恩恵をそのまま受けられる
  + 任天堂もSwitchのプッシュ通知システムに使っていたが、2024年にGoにリプレースしている
]

== エコシステム

#align(horizon)[
  - *Lustre* — TEAベースのWebフレームワーク。SPA・SSR対応
  - *Wisp* — シンプルなHTTPバックエンドフレームワーク
  - *Ormlette* — 型安全ORM
  - *gose* — JWT/JOSE実装（JWS, JWE, JWK, JWT）

  パッケージ検索: #text(fill: faff-pink)[packages.gleam.run]
]

#speaker-note[
  + Lustreはフロントエンドのキラーライブラリ。Elmアーキテクチャベース
  + WispはmistというHTTPサーバーの上に乗った高レベルフレームワーク
  + Ormlette: SQLiteなどに対応した型安全なORM
  + gose: セキュリティ系の実装。v1.0がリリースされた
]

== 最近の動向

*v1.15.0* (2026年3月) — Hexパッケージマネージャのセキュリティ強化

*Gleam Weekly #81* の注目トピック:
- #icode[gose] 1.0: JOSE標準実装（JWS, JWE, JWK, JWT）
- #icode[Glaze]: LustreのUIコンポーネントライブラリバインディング
- #icode[smalto]: 30以上の言語対応シンタックスハイライト
- 記事: "Ensuring correctness through the type system"

#speaker-note[
  + v1.15.0は2026年3月16日リリース
  + Gleam Weeklyは毎週コミュニティのニュースをまとめたニュースレター
  + WasmコンパイラがIssue #78で紹介されていた（修士論文として開発）
]

== 最近の動向(Erlang)
- DBライブラリが一通り出揃った
- ORM系ライブラリも戦国時代になっている(squirrel, ormlet)
- Webサーバーも複数実装が登場している(mist, ewe)

#speaker-note[
]

== 最近の動向(JavaScript)
- LustreというSPA FWが天下を取った
- フロントエンドのエコシステムはLustreをベースに実装されることが多い
- Lustre自身、最近は一部ベンチマークでReactより速くなるなど進化している
- 最近はアプリケーションをWebComponentとしてexportできるようになった

#speaker-note[
]

== パターンマッチ

#sourcecode()[
```rust
case result {
  Ok(value) -> value
  Error(e) -> panic as e
}
```]

#speaker-note[
  + caseのパターンは網羅しないとコンパイルエラーになる
  + パイプライン演算子はデータの変換の流れを直感的に書ける
  + echoはGleam組み込みのデバッグ出力関数（v1.4から）
]

== パイプライン演算子

#sourcecode()[
```rust
list.range(0, 10)
|> list.map(fn(n) { n * 2 })
|> list.filter(fn(n) { n % 3 == 0 })
|> echo
```]

#speaker-note[
  + caseのパターンは網羅しないとコンパイルエラーになる
  + パイプライン演算子はデータの変換の流れを直感的に書ける
  + echoはGleam組み込みのデバッグ出力関数（v1.4から）
]

== AIとの相性(開発編)
- 意外と相性が良い
- コンパイル速度が速いためフィードバックを速く回せる
- 静的型付けなため、バグを未然に取り除ける

#speaker-note[
    hooksに`gleam check`と`gleam format`を仕込んどくと半自動で開発が進む
    型をガードレールにして開発ができる
]

== AIとの相性(エージェント編)
- BEAMは一つのプロセスが軽いため大量の処理を並列で実行できる
- Erlang/OTPはプロセスを自動で再生成する仕組みがある(Supervisor)
- エージェントを大量に並列動作できる

#speaker-note[
    hooksに`gleam check`と`gleam format`を仕込んどくと半自動で開発が進む
    型をガードレールにして開発ができる
    エージェントに関しては最近openclawクローンを開発している
]

== 海外では盛り上がっているらしい

- Stack Overflow Developer Survey 2025
- 「最も好まれる言語」2位
- v1.0リリースからわずか10ヶ月での快挙

#speaker-note[
  + Stack Overflow Developer Survey 2025でGleamが70%の支持率
  + 1位のRustは72%なのでほぼ同率
  + v1.0がリリースされてからわずか10ヶ月でこの結果
  + ソース: byteiota.com
]

== まとめ

#align(horizon)[
  - Gleamは静的型付けな関数型言語
  - ErlangとJavaScriptの両方にコンパイル可能
  - ユーザーフレンドリーさを重視している
  - AIとの相性も良い
  - 最近動かせてないけどGleamの日本語コミュニティをやっている
  - url: gleam-jp.org
]

#speaker-note[
  + 10分間でGleamの概要を話した
  + 興味を持ったらgleam.runの公式ツアーから始めるのがおすすめ
  + Discordコミュニティも活発
]
