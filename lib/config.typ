#import "@preview/touying:0.6.1": *
#import "@preview/codelst:2.0.2": sourcecode
#import "./color.typ": *
#import "./theme.typ": comamoca-theme
#import "./helpers.typ": *

// 共通の設定を適用する関数
#let apply-common-config(
  total-slides: 9,
  primary: unnamed-blue,
  show-notes: right,
  body
) = {
  show: comamoca-theme.with(
    total-slides: total-slides,
    primary: primary,
    config-common(show-notes-on-second-screen: show-notes),
  )
  
  // ページとテキストの基本設定
  set page(fill: underwater-blue)
  set text(font: "Noto Sans", fill: white)
  set list(spacing: 1.2em)
  
  // 日本語フォントの設定
  show regex("[\p{scx:Han}\p{scx:Hira}\p{scx:Kana}]"): set text(
    font: "UDEV Gothic NF",
  )
  
  body
}

// コードブロック用の設定を適用する関数
#let setup-code-styling() = {
  let codelst-sourcecode = sourcecode
  let styled-code = styled-sourcecode(codelst-sourcecode)
  styled-code
}

// プレゼンテーション用の基本レイアウト設定
#let presentation-layout(body) = {
  // ヘッダーとフッターの余白調整
  set page(
    margin: (top: 2em, bottom: 2em, left: 2em, right: 2em)
  )
  
  body
}

// スライド番号とプログレスバーの表示設定
#let slide-navigation-config() = {
  // プログレスバーの設定はtheme.typで処理される
  // ここでは追加の設定があれば記述
}

// タイトルスライド用の特別な設定
#let title-slide-config(
  title,
  subtitle: none,
  speaker-name: none,
  speaker-image: none,
  background: underwater-blue
) = {
  set page(fill: background)
  
  create-title-content(
    title, 
    subtitle: subtitle, 
    speaker-name: speaker-name, 
    speaker-image: speaker-image
  )
}

// アニメーション・トランジション設定（将来的な拡張用）
#let animation-config(
  enable-transitions: false,
  transition-duration: 300
) = {
  // 今後のTouying機能拡張に備えた設定
  // 現在は基本的な設定のみ
}

// アクセシビリティ設定
#let accessibility-config(
  high-contrast: false,
  large-text: false
) = {
  if high-contrast {
    set text(fill: white)
    set page(fill: black)
  }
  
  if large-text {
    set text(size: 30pt)
  }
}

// デバッグモード用の設定
#let debug-config(
  show-grid: false,
  show-margins: false
) = {
  if show-grid {
    // グリッド表示の実装（デバッグ用）
  }
  
  if show-margins {
    // マージン表示の実装（デバッグ用）
  }
}

// 完全なプレゼンテーション設定を適用するマスター関数
#let configure-presentation(
  // 基本設定
  total-slides: 9,
  primary: unnamed-blue,
  show-notes: right,
  
  // タイトル情報
  title: none,
  subtitle: none,
  speaker-name: none,
  speaker-image: none,
  
  // 追加設定
  enable-transitions: false,
  high-contrast: false,
  large-text: false,
  debug-mode: false,
  
  body
) = {
  apply-common-config(
    total-slides: total-slides,
    primary: primary,
    show-notes: show-notes,
    body
  )
}