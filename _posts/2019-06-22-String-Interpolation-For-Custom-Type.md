---
layout: post
title:  "String Interpolation for Custom Type - Custom Type 에 맞는 문자열 삽입 구현하기"
date:  2019-06-22 13:24:59
author: Dana Lee
categories: Swift
tags: [Swift, StringInterpolation]
cover:  "/assets/instacode.png"
---

# String Interpolation

## string interpolation ?

> string literal 안에 constant, variable, literal, expression 삽입해서 새로운 string 을 만드는 방법

`\()` 사용해서 string literal 을 만드는 방식을 말한다.

단순히 변수도 넣을 수 있고 간단한 수식 계산도 넣을 수 있다.

이게 가능한 이유는 내부에서 interpolation 관련 처리가 이루어지기 때문이다.

&nbsp;

그렇다면 내가 만든 struct or class 에 맞게, 혹은 단순한 내역 말고 내가 원하는 문자열이 나오게 하고 싶다면?

swift 5.0 부터는 이 StringInterpolation 기능이 강화되었다고 한다.

&nbsp;

## 기본 원리

- `String.StringInterpolation` : String 안에 내부 구조체로 선언되어있다.

  ```swift
  typealias StringInterpolation: StringInterpolationProtocol = DefaultStringInterpolation ....
  ```

- `DefaultStringInterpolation` 은 `StringInterpolationProtocol` 을 채택한 struct 타입이다.

  ```swift
  struct DefaultStringInterpolation : StringInterpolationProtocol
  ```

  ```swift
  protocol StringInterpolationProtocol
  ```

  - `DefaultStringInterpolation` 는 `CustomStringConvertible` protocol도 채택했다.
  - 단순한 `CustomStringConvertible` 과 거의 같은 기능을 하지만 추가적으로 interpolation 에 한개 이상의 파라미터를 전달할 수 있고, argument label 도 사용할 수 있다.

- 크게 두가지 method 를 사용한다

  - `appendLiteral()`
  - `appendInterpolation()`

&nbsp;

## Custom Type 에서 string interpolation 사용 방법

1. `String.StringInterpolation` 확장해서 custom type 을 위한 로직 구현

   ```swift
   extension String.StringInterpolation {
       mutating func appendInterpolation(typeCountDescription value: JSONValue & TypeCountable) {
           let prefixDescription = "총 \(value.elementCount)개의 \(value.typeDescription) 데이터 중에 "
           let suffixDescription = "가 포함되어 있습니다."
           var elementDescription = String()
           let seperator = ", "
           var prefix = String()
           let totalTypeCountPair = TypeCounter.getTotalTypeCount(of: value)
           for (typeDescription, count) in totalTypeCountPair {
               elementDescription += prefix
               elementDescription += "\(typeDescription) \(count)개"
               prefix = seperator
           }
           appendInterpolation("\(prefixDescription)\(elementDescription)\(suffixDescription)")
       }
       
       mutating func appendInterpolation(readableFormat jsonValue: JSONValue) {
           var jsonFormatter = JSONFormatter()
           appendLiteral(jsonFormatter.process(jsonValue: jsonValue))
       }
   }
   ```

   ```swift
   print("\(typeCountDescription: jsonValue)")
   print("\(readableFormat: jsonValue)")
   ```

   

2. Custom type 안에 interpolation 관련 로직 구현

   - Protocol 2개 채택 : `ExpressibleByStringLiteral`, `ExpressibleByStringInterpolation`
   - 내부에 `StringInterpolationProtocol` 을 준수하는 `StringInterpolation` 내부 구조체를 구현
   - 자세한 예시는 reference 자료 참조

&nbsp;

---

## 📌 Reference

- [how to use custom string interpolation](https://www.hackingwithswift.com/articles/163/how-to-use-custom-string-interpolation-in-swift)
- [super powered string interpolation in swift 5.0](https://www.hackingwithswift.com/articles/178/super-powered-string-interpolation-in-swift-5-0)

