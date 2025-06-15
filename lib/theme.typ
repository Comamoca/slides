#import "@preview/touying:0.6.1": *
#import "./color.typ": *


#let cell = block.with(width: 100%, height: 100%, above: 0pt, below: 0pt, outset: 0pt, breakable: false)


#let dots(self, n) = context box[
  #box[
    #for i in range(n) {
      if i > 0 { box(" ") }

      // if i == context utils.slide-counter.display() {

      if i - 1 == int(counter(page).display()) - 2 {
        text("•", size: 3em, fill: faff-pink)
      } else {
        text("•", size: 2em, fill: self.colors.primary)
      }

      h(2em)
    }
  ]
  #v(10em)
]


#let progress-bar(height: 2pt, primary, secondary) = utils.touying-progress(ratio => {
  grid(
    columns: (ratio * 100%, 1fr),
    rows: height,
    gutter: 0pt,
    cell(fill: primary), cell(fill: secondary),
  )
})



/// プレゼンテーション用のデフォルトのスライド関数。
///
/// - config (辞書): スライドの設定。`config-xxx` を使って設定できます。複数の設定を行いたい場合は、`utils.merge-dicts` を使ってマージしてください。
///
/// - repeat (整数または auto): サブスライドの数。デフォルトは `auto` で、touying が自動でサブスライド数を計算します。
///
///   `#slide(repeat: 3, self => [ .. ])` のような形式でスライドを作る場合、この `repeat` 引数が必要です。`uncover` や `only` のようなコールバック形式は touying では自動検出できません。
///
/// - setting (関数): スライドに対する設定。`set` や `show` のルールをスライドに追加できます。
///
/// - composer (関数): スライドのレイアウトを決める関数。
///
///   例えば、`#slide(composer: (1fr, 2fr, 1fr))[A][B][C]` とすれば、スライドを3つの領域に分け、1つ目と3つ目が1/4、2つ目が1/2の領域を占めます。
///
///   関数ではない値 `(1fr, 2fr, 1fr)` を渡した場合は `components.side-by-side` 関数の第一引数として扱われます。
///
///   `components.side-by-side` 関数は `grid` 関数の簡易ラッパーです。例えば `#grid.cell(colspan: 2, ..)` を使って2列分のセルを作ることができます。
///
///   例えば `#slide(composer: 2)[A][B][#grid.cell(colspan: 2)[Footer]]` は `Footer` を2列分の幅にします。
///
///   composer をカスタマイズしたい場合は、関数を `composer` 引数に渡してください。その関数はスライドの内容を受け取り、変換された内容を返す必要があります（例: `#slide(composer: grid.with(columns: 2))[A][B]`）。
///
/// - bodies (配列): スライドの中身。`#slide[A][B][C]` のように呼び出すことでスライドを作成します。
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let deco-format(it) = text(size: .6em, fill: gray, it)
  let header(self) = deco-format(components.left-and-right(
    utils.call-or-display(self, self.store.header),
    utils.call-or-display(self, self.store.header-right),
  ))
  let footer(self) = {
    deco-format(
      // components.left-and-right(
      //   // utils.call-or-display(self, self.store.footer),
      //   // utils.call-or-display(self, rect(width: 100%, height: 50pt, fill: green)),
      //   // utils.call-or-display(self, context utils.slide-counter.display() + " / " + utils.last-slide-number),
      //   // utils.call-or-display(self, self.store.footer-right),
      //   // []
      // []
      // ),

      utils.call-or-display(self, align(
        center,
      )[#h(2em) #progress-bar(faff-pink, unnamed-blue)]),
    )
  }
  let self = utils.merge-dicts(
    self,
    config-page(header: header, footer: footer),
    config-common(subslide-preamble: self.store.subslide-preamble),
  )
  // touying-slide(self: self, config: config, repeat: repeat, setting: setting, composer: composer, ..bodies)
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
      setting: body => pad(top: -0.8em, body),
    composer: composer,
    ..bodies,
  )
})


/// 中央揃えのスライド。
///
/// - config (辞書): スライドの設定。`config-xxx` を使って設定できます。複数の設定を行いたい場合は、`utils.merge-dicts` を使ってマージしてください。
#let centered-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  touying-slide(self: self, ..args.named(), config: config, align(
    center + horizon,
    args.pos().sum(default: none),
  ))
})


/// タイトルスライド。
///
/// 例: `#title-slide[Hello, World!]`
///
/// - config (辞書): スライドの設定。`config-xxx` を使って設定できます。複数の設定を行いたい場合は、`utils.merge-dicts` を使ってマージしてください。
#let title-slide(config: (:), body) = centered-slide(
  config: utils.merge-dicts(config, config-common(freeze-slide-counter: true)),
  body,
)


/// 新しいセクションのスライド。`config-common` 関数の `new-section-slide-fn` 引数を更新することでカスタマイズできます。
///
/// - config (辞書): スライドの設定。`config-xxx` を使って設定できます。複数の設定を行いたい場合は、`utils.merge-dicts` を使ってマージしてください。
#let new-section-slide(config: (:), body) = centered-slide(config: config, [
  // #text(1.2em, weight: "bold", utils.display-current-heading(level: 1))
  #text(2.3em, weight: "bold", utils.display-current-heading(level: 1))
  #body
])


/// 特定のコンテンツにフォーカスするスライド。
///
/// 例: `#focus-slide[Wake up!]`
///
/// - config (辞書): スライドの設定。`config-xxx` を使って設定できます。複数の設定を行いたい場合は、`utils.merge-dicts` を使ってマージしてください。
///
/// - background (色, auto): 背景色。デフォルトは `auto` で、スライドのメインカラーが使われます。
///
/// - foreground (色): 前景色。デフォルトは `white`。
#let focus-slide(
  config: (:),
  background: auto,
  foreground: white,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: if background == auto {
      underwater-blue
    } else {
      background
    }),
  )
  set text(fill: faff-pink, size: 1.5em)
  touying-slide(self: self, config: config, align(center + horizon, body))
})


/// Touying 用のシンプルなテーマ。
///
/// 使用例:
///
/// ```typst
/// #show: simple-theme.with(aspect-ratio: "16-9", config-colors(primary: blue))
/// ```
///
/// デフォルトの配色:
///
/// ```typst
/// config-colors(
///   neutral-light: gray,
///   neutral-lightest: rgb("#ffffff"),
///   neutral-darkest: rgb("#000000"),
///   primary: aqua.darken(50%),
/// )
/// ```
///
/// - aspect-ratio (文字列): スライドのアスペクト比。デフォルトは `"16-9"`。
///
/// - header (関数): スライドのヘッダー。デフォルトは `self => utils.display-current-heading(...)`。
///
/// - header-right (コンテンツ): ヘッダー右側の内容。デフォルトは `self.info.logo`。
///
/// - footer (コンテンツ): フッターの内容。デフォルトは `none`。
///
/// - footer-right (コンテンツ): フッター右側の内容。デフォルトは `context utils.slide-counter.display() + " / " + utils.last-slide-number`。
///
/// - primary (色): スライドのメインカラー。デフォルトは `aqua.darken(50%)`。
///
/// - subslide-preamble (コンテンツ): サブスライドの前文。デフォルトは `text(1.2em, weight: "bold", utils.display-current-heading(level: 2))`。
#let comamoca-theme(
  aspect-ratio: "16-9",
  header: self => utils.display-current-heading(
    setting: utils.fit-to-width.with(grow: false, 100%),
    level: 1,
    depth: self.slide-level,
  ),
  header-right: self => self.info.logo,
  // footer: none,
  // footer-right: context utils.slide-counter.display() + " / " + utils.last-slide-number,
  primary: aqua.darken(50%),
  subslide-preamble: block(below: 1.5em, text(
    1.2em,
    weight: "bold",
    utils.display-current-heading(level: 2),
  )),
  total-slides: 0,
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: 2em,
      footer-descent: 0em,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      zero-margin-header: false,
      zero-margin-footer: false,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 25pt)
        show footnote.entry: set text(size: 6em)
        show heading.where(level: 1): set text(1.4em)

        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      neutral-light: gray,
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb("#000000"),
      primary: primary,
    ),
    // 後で使うために変数を保存
    config-store(
      header: header,
      header-right: header-right,
      // footer: footer,
      // footer-right: footer-right,
      subslide-preamble: subslide-preamble,
      total-slides: total-slides,
    ),
    ..args,
  )
  body
}
