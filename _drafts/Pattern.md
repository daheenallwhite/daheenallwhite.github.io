---
layout: post
title:  "[Swift] Pattern 과 Pattern Matching"
date:  2019-06-28 00:16:59
author: Dana Lee
categories: Swift
tags: [pattern, pattern matching]
lastmod : 2019-06-28 00:16:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

> A *pattern* represents the structure of a single value or a composite value.

- 패턴 : ‘하나 또는 여러 값을 구조화해서 나타내는 것’
- vs. 패턴 매칭 : 코드로 어떤 패턴을 찾도록 비교하는 것
- 값을 해체(추출)하거나 무시하는 패턴
  - 와일드카드, 식별자, 값 바인딩, 튜플
- 패턴 매칭을 위한 패턴
  - 열거형 케이스, 옵셔널, 표현, 타입캐스팅

두 종류의 패턴

1. 값을 해체하기 위한 패턴 (for destructing values)

   wild card, identifier, value binding or tuple

2. 패턴 매칭을 위한 패턴 : 

   enumeration case, optional, expression, type-casting

   switch, catch, do, if, white, guard, for-in

## for desctructing values

### Wildcard Pattern

패턴에서 이곳에 오는 값은 무시한다. (Ignore, don't care)

underscore `_`



### Identifier Pattern

값을 변수나 상수 이름에 연결짓는 것

value-binding pattern 의 하위 패턴

###  Value-Binding Pattern

> Bind : v. 결합하다, 묶다

패턴에 맞는 값을 상수나 변수 이름에 연결짓는 것



### Tuple Pattern



## for full pattern matching



### Expression Pattern

infix operator `~=` : pattern match (Precedence group -comparison Precedence)

## Reference

- [codesquad 자료](http://public.codesquad.kr/jk/Feedback-20171120.pdf)

- https://outofbedlam.github.io/swift/2016/04/04/PatternMatching/

- https://docs.swift.org/swift-book/ReferenceManual/Patterns.html#

- https://alisoftware.github.io/swift/pattern-matching/2016/03/27/pattern-matching-1/ (이 사람 블로그 다 좋음)

  ​	