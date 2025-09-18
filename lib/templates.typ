#import "./helpers.typ": *
#import "./color.typ": *
#import "@preview/codelst:2.0.2": sourcecode

// 自己紹介スライドのテンプレート
#let self-introduction-slide(
  name,
  twitter: none,
  image-path: none,
  image-width: 20%
) = {
  [== 自己紹介]
  
  speaker-info(name, twitter: twitter, image-path: image-path, image-width: image-width)
}

// プロジェクト説明スライドのテンプレート
#let project-overview-slide(
  project-name,
  description,
  features: (),
  github-stars: none
) = {
  let title = [== #project-name とは]
  
  let content = [
    #description
    #if github-stars != none [
      
      GitHub #github-stars ⭐
    ]
  ]
  
  let feature-list = if features.len() > 0 {
    [
      
      == #project-name の特徴
      #for feature in features [
        - #feature
      ]
    ]
  }
  
  title
  content
  feature-list
}

// コード例スライドのテンプレート
#let code-example-slide(
  title,
  code,
  explanation: none,
  language: "rust"
) = {
  [== #title]
  
  {
    let styled-code = styled-sourcecode(sourcecode)
    styled-code[
      ```#language
      #code
      ```
    ]
  }
  
  if explanation != none [
    
    #explanation
  ]
}

// 比較スライドのテンプレート
#let comparison-slide(
  title,
  items: ()
) = {
  [== #title]
  
  for item in items [
    - #item
  ]
}

// 画像中心のスライドテンプレート
#let image-centered-slide(
  image-path,
  title: none,
  width: 65%,
  caption: none
) = {
  if title != none [== #title]
  
  center-image(image-path, width: width)
  
  if caption != none [
    #align(center)[#text(caption, 10pt)]
  ]
}

// 引用スライドのテンプレート
#let quote-slide(
  quote-text,
  attribution: none,
  context-image: none
) = {
  if context-image != none {
    center-image(context-image, width: 55%)
  }
  
  align(horizon)[
    #quote(block: true, attribution: attribution)[
      #quote-text
    ]
  ]
}

// エラーメッセージ例示スライドのテンプレート
#let error-example-slide(
  title: "エラーメッセージの例",
  error-content
) = {
  [== #title]
  
  error-message-block[
    ```text
    #error-content
    ```
  ]
}

// 将来展望スライドのテンプレート
#let future-prospects-slide(
  title: "これからの展望",
  prospects: ()
) = {
  [== #title]
  
  for prospect in prospects [
    - #prospect
  ]
}

// 寄付・支援スライドのテンプレート
#let support-slide(
  title: "寄付について",
  message,
  image-path: none,
  additional-note: none
) = {
  [== #title]
  
  message
  
  if image-path != none {
    center-image(image-path, width: 70%)
  }
  
  if additional-note != none [
    #align(center)[#text(size: 10pt, additional-note)]
  ]
}

// 注意点スライドのテンプレート
#let notice-slide(
  title: "注意点",
  notices: ()
) = {
  [== #title]
  
  for notice in notices [
    - #notice
  ]
}

// フォーカススライド用のシンプルなラッパー（focus-slideはtheme.typで定義済み）
#let simple-focus-slide(content) = [
  #content
]

// 技術紹介プレゼンテーション用のテンプレート（possibility-of-gleamスタイル）
// タイトルスライドテンプレート
#let tech-intro-title-slide(
  main-title,
  subtitle: none,
  speaker-name,
  speaker-image: none,
  speaker-social: none
) = {
  title-slide([
    #align(center)[
      #block[
        #set align(left)
        #v(3em)
        #stack(
          dir: ttb,
          spacing: 1em,
          text(main-title, size: 2em),
          if subtitle != none { text(subtitle) }
        )
        #v(2em)
        #if speaker-image != none {
          let adjusted-image = if speaker-image.starts-with("./") {
            "../" + speaker-image.slice(2)
          } else { speaker-image }
          stack(
            dir: ltr, 
            image(adjusted-image, width: 10%), 
            h(0.5em), 
            text(speaker-name, size: 1.4em)
          )
        } else {
          text(speaker-name, size: 1.4em)
        }
      ]
    ]
  ])
}

// 技術者自己紹介スライドテンプレート
#let tech-self-intro-slide(
  name,
  social-handle: none,
  image-path: none,
  image-width: 20%,
  catchphrase: "\ Twitterから来ました! /",
  additional-slides: ()
) = {
  [== 自己紹介]
  
  let intro-parts = (name,)
  if social-handle != none {
    intro-parts.push(text("Twitter: " + social-handle))
  }
  
  stack(..intro-parts, spacing: 9pt)
  
  if image-path != none {
    align(center)[
      #v(1em)
      #center-image(image-path, width: image-width)
      #text(catchphrase)
    ]
  }
  
  // 追加のスライド（実績や作品紹介など）
  for slide-content in additional-slides [
    #pagebreak()
    #slide-content
  ]
}

// 技術説明スライドテンプレート
#let tech-explanation-slide(
  title,
  description,
  key-points: (),
  github-stats: none
) = {
  [== #title]
  
  description
  
  if github-stats != none [
    
    GitHub #github-stats ⭐
  ]
  
  if key-points.len() > 0 [
    
    #for point in key-points [
      - #point
    ]
  ]
}

// 思想・哲学説明スライドテンプレート
#let philosophy-slide(
  question,
  context-image: none,
  quote-text,
  attribution,
  translation: none
) = [
  #focus-slide[#question]
  
  #if context-image != none {
    pagebreak()
    center-image(context-image, width: 55%)
  }
  
  #pagebreak()
  #align(horizon)[
    #quote(block: true, attribution: attribution)[
      #quote-text
    ]
  ]
  
  #if translation != none [
    #pagebreak()
    == 意訳するなら
    #align(horizon)[
      #quote(block: true, attribution: attribution)[
        #translation
      ]
    ]
  ]
]

// 構文・機能紹介スライドテンプレート
#let feature-showcase-slide(
  title,
  features: (),
  code-examples: ()
) = [
  == #title
  
  #for feature in features [
    - #feature
  ]
  
  #for example in code-examples [
    #pagebreak()
    #if "title" in example {
      [== #example.title]
    }
    
    #styled-sourcecode(sourcecode)[
      ```#example.at("language", default: "rust")
      #example.code
      ```
    ]
    
    #if "explanation" in example and example.explanation != none [
      
      #example.explanation
    ]
  ]
]

// エコシステム紹介スライドテンプレート
#let ecosystem-slide(
  title,
  categories: ()
) = [
  #focus-slide[#title]
  
  #for category in categories [
    #pagebreak()
    == #category.title
    
    #if "items" in category [
      #for item in category.items [
        - #icode[#item]
      ]
    ]
    
    #if "content" in category [
      #category.content
    ]
    
    #if "code-example" in category [
      #pagebreak()
      #styled-sourcecode(sourcecode)[
        ```#category.code-example.at("language", default: "rust")
        #category.code-example.code
        ```
      ]
    ]
  ]
]

// 実例紹介セクションテンプレート
#let showcase-section-slide(
  title: "実例",
  examples: ()
) = [
  #focus-slide[#title]
  
  #for example in examples [
    #pagebreak()
    == #example.title
    #center-image(example.image, width: example.at("width", default: 65%))
    
    #if "description" in example [
      
      #example.description
    ]
  ]
]

// 開発環境・インストール説明スライドテンプレート  
#let installation-slide(
  title: "開発環境",
  install-image: none,
  install-url: none,
  package-managers: (),
  editors: ()
) = [
  == #title
  
  #if install-image != none [
    #align(center)[
      #focus-box[
        #center-image(install-image, width: 55%)
      ]
    ]
  ]
  
  #if install-url != none [
    #ref-url(install-url)
  ]
  
  #if package-managers.len() > 0 [
    #pagebreak()
    == インストール
    #for pm in package-managers [
      - #pm
    ]
  ]
  
  #if editors.len() > 0 [
    #pagebreak()
    == 拡張機能
    #for editor in editors [
      - #editor
    ]
  ]
]