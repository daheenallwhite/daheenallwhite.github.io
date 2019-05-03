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

- Extension
- [Protocol](#Protocol)
  - 프로토콜을 사용하는 이유
  - 프로토콜 상속(X) / 채택, 준수(O)
  - 프로토콜 여러 개 사용하기
- Extension 
  - 상속 vs Extension
    - class 상속의 한계
- POP (Protocol Oriented Programming)

&nbsp;

&nbsp;

# Extension

> *Extensions* add new functionality to an **existing** **class, structure, enumeration, or protocol type**. This includes the ability to extend types for which you do not have access to the original source code (known as *retroactive modeling*). Extensions are similar to categories in Objective-C. (Unlike Objective-C categories, Swift extensions do not have names.)

- 기존 자료형 **확장**의 한 방법 (**class, struct, enum, protocol**)

- 접근 불가능한 타입을 확장할 수 있음 (ex. String type에 나만의 확장 기능을 추가할 수 있다.)

- Obj-c 카테고리와 비슷한 기능

- 추가 가능한 것들 :heavy_plus_sign: :ok_hand:

  1. **Computed Property**

  2. **Initializer**

  3. **Method** (instance, type 둘다 가능)

  4. **Subscripts**

  5. **protocol 채택하기**

  6. Nested Types (자료형 안에서 선언한 type)

&nbsp;

- _Example_ : `extenstion` 사용해서 기존 type에 새로운 method를 추가하기

  - `Int` → `Double` 로 변환하는 메서드를 int extension으로 구현하기

    ```swift
    extension Int {
      func convertDouble() -> Double {
        return Double(self)
      }
    }
    ```

    &nbsp;

  - `Flot` -> `Double` 로 변환하는 메서드 구현하기

    ```swift
    extension Float {
      func convertDouble() -> Double {
        return Double(self)
      }
    }
    ```

    &nbsp;

  - `Int` 홀짝을 `Bool`로 반환하는 extension method 구현

    ```swift
    extension Int {
      func isEven() -> Bool {
        return self % 2 == 0
      }
    }
    ```

&nbsp;

#### 1. Computed Property

- 이미 존재하는 타입에 instance/type computed property를 추가할 수 있다.

- example : Double type에 길이 단위 속성을 추가하기

  - m 기준
  - Double literal 뒤에 점 찍고 computed property 사용하면 된다.

  ```swift
  extension Double {
      var km: Double { return self * 1_000.0 }
      var m: Double { return self }
      var cm: Double { return self / 100.0}
  }
  
  let oneInch = 2.54.cm
  print("One inch is \(oneInch) meters")
  // One inch is 0.0254 meters
  ```

&nbsp;

#### 2. Initializer

- desinated initializer/deinitializer 는 추가 불가..? (primary initializer for a class … [참조](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html))

- 다른 모듈에서 선언된 struct의 initializer 추가시,

  - 기존 정의된 모듈의 initializer 호출 전까진 self로 접근 불가

- example : 좌표상의 사각형

  ```swift
  struct Size {
      var width = 0.0, height = 0.0
  }
  
  struct Point {
      var x = 0.0, y = 0.0
  }
  
  struct Rect {
      var origin = Point()
      var size = Size()
  }
  
  extension Rect {
      init(center: Point, size: Size) {
          let originX = center.x - (size.width/2)
          let originY = center.y - (size.height/2)
          self.init(origin: Point(x: originX, y: originY), size: size)
      }
  }
  
  let defaultRect = Rect()
  let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
  let centerRect = Rect(center: Point(x: 4.5, y: 4.5), size: Size(width: 5.0, height: 5.0))
  // memberwiseRect 와 centerRect 는 좌표상에서 동일한 위치, 같은 크기의 사각형
  ```

&nbsp;

#### 3. Method

- 새로운 instance/type method 추가 가능

- Example : Int extension -  숫자만큼 parameter로 받은 함수를 반복 실행하는 method

  ```swift
  extension Int {
      func repete(task: () -> Void) {
          for _ in 0..<self {
              task()
          }
      }
  }
  
  3.repete {
      print("hi")
  }
  ```

- mutating instance method : instance 자기 자신을 수정하는 method 

  ```swift
  extension Int {
  	mutating func square() {
  		self = self*self
  	}
  }
  
  var someInt = 3
  someInt.squre() // someInt는 이제 9가 됨
  ```

  &nbsp;

#### 4. Subscript

- subscript는 []을 이용한 연산을 구현하는 것이다.

- example: Int의 subscript - 숫자 자리 index를 넣으면 해당 자리 숫자를 return

  ```swift
  extension Int {
      subscript(digitIndex: Int) -> Int {
          var base = 1
          for _ in 0..<digitIndex {
              base *= 10
          }
          return self / base % 10
      }
  }
  
  print(123456[1])
  ```

  &nbsp;

#### 5. Protocol 채택 

- 새로운 protocol 채택하기 (Make an existing type conform a protocol)

- 원래는 이 struct가 요 protocol 채택 안했는데, 채택하는 걸로 추가 수정하고 싶을 때

  ```swift
  struct MyPoint {
    //....
  }
  
  extension MyPoint: AxisDrawable {
    // ... 구현
  }
  ```

  &nbsp;

#### 6. Nested Type

- struct, class, enum 안에 type 선언하여 사용 가능

  ```swift
  extension Int {
      enum Kind {
          case negative, zero, positive
      }
      var kind: Kind {
          switch self {
          case 0:
              return .zero
          case let x where x > 0:
              return .positive
          default:
              return .negative
          }
      }
  }
  
  (-3).kind //negative
  0.kind    //zero
  10.kind   //positive
  ```

  &nbsp;

  &nbsp;

#### 그외

- 가독성 높이기 위해서 extension을 사용하기도 한다.

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

- Protocol Extensions (뒤에서 나옴)
  - protocol 을 extension 과 같이 사용해서 자격요건 필요한 부분을 직접 구현할 수도 있다.
  - Default  Protocol Implementation

- Extension with a Generic Where Clause
  - generic type 중에 특정 타입에 대해서만 어떤 기능을 추가 하고 싶은 경우 
  - `extension` & `where` 사용
  - [참조](https://docs.swift.org/swift-book/LanguageGuide/Generics.html#ID553)

&nbsp;

&nbsp;

---

# Protocol 

> A *protocol* defines a blueprint of methods, properties, and other **requirements** that **suit a particular task or piece of functionality**. The protocol can then be *adopted* by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to *conform* to that protocol.

- instance간 정보를 주고 받을 규칙

- 이 역할을 하려면 이런 자격을 가져야 한다 = protocol
  (suit a particular task)

- 이런 역할엔 이런 **자격요건**이 필요하다고 명시하는 일을 한다.
  
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
  
  struct Secretary: Viseoable {
  	func manageSchedule() { ...구현}
  	func brewCoffee() { }
  	func drive() { } 
  
  	var degree: String 
  	var diverLicense: String 
  }
  
  struct Assistant: Viseoable {
  	func manageSchedule() { ...뫄뫄구현}
  	func brewCoffee() { }
  	func drive() { } 
  
    var degree: String 
    var diverLicense: String
  }
  
  struct Sajang {
  	var viseo: Viseoable //이 protocol(자격) 가진 사람은 모두 여기 들어올 수 있다.
  }
  
  
  let sec1: Secretary = Secretary(degree: "뫄뫄대", driverLicens: "2종 보통")
  let sec2: Assistant = Assistant(degree: "뭐뭐대", driverLicens: "1종 보통")
  
  var master: Sajang = Sajang(viseo: sec1) // sec1은 비서 할 수 있다
  master.viseo = sec2 //sec2도 가능
  
  ```

  

  <script src="https://gist.github.com/daheenallwhite/0803179adc7119219af30ccc4c2d4bb5.js"></script>

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

  → 프로토콜 사용시 그 과정 스킵 가능

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

---

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

&nbsp;

---

# Protocol Oriented Programming

프로토콜 == 딱지

어떤 역할을 수행할 것임을 보장

구현은 각 타입 내에서 

&nbsp;

protocol + extension = protocol extention

- 특정 타입이 할 일 지정 + 구현을 한번에

&nbsp;



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

&nbsp;

- Protocol Default Implimentation: 프로토콜 기능을 미리 구현해 둔다.
  - 각 프로토콜에서 공통적으로 해야할 일은 protocol default implementation에서 설정해 놓으면 됨

```swift
protocol LayoutDrawable {
  func drawSomeLayout()
}

class MyView:UIView, LayoutDrawable {
	//….
}

extension LayoutDrawable { // Protocol Default Implementation
  func drawSomeLayout() {
    // draw some layout...
  }
}
```

&nbsp;

- swift - struct friendly language => 상속 불가 -> protocol

&nbsp;

### 참조

- [ protocol oriented programming in swift (wwdc 15, 408)](https://developer.apple.com/videos/play/wwdc2015/408/)

- [swift에서 프로토콜 중심 프로그래밍 하기](<https://academy.realm.io/kr/posts/protocol-oriented-programming-in-swift/>)

&nbsp;
