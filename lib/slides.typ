// メインライブラリファイル - すべての機能を一箇所から利用可能にする
#import "@preview/touying:0.6.1": *

// 基本コンポーネント
#import "./color.typ": *
#import "./theme.typ": *
#import "./helpers.typ": *
#import "./templates.typ": *
#import "./config.typ": *

// 関数は直接インポート済みなので、再エクスポートは不要
// すべての関数は直接利用可能

// 簡単なプレゼンテーション初期化関数
#let init-presentation(
  title: "プレゼンテーションタイトル",
  total-slides: 9,
  primary: unnamed-blue,
  show-notes: right
) = {
  configure-presentation(
    total-slides: total-slides,
    primary: primary,
    show-notes: show-notes,
    title: title
  )
}