---
layout: post
title:  "[Swift] Optional은 Enum type이다 - Optional 타입 구현 파헤치기"
date:  2019-07-08 12:43:59
author: Dana Lee
categories: Swift
tags: [Optional, ExpressibleByNilLiteral, coalescing]
lastmod : 2019-07-03 04:53:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

# Optional 은 어떻게 구현되어 있을까?

> Optional : A type that represents either a wrapped value or `nil`, the absence of a value. <br>
>
> 감싸진 값 혹은 nil(값이 없음) 인 타입

## Optional 은 enum type 이다

```swift
enum Optional<Wrapped> {
  case none // nil
  case some(Wrapped) // optional value
}
```

Optional은 generic으로 구현되어 type parameter를 `Wrapped` 라고 부른다. wrapped value를 표현한다.

&nbsp;

## Optional 표현을 가능하게 해주는 것들

nil 혹은 value 를 변수에 할당할 때, 어떻게 이 변수가 optional 변수인지 알 수 있을까? 혹은 optional 변수에 잘 들어갈 수 있을까?

1. swift type system : `Optional` 키워드 없이 타입 뒤에 `?` 붙이면 알아서 처리해준다.

   `Int?` == 감싸져있는(wrapped) 값의 타입이 `Int` 라는 의미

   ```swift
   let shortForm: Int? = Int("42")
   let longForm: Optional<Int> = Int("42")
   
   let number = Optional.some(42)
   let noNumber = Optional.none // nil과 equivalent
   ```

2. Optional 에서 `ExpressibleByNilLiteral` protocol을 준수

   이 프로토콜은 nil로 해당 타입을 초기화 할 수 있는 자격요건을 명시한다.

`ExpressibleByXLiteral` protocol 은 **X 타입 리터럴로 초기화될 수 있는 타입의 자격요건**을 명시한다. `ExpressibleByNilLiteral` 은 nil로 초기화될 수 있는 타입, `ExpressibleByStringLiteral` 은 string literal로 초기화 될 수 있는 타입에서 준수한다.

그동안 변수를 선언할 때, 그저 숫자, 혹은 문자열 리터럴만 넣어주면 Int, String 타입으로 자동으로 type inference 가 되었다. 이를 가능하게 하는 것이 `ExpressibleByXLiteral` protocol 구현 덕이다.

```swift
let age = 27 // ExpressibleByIntegerLiteral
let name = "Dana" // ExpressibleByStringLiteral
```





### ExpressibleByNilLiteral protocol

> A type that can be initialized using the nil literal, `nil`.

```swift
// Required - Creates an instance initialized with nil.
init(nilLiteral: ())
```

이 프로토콜을 준수하기 때문에 `Optional` 타입이 nil로 초기화 될 수 있다.

```swift
let optionalInteger: Int? = nil 
```



### Optional initializer

optional 타입은 2개의 initializer를 가지고 있다. 하나는 nil을 위한 init, 다른 하나는 인자로 받은 value를 감싸기 위한 용도이다.

*Optional Value 생성하기*

```swift
 public init(_ some: Wrapped) { 
   self = .some(some) 
 }
```

*Nil Value 생성하기*

```swift
public init(nilLiteral: ()) { //ExpressibleByNilLiteral
    self = .none
}
```



## Optional Value 변환하기

`map()`, `flatmap()` 메소드는 인자로 받은 함수에 optional value를 넘겨 실행결과를 반환한다. 두 메소드의 차이점은 다시 wrapping 하느냐의 여부이다. 이는 monad 개념과 관련있다. monad는 container 안의 contents를 가공한 뒤 다시 같은 타입의 container에 담아서 리턴할 수 있음을 의미한다. 

map

```swift
public func map<U>(_ transform: (Wrapped) throws -> U) rethrows -> U? {
  switch self {
    case .some(let y):
    	return .some(try transform(y)) // 다시 wrapping 해서 반환
    case .none:
    	return .none
  }
}
```



flatmap

```swift
public func flatMap<U>(_ transform: (Wrapped) throws -> U?) rethrows -> U? {
  switch self {
    case .some(let y):
      return try transform(y) // 다시 wrapping 하지 않음
    case .none:
      return .none
  }
}
```



## Coalescing Nil Values

> coalesce v. 합체하다, 연합하다, 합동하다

Nil coalescing operator `??` 

```swift
a ?? b
```

optional a 에 value가 들어있다면 unwrapping 하고, nil일 경우 default value b를 반환하는 operator이다. 

이 operator 의 구현도 optional 에 되어있다. b에 들어갈 내용은 `@autoclosure` 로 선언되어 있어서 {}로 감싸지 않아도 자동으로 클로져로 취급된다.

```swift
public func ?? <T>(optional: T?, defaultValue: @autoclosure () throws -> T)
    rethrows -> T {
  switch optional {
  case .some(let value):
    return value
  case .none:
    return try defaultValue()
  }
}

public func ?? <T>(optional: T?, defaultValue: @autoclosure () throws -> T?)
    rethrows -> T? {
  switch optional {
  case .some(let value):
    return value
  case .none:
    return try defaultValue()
  }
}
```

*Example*

```swift
let input = readLine() ?? "none"
```

여기서 "none"은 autoclosure 에 넘겨져서 해당 문자열을 리턴하는 함수로 취급된다.

---

## :pushpin: Reference

- [Optional\<Wrapped> source code](https://github.com/apple/swift/blob/master/stdlib/public/core/Optional.swift)
- [documentation - optional](https://developer.apple.com/documentation/swift/optional)