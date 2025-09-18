#import "./color.typ": *

// 画像を中央揃えで表示するヘルパー関数
#let center-image(path, width: 80%) = {
  // パスが相対パスの場合、適切に調整する
  let adjusted-path = if path.starts-with("./") {
    "../" + path.slice(2)
  } else if path.starts-with("../") {
    path
  } else {
    "../" + path
  }
  align(center, pad(y: 1em, align(center, image(
    adjusted-path,
    width: width,
  ))))
}

// インラインコード用のスタイル関数
#let icode(name) = text(fill: faff-pink, raw(block: false, name.text))

// 参考URL表示用の関数
#let ref-url(url) = align(center)[#text(url, 10pt)]

// コードブロック用のスタイル設定関数
#let styled-sourcecode(sourcecode-func) = sourcecode-func.with(
  frame: block.with(
    fill: underwater-blue,
    stroke: 1pt + faff-pink,
    radius: 5pt,
    inset: (x: 10pt, y: 5pt)
  )
)

// スピーカー情報を表示するヘルパー関数
#let speaker-info(name, twitter: none, image-path: none, image-width: 20%) = {
  let info-parts = (name,)
  if twitter != none {
    info-parts.push(text("Twitter: " + twitter))
  }
  
  let info-stack = stack(..info-parts, spacing: 9pt)
  
  if image-path != none {
    let adjusted-image-path = if image-path.starts-with("./") {
      "../" + image-path.slice(2)
    } else if image-path.starts-with("../") {
      image-path
    } else {
      "../" + image-path
    }
    align(center)[
      #info-stack
      #v(1em)
      #image(adjusted-image-path, width: image-width)
      #text("\ Twitterから来ました! /")
    ]
  } else {
    info-stack
  }
}

// タイトルスライド用のヘルパー関数
#let create-title-content(title, subtitle: none, speaker-name: none, speaker-image: none) = {
  align(center)[
    #block[
      #set align(left)
      #v(3em)
      #stack(
        dir: ttb,
        spacing: 1em,
        text(title, size: 2em),
        if subtitle != none { text(subtitle) },
      )
      #v(2em)
      #if speaker-name != none and speaker-image != none {
        let adjusted-speaker-image = if speaker-image.starts-with("./") {
          "../" + speaker-image.slice(2)
        } else if speaker-image.starts-with("../") {
          speaker-image
        } else {
          "../" + speaker-image
        }
        stack(
          dir: ltr, 
          image(adjusted-speaker-image, width: 10%), 
          h(0.5em), 
          text(speaker-name, size: 1.4em)
        )
      }
    ]
  ]
}

// エラーメッセージ表示用のスタイル関数
#let error-message-block(content) = {
  align(center)[
    #v(1em)
    #block(
      stroke: 1pt,
      inset: 0.55em,
      radius: 5pt, 
      fill: white,
    )[
      #text(size: 14pt, fill: black, font: "UDEV Gothic NF")[
        #content
      ]
    ]
  ]
}

// リスト項目のスタイル設定
#let styled-list-item(item) = text(item)

// フォーカスされたコンテンツ用の装飾ボックス
#let focus-box(content, stroke-color: faff-pink) = {
  box(radius: 5pt, stroke: stroke-color)[
    #content
  ]
}