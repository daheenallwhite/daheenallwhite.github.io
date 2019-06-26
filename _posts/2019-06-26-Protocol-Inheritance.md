---
layout: post
title:  "Protocol 상속 - 하위 protocol 준수하면 상위 protocol도 준수하는걸까?"
date:  2019-06-26 20:13:59
author: Dana Lee
categories: Swift
tags: [Protocol, Polymorphism, Conformance]
lastmod : 2019-06-26 20:13:59
sitemap :
  changefreq : daily
  priority : 1.0
---

protocol 상속 관계 - type casting 관련 잘못 알고 있던 부분 정리



## Q. protocol Super 를 상속받은 protocol Sub를 채택한 타입은, protocol Super를 준수할까?

```swift
protocol Super {
	//..
}

protocol Sub {
  //..
}

struct ConcreteType: Sub {
  //..
}

let instance = ConcreteType()

instance is Sub // ??
instance is Super // ??
```

인스턴스의 타입이 한 프로토콜을 준수할 때, 이 인스턴스는 채택한 프로토콜의 상위 프로토콜도 준수하는 걸까?

정답은 **NO**! 준수하는 여부는 colon `:` 뒤에 명시되어 있는지를 체크한다. 물론 상위 프로토콜의 자격요건도 구현되어 있지만, 명시적으로 채택하지 않는다면 준수한다고 보지 않는다.

&nbsp;

## Protocol Inheritance 

Protocol 도 한 개 이상의 다른 protocol을 상속 받을 수 있다. class 의 상속과 비슷하다. 상위 프로토콜의 requirement 에 추가할 requirement 를 더해 하위 프로토콜을 선언할 수 있다.

하지만 class 와 다른 점은 하위 프로토콜을 채택한다고 해서, 상위 프로토콜을 준수하는 것은 아니라는 점이다.

![]({{site.url}}/assets/post-image/protocol-inheritance.png)

클래스의 상속처럼 하위 클래스를 상위 클래스로 upcasting 할 수 있다고 착각하기 쉽다. 하지만 protocol 간의 상속은 protocol 레벨에서만 유효하다. 상위 protocol 에서 선언된 requirement 를 하위 protocol에서 사용하고 싶다는 뜻일뿐이다.

> protocol 간의 상속 : 수직 확장<br>
>
> protocol 을 채택해서 구현 : 수평 확장

![]({{site.url}}/assets/post-image/vertical-horizontal.png)

&nbsp;

*Example*

```swift
protocol ParentProtocol {
  var parentDescription: String { get }
}

protocol ChildProtocol: ParentProtocol {
  var childDescription: String { get }
}

extension Int: ChildProtocol {
  var parentDescription: String { 
  	return "This is a requirement from ParentProtocol"
  }
  
  var childDescription: String {
    return "This is a requirement from ChildProtocol"
  }
}
```

- `ChildProtocol` 은 `ParentProtocol` 에서 선언한 자격요건(requirement)를 상속 받는다. 
- `Int` 가 `ChildProtocol을` 준수한다.

&nbsp;

🧐 이때, `Int` type 은 `ParentProtocol` 을 준수할까?

```swift
let test = 10

test is ChildProtocol // true
test is ParentProtocol // false

test as! ChidProtocol // ok
test as! ParentProtocol // error!!
```

정답은 `ParentProtocol` 을 준수하지 않는다!

`Int` type은 `ChildProtocol` 을 준수할 뿐, `ChildProtocol` 이 `ParentProtocol` 을 상속받았다고 해서, 준수한 타입에서도 `ParentProtocol` 을 준수하는 것은 아니다.

Class 의 상속에서는 하위 클래스 인스턴스는 상위 클래스 타입으로 upcasting 이 가능하다. 하지만 protocol 은 실체가 있는 class 가 아니며 requirement 만 명시하는 역할이므로, class 처럼 계층관계에 있는 것이 아니다. concrete type에서 준수(conforming) 하는 건 수평 확장이지 수직 확장이 아니다. 

:star: **상속 != 채택/준수** :star:

```swift
extension Int: ChildProtocol, ParentProtocol {
	//..
}

let test = 10
test is ChildProtocol // true
test is ParentProtocol // true
```

이렇게 명시해줘야 이제 `Int` 의 인스턴스도 `ParentProtocol을` 준수한다.

&nbsp;