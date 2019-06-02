---
layout: post
title:  "Swift 프로토콜 준수와 채택의 차이 : Difference between Conformance and Adoption in Swift Protocol"
date:   2019-06-02 16:59:59
author: Dana Lee
categories: Swift
tags: Swift Protocol Adoption Conformance
cover:  "/assets/post-image/protocol-adoption-conformance.png"
---



# Difference between Adoption and Conformance in Protocol - 프로토콜 채택, 준수의 차이

*Protocol에서 Adoption(채택) 과 Conformance(준수)의 차이*

&nbsp;

Swift에서는 자료구조의 수평적 확장을 위해 Protocol 을 사용한다. Protocol으로 확장시에는 ***상속***이라는 표현을 쓰지 않고 ***채택과 준수***라는 단어를 사용한다.

하지만 둘의 차이점은 뭔지 확실하게 파악할 수 없었다. 처음에는 <u>시점의 차이</u>라고 생각했다. Protocol 시점에서 보면 기존에 존재하는 타입(exsisting type) 이 extension으로 준수하고, 존재하는 타입 입장에서는 protocol을 채택한다라고 생각했다. 

하지만 오늘 swift language guide를 보다가 확실하게 구분할 수 있는 결정적인 topic이 있었다.

> [Declaring Protocol Adoption with an Extension](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID278)

existing type에서 이미 protocol이 명세한 요구 조건(property or method)를 이미 구현해 놓은 상태라면, `extension` 과 protocol 이름만 명시하고, 구현부를 공백으로 두면 해당 타입이 그 프로토콜을 준수하게 된다.

여기서 결정적인 설명은 다음과 같다

> If a type already **conforms** to all of the requirements of a protocol, but has not yet stated that it **adopts** that protocol, you can make it adopt the protocol with an empty extension:

```swift
protocol TextRepresentable {
    var textualDescription: String { get }
}

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}
```

`Hamster` 구조체에서 이미 `TextRepresentable` protocol의 요구 사항을 구현한 상태라면, 빈 extension 에다가 protocol 이름만 덧붙이면 된다.

설명과 예시를 보고 파악한 내용은 다음과 같다.

> 구현한 것 → conform 준수 <br>colon `:`으로 덧붙이는 부분 → adopt 채택 

다시 설명하자면, 

Hamster struct 에서 TextRepresentable protocol 의 요구 사항을 ***준수***한 상태라면, 빈 extension으로 protocol을 ***채택***하면 된다.

&nbsp;

따라서, 준수와 채택의 차이는 ***코드에서의 위치***로도 설명할 수 있다.

> 준수 (*Conformance*) -  `{}` 안에서 요구사항 구현 <br>
>
> 채택 (*Adoption*) - `Type : Protocol` 형식으로 명시하는 부분 

![Difference between Conformance and Adoption in Swift Protocol]({{site.url}}/assets/post-image/protocol-adoption-conformance.png)

&nbsp;

기존에 내가 이해했던 시점, 관점의 차이도 어느정도 설명이 된다. 결국 타입 시점에서 프로토콜을 **채택**하면 `:` 를 추가하여 명시하는 과정이 필요하다. 프로토콜 관점에서 존재하던 타입이 해당 프로토콜을 **준수**하면, 구체적으로 요구 사항을 구현한다. 하지만 확실하게 어떤 부분이 준수이고 어떤 부분이 채택이다라고 설명하는데는 부족함이 있었다.

더 확실하게는 구현부에 대해서는 준수, 명시하는 부분은 채택 - 구현 위치로 표현을 다르게 사용하면 된다.

&nbsp;

&nbsp;

