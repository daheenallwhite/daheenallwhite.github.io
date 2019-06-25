---
layout: post
title:  "Protocol 상속 - 채택한 type 을 상위 protocol로 downcasting 할 수 없다"
date:  2019-06-24 19:58:59
author: Dana Lee
categories: Swift
tags: [Protocol, Polymorphism, Conformance]
cover:  "/assets/instacode.png"
---



Protocol Inheritance(상속)을 사용하다가, protocol 을 사용한 다형성(polymorhpism) 에 있어서 개념을 잘 못 이해했다는 것을 깨달았다. 



## Protocol Inheritance (상속) 

Protocol 도 한 개 이상의 다른 protocol을 상속 받을 수 있다. class 의 상속과 비슷하다.

상위 프로토콜의 requirement 에 추가할 requirement 를 더해 하위 프로토콜을 선언할 수 있다.



하지만 class 와 다른 점은 하위 프로토콜을 채택한다고 해서, 상위 프로토콜을 준수하는 것은 아니라는 점이다.

클래스의 상속처럼 하위 클래스를 상위 클래스로 upcasting 할 수 있다고 착각하기 쉽다. 하지만 protocol 간의 상속은 상위 protocol 에서 선언된 requirement 만 상속받고 싶다는 뜻일뿐이다.

채택했는지의 여부는 구체적인 type에서 `: colon` 으로 선언해줬는지에 따라 달린다.



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

🧐 이때, `Int` type 은 `ParentProtocol` 을 준수할까?ㄴ

```swift
let test = 10

test is ChildProtocol // true
test is ParentProtocol // false

test as! ChidProtocol // ok
test as! ParentProtocol // error!!
```



정답은 ParentProtocol 을 준수하지 않는다!

Int type은 ChildProtocol 을 준수할 뿐, ChildProtocol 이 ParentProtocol 을 상속받았다고 해서, 준수한 타입에서도 ParentProtocol 을 준수하는 것은 아니다.

Class 의 상속에서는 하위 클래스 인스턴스는 상위 클래스 타입으로 upcasting 이 가능하다. 

하지만 protocol 은 실체가 있는 class 가 아니며 requirement 만 명시하는 역할이므로, class 처럼 계층관계에 있는 것이 아니다. concrete type에서 

