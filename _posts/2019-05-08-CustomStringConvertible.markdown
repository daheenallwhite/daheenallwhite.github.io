---
layout: post
title:  "CustomStringConvertible protocol - description 바꾸고 싶을 때 사용하는 protocol"
date:   2019-05-08 22:47:00
author: Dana Lee
categories: Swift 
tags:    [Protocol, CustomStringConvertible, description] 
cover:  "/assets/instacode.png"
---

**_description을 바꾸고 싶을 때 사용하는 protocol_**

&nbsp;

:pushpin: 언제 쓸까?

**Swift의 모든 instance는 String으로 변환이 가능한데, 변환시에 각 type에 default로 구현된 description을 변환한다. 변환시의 description을 custom 하고 싶다면 이 protocol을 준수해야한다.**

```swift
print(CharacterSet.decimalDigits)
```

- 출력 결과 : `<CFCharacterSet Predefined DecimalDigit Set>`
- int, String 등의 type 이외의 객체도 출력을 해보면 어떤 타입이나 설명이 나오는 것을 알 수 있다.

&nbsp;

> CustomStringConvertible protocol can provide their own representation to be used **when converting an instance to a string.**

instance → String으로 변환하면 보일 representation을 지정하는 protocol

instance를 String으로 표현하고자 할 때, 해당 instance가 무엇인지 대표하는 정보를 description에 구현한다.

&nbsp;

## Conforming to the CustomStringConvertible Protocol

- by implementing **_description_** property (var)

  ```swift
  var description: String { get }
  ```

  ```swift
  struct MyPoint {
  	let x: Int, y: Int
  }
  
  extension MyPoint: CustomStringConvertible {
    var description: String {
      return "Point at (\(x), \(y))"
    }
  }
  
  let p = MyPoint(x: 10, y:10)
  print(p)
  // "Point as (10, 10)"
  ```

&nbsp;

- 사용하기 

  - 직접적으로 description property 부르는건 지양됨

  - String initializer 를 이용해서 변환하여 사용하기

    > `String(describing:)` : preferred way to convert an instance of any type to a string

    ```swift
    init<Subject>(describing instance: Subject) where Subject : CustomStringConvertible
    ```

    the initializer creates the string representation of instance 

&nbsp;

&nbsp;

### :mag: String(describing:) 을 사용하는 다른 프로토콜 - TextOutputStreamable protocol

이 프로토콜을 준수하는 type은 이 프로토콜을 준수하는 다른 type에 자신의 value를 write 할 수 있다.

해당 instance의 텍스트로 된 표현(textual representation)을 target (which also conforms to this protocol)에 쓸 수 있다.

```swift
func write<Target>(to target: inout Target) where Target : TextOutputStream
```

&nbsp;

&nbsp;