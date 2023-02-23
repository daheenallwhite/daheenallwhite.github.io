---
slug: "test"
layout: "post"
title: "Test posting for issue to markdown github action"
date: 2023-02-23 18:25:00
author: "Dana Lee"
categories: "Swift"
tags: "Github"
lastmod: 2023-02-23 18:25:00
sitemap: "[object Object]"
---


# Extension

_기존 자료형을 확장하는 방법_

> *Extensions* add new functionality to an **existing** **class, structure, enumeration, or protocol type**. This includes the ability to extend types for which you do not have access to the original source code (known as *retroactive modeling*). Extensions are similar to categories in Objective-C. (Unlike Objective-C categories, Swift extensions do not have names.)

- 기존 자료형 **확장**의 한 방법 (**class, struct, enum, protocol**)
  - 수평 확장 - 기존 자료형 그대로에 기능/속성 등을 추가하는.. ← extension 의 확장방법
  - cf) 수직 확장 - 상속을 통한 확장
- 접근 불가능한 타입을 확장할 수 있음 (ex. String type에 나만의 확장 기능을 추가할 수 있다.)
- Obj-c 카테고리와 비슷한 기능
- 추가 가능한 것들 ➕ 👌
  1. **Computed Property**
  2. **Initializer**
  3. **Method** (instance, type 둘다 가능)
  4. **Subscripts**
  5. **protocol 채택하기**
  6. Nested Types (자료형 안에서 선언한 type)

&nbsp;

- _Example_ : `extenstion` 사용해서 기존 type에 새로운 method를 추가하기

  - `Int` → `Double` 로 변환하는 메서드를 int extension으로 구현하기

    ```swift
    extension Int {
      func convertDouble() -> Double {
        return Double(self)
      }
    }
    ```


