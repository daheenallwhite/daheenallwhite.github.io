---
layout: post
title:  "Extension in Swift : 기존 자료형 확장하기"
date:   2019-04-29 13:19:00
author: Dana Lee
categories: Swift
tags:    Extension Swift
lastmod : 2019-06-26 20:13:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

# Extension

_기존 자료형을 확장하는 방법_

> *Extensions* add new functionality to an **existing** **class, structure, enumeration, or protocol type**. This includes the ability to extend types for which you do not have access to the original source code (known as *retroactive modeling*). Extensions are similar to categories in Objective-C. (Unlike Objective-C categories, Swift extensions do not have names.)

- 기존 자료형 **확장**의 한 방법 (**class, struct, enum, protocol**)
  - 수평 확장 - 기존 자료형 그대로에 기능/속성 등을 추가하는.. ← extension 의 확장방법
  - cf) 수직 확장 - 상속을 통한 확장
- 접근 불가능한 타입을 확장할 수 있음 (ex. String type에 나만의 확장 기능을 추가할 수 있다.)
- Obj-c 카테고리와 비슷한 기능
- 추가 가능한 것들 ➕ 👌
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

- Protocol Extensions (Protocol post 참조)

  - protocol 을 extension 과 같이 사용해서 자격요건 필요한 부분을 직접 구현할 수도 있다.
  - Default Protocol Implementation

- Extension with a Generic Where Clause

  - generic type 중에 특정 타입에 대해서만 어떤 기능을 추가 하고 싶은 경우 
  - `extension` & `where` 사용
  - [참조](https://docs.swift.org/swift-book/LanguageGuide/Generics.html#ID553)

&nbsp;

------

## 상속  vs  Extension

- 상속 : class의 확장 방법

  - 상속의 경우, subclass의 자료형에 상속된 자료형을 더해 몸집을 불려서 확장해나감
  - 상속 - 상속을 받아서 새로운 타입을 만들어 확장 (**수직적 확장**)
    ex ) human 클래스를 상속받아 새로운 기능을 덧붙이려면 이를 상속하는 Student 라는 새로운 타입의 클래스를 만듬

- Extension : 기존 자료형 그대로 거기에 기능을 붙여줌 (**수평적 확장**)

- _Example_ : Human class 기능에 study() method 추가하기

  ```swift
  class Human {
  	var name: String
  	var age: UInt
  	func think()
  }
  ```

  - 상속 - subclass 에서 추가 가능

    ```swift
    class Student: Human {
    	func study()
    }
    ```

  - extension - Human class 그 자체에 추가 가능

    ```swift
    extension Human {
    	func study()
    }
    ```

&nbsp;

&nbsp;

### Class 상속의 한계

- 같은 클래스를 상속한 Subclass에서 동일한 기능을 구현하기 위해 **중복코드** 발생 가능
- _Example_
  - Human 을 상속받은 Student, Worker 둘다 공부하는 메소드를 구현할 수 잇음 ➢ 중복코드!!
  - 그렇다고 human에 공부한다는 기능을 넣을 수는 없다
    - 이유) Human 에서 필요한 기능이 아니고, 모든 서브클래스에 공부하는 기능이 있는 건 아니기 때문!

&nbsp;

&nbsp;

&nbsp;

&nbsp;