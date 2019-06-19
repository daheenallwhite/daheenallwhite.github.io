---
layout: post
title:  "Protocol doent's conform to itself - protocol 은 자기자신을 준수하지 않는다"
date:  2019-06-07 17:30:59
author: Dana Lee
categories: Swift
tags: [Swift, Protocol, Protocol Witness Table, Generic Where, troubleshooting]
cover:  "/assets/instacode.png"
---



# Protocol doent's conform to itself - protocol 은 자기자신을 준수하지 않는다

protocol 과 generic을 사용하면서 겪은 문제에 대해 내 나름대로 설명을 해보았다.



🔎(추가 : 06/19/2019)

이 문제에 대해 깔끔하게 정리해놓은 글을 발견했다.

[Protocols Sidebar I: Protocols Are Nonconformists]([http://robnapier.net/nonconformist](http://robnapier.net/nonconformist))

관련되어서 궁금했던 모든 질문들에 대한 답이었다. 이 블로그의 protocol 관련된 다른 글도 좋다

&nbsp;

## 문제 - JSON Parser 구현

- JSON value - array 는 json value이고, 그 array element도 json value로만 구성되어야 함
- *Generic Where Clause* 를 사용해서, `Array` `Element`가  `JSONValue` protocol을 준수하면, `Array도` `JSONValue` protocol을 준수하도록 구현하고자 했다. 
  - 참조 - [Generic Where Clause](https://docs.swift.org/swift-book/LanguageGuide/Generics.html#ID192) , [Protocol - Conditionally Conforming to a Protocol](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID282)

```swift
protocol JSONValue {
  var typeDescription: String { get }
}

extension Array: JSONValue where Element == JSONValue {
  var typeDescription: String { return "배열" }
}

// Parser struct Code..
struct Parser {
  ...
  private mutatinf func parseArray() -> JSONValue {
    var jsonArray = Array<JSONValue>()
    ...
    return jsonArray // compile error!
  }
}
```

&nbsp;

`Array<JSONVAlue>` 도 `JSONValue`를 준수할 것이라고 생각했는데, 컴파일러 에러가 떴다. 

이건 `[JSONValue]` 타입이지 `JSONValue는` 아니라는 것이었다. 

Protocol도 타입으로 사용가능하다고 했는데, 이해가 되지 않았다.

&nbsp;

## 원인

### 1. Protocol as Types  

Protocol을 타입처럼 사용한다는 것은 그 자리에 해당 protocol을 구현한 구체적인 타입만 올 수 있다는 뜻이다.

Swift Language Guide 에 다음과 같은 설명이 있다.

> Using a protocol as a type is sometimes called an *existential type*, which comes from the phrase “there exists a type *T* such that *T*conforms to the protocol”.

> protocol을 타입으로 사용하는 것은 *실존하는 타입*이라고도 불린다. 이는 해당 프로토콜을 준수하는 타입이 실제로 존재하기 때문이다.

따라서 protocol을 타입으로 쓰는 경우, `Element: SomeProtocol` 처럼 colon `:` 뒤에 type으로 protocol이 나올 땐, 그 자리에는 concrete type 만 올 수 있다.

코드에서도 

```swift
extension Array: JSONValue where Element: JSONValue {..}
```

`Array의` `Element로` `JSONValue` 를 채택하여 구현한 타입(concrete type conforming to Protocol)이 올 경우에만 `Array`가 프로토콜을 준수하게 된다.

&nbsp;

### 2. Protocol doesn't conform to itself

Protocol은 자기 자신을 준수할 수 없다. 1번의 근본적 원인이기도 하다. 

프로토콜 자체는 선언만 있지 구현부는 없다. 프로토콜 자체가 자격요건을 명시하는 역할만 하지 구체적인 구현은 채택하는 타입에서 한다. default implementation도 준수할 때 생기는 것이므로 concrete type에 속하는 부분이다.

관련된 [stackoverflow](https://stackoverflow.com/questions/33112559/protocol-doesnt-conform-to-itself) 의 토론을 보면 3가지 세부적인 원인이 프로토콜이 자기자신을 준수하지 못한다는 것을 뒷받침한다.

1. Initializer 
2. static method and property
3. associatedtype 

프로토콜 그 자체도 프로토콜을 준수한다면 위의 3가지 경우에 있어서 결정할 수 없는 모호함이 생긴다. 생성자 구현체가 없으니 어떤 타입의 init()을 실행할지 알 수 없다. static 속성들도 구현하는 type에 있다. 앞의 두 요소로 인해 associatedtype으로 구현된 generics 도 init(), static 을 사용할 수 없다.

&nbsp;

## 🔍 Swift MetaType 측면에서 Protocol

원인을 찾는 과정에서 컴파일러가 protocol과 type을 체크하는 방법이 궁금해졌다. 그 과정에서 Swift 의 MetaType에 대해 알게되었다. 

MetaType이란 Type의 Type이다.

```swift
let age: Int = 27
```

- `age` instance 의 Type은 `Int`
- `Int의` Type은 `Int.Type`

코드에서 함수나 변수를 선언하면서 명시하는 Type에는 또 그 상위의 Type이 있다는 것이다.

이 MetaType을 구하는 방법에는 두 가지가 있다.

- `type(of: )` : Dynamic MetaType
- `.self` : Static MetaType

컴파일 타임에 체크하는 것은 static 이니까 `.self`를 쓰려나?

&nbsp;

Protocol 에도 MetaType이 있다.

```swift
protocol MyProtocol {}
let metatype: MyProtocol.Type = MyProtocol.self // Cannot convert value of...
```

그런데 `MyProtocol.self` 는 사용할 수 없다. `.self` 는 구체적인 type과 결합해서만 쓸 수 있다.

```swift
protocol MyProtocol {}
struct MyType: MyProtocol {}
let metatype: MyProtocol.Type = MyType.self // Now works!
```

이유는 `MyProtocol.Type`은 해당 프로토콜을 준수한 type의 MetaType만을 가리킬 수 있기 때문이다. 이걸 **existential metatype** 이라고 한다. 

아까 Protocol as Type 에서 다룬 내용처럼, 구체적으로 구현해서 준수한 type만 올 수 있을 때, ***exixtential*** 을 사용한다.

그럼 프로토콜 그 자체로는 meta type이 없을까?

```swift
let protMetatype: MyProtocol.Protocol = MyProtocol.self
```

정답은 있다. `.Type` 이 아닌 `.Protocol` 이다.

&nbsp;

metatype 으로 유추해보면, compiler가 protocol을 준수하는지 체크할 땐 `.Type` 을 사용하는 것 아닐까? 

## :mag: Protocol 메모리에서 어떻게 실행될까?

Protocol 이 Swift 컴파일러에 의해 어떻게 실행 프로그램이 되는지도 찾아보았다. ([WWDC 2016 - Understanding Swift Performance](2016 - Understanding Swift Performance)) protocol을 준수한 타입은 메모리에서 각 타입에서 구현된 ***Protocol Witness Table(PWT)***를 참조하고 있어 각 타입에 맞는 pwt가 runtime에 실행된다고 한다. 구현한 코드는 PWT에 담겨 실행되는 것이다.

```swift
protocol Drawable {
  func draw()
}

struct Point: Drawable {
  var x, y: Double
  func draw() { ... }
}
```

![source-WWDC 2016 Understanding Swift Performance keynote]({{site.url}}/assets/post-image/protocol-witness-table.png)

&nbsp;

이 사실에서 추측해보면 Protocol 자체를 타입으로 쓸 경우 구현부가 없으니까, `JSONValue` protocol 자체에 연결된 PWT도 없을 것 같다. 또 Generics 는 static 하게, 즉, compile time에 정해지니까 어차피 pwt를 볼 필요도 없을 것 같다

&nbsp;

## 해결

### 1. `:` 대신 `== `를 쓴다

```swift
extension Array: JSONValue where Element == JSONValue
```

&nbsp;

### 2. Array 를 box 에 집어 넣는다 (type-eraser)

Protocol type의 instance를 속성으로 갖는 새로운 구조체를 만든다.

```swift
struct JSONArray: JSONValue {
  private var base: [JSONValue]
  
  init(_ base: JSONValue) {
    self.base = base
  }
}

let boolValue = true
let intValue = 2
let jsonArray = JSONArray([boolValue, intValue])
```

&nbsp;

&nbsp;

### :paperclip: ​Reference 

- WWDC
  - [2015 - Optimizing Swift Performance](https://developer.apple.com/videos/play/wwdc2015/409)
  - [2016 - Understanding Swift Performance](https://developer.apple.com/videos/play/wwdc2016/416/)

- [Stackoverflow - Protocol doesn't conform to itself?](https://stackoverflow.com/questions/33112559/protocol-doesnt-conform-to-itself)

- Swift Language Guide
  - [Generic Where Clause](https://docs.swift.org/swift-book/LanguageGuide/Generics.html#ID192)
  - [Protocol - Conditionally Conforming to a Protocol](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID282)
- [What's .self, .Type and .Protocol? Understanding Swift Metatypes](https://swiftrocks.com/whats-type-and-self-swift-metatypes.html)

&nbsp;