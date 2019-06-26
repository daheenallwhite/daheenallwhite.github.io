---
layout: post
title:  "[Swift] Type Casting 타입캐스팅 - is, as"
date:  2019-06-25 17:59:59
author: Dana Lee
categories: Swift
tags: [Type Casting, is, as, as?, as!, Any, AnyObject]
---



## Type Casting

> *Type casting* is a way to check the type of an instance, or to treat that instance as a different superclass or subclass from somewhere else in its own class hierarchy.

타입 캐스팅이란, 한 타입의 인스턴스를 다른 타입의 인스턴스로 취급하는 방법이다. 이 때, 다른 타입은 클래스 계층구조 혹은 프로토콜 채택 관계에 있는 타입이어야 한다. 

&nbsp;

## Type Casting 사용하는 이유 :eight_pointed_black_star:

1. 어떤 type의 instance 인지 확인하려고

   ex. 이 변수에서 참조하는 인스턴스가 Point 클래스의 인스턴스가 맞나요?

2. 같은 class 계층 구조에 있는 다른 class type으로 cast 하려고

   ex. 하위 클래스 타입 인스턴스를 상위 클래스 타입으로, 혹은 반대로

3. protocol 준수하는지 확인하려고

   ex. 이 인스턴스가 프로토콜이 명시한 자격요건을 갖췄는지 확인

&nbsp;

## is - Checking Type

`is` : *type check operator*

> To check whether an instance is of a certain subclass type

- syntax : `someInstance is someType`

  - someInstance 가 someType의 인스턴스, 혹은 someType 을 상속받은 하위 class 의 인스턴스인지 확인

- *Example*

  ```swift
  class Super {
      var name: String
      init(name: String) {
          self.name = name
      }
  }
  
  class Sub: Super {
      var age: Int
      init(name:String, age:Int) {
          self.age = age
          super.init(name: name)
      }
  }
  
  let b = Sub(name: "Dana", age: 27)
  
  b is Super // true
  b is Sub   // true
  ```

  - b 인스턴스는 Sub 클래스 타입
  - Sub 는 Super 의 하위 클래스 (상속관계)
  - `is` 는 그 타입인지, 혹은 그 타입의 하위 클래스인지 체크함
  - 따라서 둘 다 true

&nbsp;

## as - type casting : 다른 type 으로 취급하기

`as` : *type cast operator*

어떤 타입의 변수나 상수는 사실 그 타입이 아닌 그 타입의 하위 타입의 인스턴스를 가리키고 있을 수도 있다. (upcasting 된 상태)

- 확실하다. 타입캐스팅이 항상 성공한다 ▶︎ `as`
- 실패할 가능성이 있다 ▶︎ `as?` or `as!`

- **upcasting** : subclass → superclass - 항상 성공. `as` 
  - subclass 는 superclass 의 method, property 모두 상속 받았음
  - subclass 인스턴스를 superclass 인스턴스처럼 취급하면, superclass 의 method, property 만 접근할 수 있음
  - 항상 method, property 가 있다고 보장됨 → 항상 type casting 성공 → `as` 사용

- **downcasting** : superclass → subclass - 항상 성공은 아님. 실패 가능성. `as?` or `as!` 

  - subclass 로 type casting 을 하려면, subclass 에서 선언된 method, property 를 인스턴스가 가지고 있어야 한다.
  - superclass 타입으로 취급했던 인스턴스가 사실은 subclass 인스턴스인 경우, down casting 가능. 성공
  - 하지만, superclass 타입 인스턴스를 subclass 타입으로 downcasting 하려고 시도하면, subclass 의 특성을 가지고 있지 않으므로 실패
  - 따라서, 실패할 가능성이 있음 → `as?` or `as!` 사용
  - 확실한 경우에만  `as!` 를 사용해야한다.

- *Example : 계층구조 - Super ← Sub*

  ```swift
  class Super {
      var name: String
      init(name: String) {
          self.name = name
      }
  }
  
  class Sub: Super {
      var age: Int
      init(name:String, age:Int) {
          self.age = age
          super.init(name: name)
      }
  }
  ```

  - Sub 의 인스턴스를 upcast 한 뒤, 다시 downcast 하기

    ```swift
    let sub = Sub(name: "Dana", age: 27)
    
    let upcastedSub = sub as Super
    // instance 는 Sub 타입이지만 Super 타입처럼 취급한다
    
    sub.name
    // 속성 접근은 Super 에서 정의된 것만 가능
    
    let downcastedUpcastedSub = upcastedSub as! Sub
    // 이 인스턴스를 다시 Sub 타입처럼 취급 : downcast
    // 인스턴스가 사실 Sub 타입인 걸 알아서 as! (forced) 사용
    
    downcastedUpcastedSub.age
    downcastedUpcastedSub.name
    // Sub 에서 정의된 속성에 접근 가능
    ```

  - Super 인스턴스를 downcast 하기

    ```swift
    let sup = Super(name: "Sarah")
    
    sup is Super // true
    sup is Sub   // false
    
    let downcastedSup = sup as? Sub
    // downcasting 결과 : nil
    // sup 이 가리키는 인스턴스는 Super 타입이라 Sub 타입의 메소드와 속성은 정의되어 있지 않기 때문!
    // as! 사용하면 error
    ```

&nbsp;

## Type Casting for Any and AnyObject

*nonspecific types*

타입을 특정하지 않는 특별한 타입이 있다. - `Any` , `AnyObject`

| Any                                                          | AnyObject                     |
| ------------------------------------------------------------ | ----------------------------- |
| an instance of any type at all, <br />including function types | an instance of any class type |
| 모든 타입의 인스턴스 (함수 포함)                             | class 타입 인스턴스만         |

- 정말 필요할 때만 명시적으로 사용해야 한다.
- 특정 타입을 기대하도록 코드를 작성하는 것이 바람직하다.

&nbsp;

## Checking for Protocol Conformance

`is`, `as` 를 사용해서 타입을 확인하고 타입 캐스팅 하는 대상에 protocol 도 포함된다.

- 특정 프로토콜을 채택하는지 확인 : `is`

  - 인스턴스가 해당 프로토콜을 준수하면 true, 아니면 false

- 프로토콜 타입으로 취급 (type casting) :  `as?` or `as!`

  - 준수하는지 아닌지 확신 못함. 타입 캐스팅 실패할 가능성 있음
  - 프로토콜 타입으로 취급한다 == 해당 자격요건을 구현한 타입이면 어떤 타입이나 가능

- *Example*

  ```swift
  protocol HasSeats {
      var capacity: UInt { get }
  }
  
  class CoffeShop: HasSeats {
      var capacity: UInt
      let name: String
      init(name: String, capacity: UInt) {
          self.name = name
          self.capacity = capacity
      }
  }
  
  class SuperMarket {
      let name: String
      init(name: String) {
          self.name = name
      }
  }
  
  let stores: [AnyObject] =
      [CoffeShop(name: "Starbucks", capacity: 20), CoffeShop(name: "Hollys", capacity: 30), SuperMarket(name: "well-being")]
  
  for store in stores {
      if let cafe = store as? HasSeats {
          print("\(cafe.capacity) seat(s) available")
      } else {
          print("no seat available")
      }
  }
  
  /* 출력 결과
  20 seat(s) available
  30 seat(s) available
  no seat available
  */
  ```

  

- reference
  - [Checking for Protocol Conformance](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID283)
  - [Protocol 정리](https://daheenallwhite.github.io/swift/2019/04/29/Protocol/)

---

## :pushpin: Reference

[Swift Language Guide - Type Casting](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html)

&nbsp;