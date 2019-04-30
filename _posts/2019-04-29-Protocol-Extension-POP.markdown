---
layout: post
title:  "Protocol, Extension, POP"
date:   2019-04-29 13:19:00
author: Dana Lee
categories: Swift
tags:    Protocol Extension POP
cover:  "/assets/instacode.png"
---
### :pushpin: Table Of Contents

- Protocol
  - 프로토콜을 사용하는 이유
  - 프로토콜 상속(X) / 채택, 준수(O)
  - 프로토콜 여러 개 사용하기
- Extension 
  - 상속 vs Extension
    - class 상속의 한계
- POP (Protocol Oriented Programming)
- 

&nbsp;

&nbsp;

# Protocol 

> A *protocol* defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be *adopted* by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to *conform* to that protocol.

- instance간 정보를 주고 받을 규칙

- 이 역할을 하려면 이런 자격을 가져야 한다 = protocol
  (suit a particular task)

- 이런 역할엔 이런 자격요건이 필요하다고 명시하는 일을 한다.
  
- **이 type의 instance는 이런 역할을 할 수 있다는 명확한 명세, 조건**
  
- ex) 공고에 이 일을 하려면 ~이런이런 자격, 능력이 필요하다

  - 지원자는 해당 능력 가지고 있다고 써있는 이력서 가지고 옴

  ```swift
  protocol Viseoable {  // 비서가 될 수 있는 사람은 이런 조건을 가져야 한다.
  		func manageSchedule()
  		func brewCoffee()
  		func drive()
  		var degree: String { get } //학위를 접근해서 확인해야 하니까
  	  var diverLicense: String { get }
  }
  
  struct Sajang {
  		var viseo: Viseoable //이 protocol(자격) 가진 사람은 모두 여기 들어올 수 있다.
  }
  
  struct Secretary: Viseoable {
  		func manageSchedule() { ...구현}
  		func brewCoffee() { }
  		func drive() { } 
  
  		var degree: String 
  		var diverLicense: String 
  }
  
  let sec1: Secretary = Secretary(degree: "뫄뫄대", driverLicens: "2종 보통")
  
  struct Assistant: Viseoable {
  		func manageSchedule() { ...뫄뫄구현}
  		func brewCoffee() { }
  		func drive() { } 
  
     	var degree: String 
      var diverLicense: String
  }
  
  let sec2 = Assistant(degree: "뭐뭐대", driverLicens: "1종 보통")
  
  var master: Sajang = Sajang(viseo: sec1) // sec1은 비서 할 수 있다
  master.viseo = sec2
  
  
  ```

  &nbsp;

- 프로토콜 네이밍:  주로 ***~를 할 수 있다*** 는 의미로 많이 지음

- 프로토콜에서는 function 정의만 넣지 구현은 하지 않음

  - 조건만 명시해 줌
  - 구현(준수)은 해당 protocol 구현하는 struct, class, enum 에서

- keyword  ```extension``` 사용시, protocol의 function 구현 가능

  - Default Protocol Implementation
  - 이 프로토콜을 준수하는 모든 type이 디폴트로 가지는 기능을 구현함

- 행위 자체의 구체적인 구현은 다를 수 있지만, protocol을 가진다는 것은 자격을 가진다는 것

&nbsp;

## protocol 을 사용하는 이유

- **type에 상관 없이 이런 역할, 자격을 가진 instance를 받고 싶을 때!**

- type이 바뀌면 사용할 수 없는 케이스가 생길 수 있음

- protocol(자격)을 가진 instance라면 모두 ok!

- type보다 좀 더 유연한 접근

- 목적에만 부합하면 괜찮은 경우

- 유연성, 확장성을 위해서   ——> 유연성 generic (더 유연한 것)

- **Any type**을 쓰면 안에서 원하는 타입인지 확인하는 과정이 필요

  ➤ 프로토콜 사용시 그 과정 스킵 가능

- function을 사용하는 모든 타입(class, struct, enum)이 protocol 채택 가능

&nbsp;

## protocol 상속(X) / 채택, 준수(O)

- 타입 정의할 때 **_'protocol을 상속받는다'_ 라고 절대!! 쓰지 않는다**

  - 이 protocol은 어떤 type에 의해 **채택되었다.(adopted)**

  - 구현하는 type은 이 protocol을 **준수한다 (conformed)**

    ```swift
    struct Assistant: Viseoable { //Viseoable 프로토콜을 채택했다
    		func manageSchedule() { ...뫄뫄구현} //이 프로토콜을 준수한다.
    		func brewCoffee() { }
    		func drive() { } 
    
    		var degree: String 
    		var diverLicense: String
    }
    ```

&nbsp;

## 프로토콜 여러 개 사용하기 - &

- 프로토콜 여러 개를 동시에 사용 가능 - 자격조건 여러 개를 함께 넣을 수도 있다. (**&** 사용)

- 프로토콜을 세분화 할 수 있다

  ```swift
  protocol Drivable {
    		var driverLicense: String
    		func drive()
    }
  
    protocol Brewable {
    		func brewCoffee()
    }
  
    struct Sajang {
    		var viseo: Drivable&Brewable // protocol끼리 조합시엔 & 사용
    }
  ```

&nbsp;

- protocol도 다른 protocol을 채택할 수 있다.

  ```swift
  protocol Viseoable : Drivable, Brewable {
  		func manageSchedule()
  		var degree: String { get }
  }
  ```

&nbsp;

&nbsp;

# Extension

> *Extensions* add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you do not have access to the original source code (known as *retroactive modeling*). Extensions are similar to categories in Objective-C. (Unlike Objective-C categories, Swift extensions do not have names.)

- 기존 자료형 **확장**의 한 방법 (class, struct, enum, protocol)

- 접근 불가능한 타입을 확장할 수 있음 (ex. String type에 나만의 확장 기능을 추가할 수 있다.)

- Obj-c 카테고리와 비슷한 기능

- 기존 자료형에 계산속성, 메소드, 서브스크립트 등 추가가능

- Example : `extenstion` 사용해서 기존 type에 새로운 method를 추가하기

  - Int → Double 로 변환하는 메서드를 int extension으로 구현하기

    {% highlight swift %}

    extension Int {
      func convertDouble() -> Double {
        return Double(self)
      }
    }

    {% endhighlight %}

  - Flot -> Double 로 변환하는 메서드 구현하기

    {% highlight swift %}

    extension Float {
      func convertDouble() -> Double {
        return Double(self)
      }
    }

    {% endhighlight %}

  - int 홀짝을 bool로 반환하는 extension method 구현

    {% highlight swift %}

    extension Int {
      func isEven() -> Bool {
        return self % 2 == 0
      }
    }

    {% endhighlight %}

&nbsp;

## 상속 vs Extension

- 상속 : class의 확장 방법
  - 상속의 경우 기존 자료형에 상속된 자료형을 더해 몸집을 불려서 확장해나감
  - 상속 - 상속을 받아서 새로운 타입을 만들어 확장 (**수직적 확장**)
    ex ) human 클래스를 상속받아 새로운 기능을 덧붙이려면 이를 상속하는 Student 라는 새로운 타입의 클래스를 만듬

- Extension : 기존 자료형 그대로 거기에 기능을 붙여줌 (**수평적 확장**)
  ex) human 클래스에 기능을 덧붙이는 것



```swift
extension SomeType {
  // new functionality to be added to SomeType
}

extension String {
  var length: Int {
    let string:NSString = NSString(String: self)
    return string.length
  }
}
```

&nbsp;

### Class 상속의 한계

- 같은 클래스에서 상속되어 내려온 클래스는 동일한 기능을 구현하기 위해 **중복코드** 발생 가능
  ex. human 을 상속받은 student, worker 둘다 공부하는 메소드를 구현할 수 잇음 ➢ 중복코드!!
  그렇다고 human에 공부한다는 기능을 넣을 수는 없음. Human 에서 필요한 기능이 아니고, 모든 서브클래스에 공부하는 기능이 있는 건 아니기 때문!

&nbsp;

## 가독성 향상

- 기능별 코드 블럭 단위별로 extension 사용해서 정의함 → 가독성 향상

  ```swift
  struct MyPoint {
    var ...
  }
  
  // MARK :- 
  extension MyPoint {
    //특정 기능
  }
  ```

&nbsp;

&nbsp;

# Protocol Oriented Programming

프로토콜 == 딱지

어떤 역할을 수행할 것임을 보장

구현은 각 타입 내에서 



protocol + extension = protocol extention

- 특정 타입이 할 일 지정 + 구현을 한번에





```swift
protocol LayoutDrawable {
  func drawSomeLayout()
}

class MyView: UIView, LayoutDrawable {
  func drawSomeLayout() {
    ...
  }
}
```



Protocol Default Implimentation

프로토콜 기능을 미리 구현해 둔다.



```swift
protocol LayoutDrawable {
  func drawSomeLayout()
}

class MyView:UIView, LayoutDrawable {
  
}

extension LayoutDrawable { // Protocol Default Implementation
  func drawSomeLayout() {
    // draw some layout...
  }
}
```





각 프로토콜에서 공통적으로 해야할 일은 protocol default implementation에서 설정해 놓으면 됨



swift - struct friendly language => 상속 불가 -> protocol



참조

protocol oriented programming in swift (wwdc 15, 408)

[swift에서 프로토콜 중심 프로그래밍 하기](<https://academy.realm.io/kr/posts/protocol-oriented-programming-in-swift/>)





## extension can do ~

존재하는 type에 추가할 수 있는거 왠만한거 다 가능

Extensions in Swift can:

- Add computed instance properties and computed type properties
  computed property 추가 가능
- Define instance methods and type methods
  instance, type method 추가 가능
- Provide new initializers
  새로운 initializer 추가 가능
- Define subscripts
  subsctipts([] 사용한 접근) method 정의해서 사용 가능
- Define and use new nested types
  내부 type 추가 가능
- Make an existing type conform to a protocol
  protocol 채택 가능
