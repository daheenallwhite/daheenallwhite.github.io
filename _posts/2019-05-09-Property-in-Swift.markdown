---
layout: post
title:  "Property in Swift"
date:   2019-05-09 00:17:00
author: Dana Lee
categories: Swift 
tags:    property stored computed type
cover:  "/assets/instacode.png"
---

# Property

- property 란?
  - 특정 class, struct, enum에 관련된 value
  - stored property : instance의 한 부분으로써, 상수나 변수를 저장 함
    - class, struct
  - Computed property : 저장하기 보단 값을 계산함
    - class, struct, enum
  - Type property : instance가 아니라 type 그 자체에 연관된 property
  - property observer : property value에 변화가 생기는 것을 감지하여 그때의 반응 동작을 구현할 수 있음

&nbsp;

#### :pushpin: Table of Contents

- Stored Property
- Computed Property
- Property Observers
- Global & Local Variables
- Type Properties

&nbsp;

&nbsp;

---

## Stored Property

> a stored property is a constant or variable that is stored as part of an instance of a particular class or structure. Stored properties can be either *variable stored properties* (introduced by the `var` keyword) or *constant stored properties* (introduced by the `let` keyword).

- 특정 객체의 상수나 변수 property == stored property

- 정의할 때, 값을 설정하거나 initializer에서 값을 넣어준다.

- let으로 선언한 struct / class property 수정시,

  - struct = value type → propety 수정 불가

  - class = reference type → property 수정 가능

    ```swift
    struct Student {
      var age = 10
    }
    
    let newStudent = Student(age: 15)
    newStudent.age = 19
    // this will report an error
    
    class Fan {
      var age = 11
    }
    let newFan = Fan(age: 10)
    newFan.age = 20
    // this will be true
    ```

&nbsp;

&nbsp;

### Lazy Stored Property

- 처음 사용되기 전까지는 초기 값이 설정되지 않는 property

- keyword `lazy`

- 항상 `var` 로 선언해야 한다 - 객체 초기화 이후에도 초기값이 설정되지 않는 상태이므로 
  `let` (상수)로 선언된 property는 초기화 이전에 항상 값이 설정되어 있어야 하므로 `lazy` 사용이 불가능 하다.

  ```swift
  lazy var something
  ```

- 언제 사용할까? 

  - 객체 초기화가 다 끝난 후에야 다른 변수에 의해 해당 속성의 초기값이 결정될 때!

- Example

  - DataManager instance가 file import 기능을 사용할 필요가 없을 수도 있음
    - DataImporter 기능이 처음 사용될 때 초기화 함 → `lazy`

  ```swift
  // import data from a file
  class DataImporter {
    var filename = "data.txt"
  }
  
  class DataManager {
    lazy var importer = DataImporter() 
    // need to open a file and read its contents into memory
    var data = [String]()
  }
  
  let manager = DataManager() //이 땐, DataImporter 객체 생성 안됨
  manager.data.append("test")
  manager.data.append("test2")
  
  print(manager.importer.filename)
  // 이 때 생성됨 = 맨 처음 사용될 때!
  ```

- _Computed Property_  vs  _Lazy_

  - computed : 사용시마다 계산
  - lazy : 맨 처음 사용시에 메모리에 올라와서 그 뒤로는 계속해서 메모리에 있는 값을 사용

&nbsp;

&nbsp;

---

## Computed Property

- 특정 값을 저장하고 있지 않음

- getter, optional setter 를 통해 다른 속성이나 값을 가져오는 property

- setter : 다른 property 값을 간접적으로 불러오거나 세팅하기 위해서 사용

- 언제 사용하지?

  - 외부에서 판단하기엔 property가 맞는데 사실상 안에 구현은 계산이 필요할 때 사용한다

- example

  ```swift
  struct Point {
    var x = 0.0, y = 0.0
  }
  
  struct Size {
    var width = 0.0, height = 0.0
  }
  
  struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
      get {
        let centerX = origin.x + (size.width/2)
        let centerY = origin.y + (size.height/2)
        return Point(x: centerX, y: centerY)
      }
      set(newCenter) {
        origin.x = newCenter.x - (size.width/2)
        origin.y = newCenter.y - (size.height/2)
      }
    }
  }
  
  var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width:10.0, height: 10.0))
  
  let initialSquareCenter = square.center //(5.0, 5.0)
  
  square.center = Point(x: 15.0, y: 15.0)
  
  print("square is now at (\(square.origin.x), \(squre.origin.y))") //10.0, 10.0
  ```

  &nbsp;

### Shorthand Setter Declaration

- `newValue` : setter에서 새로운 value를 가리키는 default 이름 

  ```swift
  struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
      get {
        let centerX = origin.x + (size.width/2)
        let centerY = origin.y + (size.height/2)
        return Point(x: centerX, y: centerY)
      }
      set { // default name newValue
        origin.x = newValue.x - (size.width/2)
        origin.y = newValue.y - (size.height/2)
      }
    }
  }
  ```

  &nbsp;

### Read-Only Computed Property

- getter만 있는 property
- . 써서 접근 가능
- 세팅 불가

&nbsp;

&nbsp;

---

## Property Observers

- property 를 주의깊게 보고 있다가 변화를 감지해서 그에 반응하는 것

- property의 value가 새로 설정될 때마다 property observer 실행됨

- Lazy property를 뺀 모든 stored property에 추가 가능

  - 상속받은 속성도 OK :ok_hand:

- computed property 는 setter로 반응 가능

- 2가지 옵션 - 새로운 value가 저장되기 전/후

  - 전 : `willSet` value가 저장되기 전 호출됨 (`newValue`)
  - 후: `didSet` 새로운 value가 저장된 후 바로 호출 (`oldValue`)
  - newValue, oldValue는 모두 constant

- example

  ```swift
  class StepCount {
    var totalSteps: Int = 0 {
      willSet(newTotlaSteps) {
        print("About to set totalSteps to \(newTotalSteps)")
      }
      didSet {
        if totalSteps > oldValue {
          print("Added \(totalSteps - oldValue) steps")
        }
      }
    }
  }
  
  let stepCounter = StepCounter()
  stepCounter.totalSteps = 200
  // About to set totalSteps to 200
  // Added 200 steps
  stepCounter.totalSteps = 360
  // About to set totalSteps to 360
  // Added 160 steps
  stepCounter.totalSteps = 896
  // About to set totalSteps to 896
  // Added 536 steps
  ```

&nbsp;

&nbsp;

---

## Global & Local Variable

- global variable : defined **outside** of any function, method, closure, or type context
- local variable : defined **within** a function, method, or closure context

&nbsp;

&nbsp;

---

## Type Property

- Type 그 자체에 속해 있는 속성
- 객체가 몇개가 생기던지 상관 없이 단 한개 copy 의 property만 존재
- 언제 쓰일까? :confused:
  - **모든 객체가 universal하게 공동으로 사용할 value**
  - variable, constants
- 선언 방법
  - `static var` or `class var`
  - computed type property - `class`
    - 하위 class 에서 overriding을 허용하게 해줌.
- 유의할 점
  - 항상 default value를 설정해 주어야 한다 ← type 그 자체에 대한 initializer는 없기 때문에!
  - lazy property 처럼 처음 사용할 때 초기화 된다.