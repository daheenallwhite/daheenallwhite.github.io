---
layout: post
title:  "Initializer (3) : Failable, Required, Closure"
date:   2019-05-29 21:37:59
author: Dana Lee
categories: Swift
tags: Initializer Swift 
cover:  "/assets/post-image/class-init-type.png"
---



# Initializer

*3rd - *

previout post about intializer 

[1st post about Initializer in swift](https://daheenallwhite.github.io/swift/2019/05/28/Initializer-1st.html) 에서는 초기화의 목적과 기본적인 내용에 대해 알아보았다.

이번 post 에서는 Class 로 만들 객체의 초기화에 대해 알아보려고 한다.

:key: Class 초기화의 모든 복잡성은 ***상속*** 으로부터 나오며, 초기화 과정도 상속으로 인한 처리가 추가되어있다고 보면 이해하기 쉽다.

&nbsp;

### :pushpin: Table of Contents

1. 목적
2. Initializer 
   - custom
   - default
   - memberwise
3. Initializer Delegation for Value types
4. Class Inheritance & Initializer
   - Designated / Convenience
   - Initializer Delegation for Class Types
   - 2단계 초기화 (2 Phase Initialization)
   - Initializer Inheritance & Overriding
   - Automatic Initializer Inheritance (자동 상속되는 경우) 
5. **Failable Initializer**
6. **Required Initializer**
7. **Closure or Function으로 default value 설정하기**

&nbsp;

---

## Failable Initializer - 초기화도 실패할 수 있다

초기화가 실패할 가능성을 허용해주는 initializer를 정의할 수 있다. 

- 실패 원인

  - Invalid parameter value
  - 필요한 외부 자원의 부재
  - 그외 초기화를 계속할 수 없는 조건

- 선언 방법 : `init?`

  - 같은 parameter 이름, 타입으로 non-failable init과 failable init을 정의할 순 없음 

- 실패가 일어날 가능성이 있는 곳에서 `return nil`

  - to trigger initialization failure
  - 엄밀히 말하면 value를 return 하는 것이 아니라, 실패를 알리는 것

- 대표적인 failable init : 숫자 type 변환

  ```swift
  struct Int {
  	//...
  	init?(String) {}
  	init?(exactly: Double) {}
  }
  ```

- *Example* : title 없을 경우 생성 실패

  ```swift
  struct BlogPost {
    let title: String
    init?(title: String) {
      if title.isEmpty {
        return nil
      }
      self.name = name
    }
  }
  
  guard let newPost = BlogPost(name: "") else {
    print("Blog posts are supposed to have a title")
  }
  // else 뒤의 문장 실행됨
  ```

&nbsp;

#### Failable Initializer for Enumeration

- enum 도 init으로 초기값 설정할 수 있다. ([관련글 참조](https://outofbedlam.github.io/swift/2016/04/05/EnumBestPractice/))

- init 으로 들어온 parameter value에 따라 case를 설정하는 용도임

- *Example* : 

  ```swift
  enum MembershipLevel {
    case bronze, silver, golden, diamond
    
    init?(stage: Int) {
      switch stage {
      case 1:
        self = .bronze
      case 2:
        self = .silver
      case 3:
        self = .golden
      case 4:
        self = .diamond
      default:
        return nil
      }
    }
  }
  
  let vip = MembershipLevel(stage: 4)
  ```

- rawValue로 초기화도 가능

  ```swift
  enum MembershipLevel: Int {
    case bronze = 1, silver = 2, golden = 3, diamond = 4
  }
  
  let vip = MembershipLevel(rawValue: 4)
  ```

  

&nbsp;

#### Propagation of Initialization Failure

Delegation up/across

상속 관계에서 subclass failable init 이 superclass의 failable init 을 호출해서 나머지 초기화를 맡길 수 있다.

#### Overriding a Failable Initializer



---

## Required Initializer

> 모든 subclass에서 필수로 구현해야 하는 initializer

- 형식 : `required` modifier 앞에 추가

  - subclass에서도 추가해야 됨

  ```swift
  class SuperClass {
  	required init() {}
  }
  
  class SubClass {
    required init() {}
  }
  ```

- subclass 에서는 `override` 를 쓰는게 아니라 `required` 그대로 똑같이 써야 함

- 왜냐하면, 그 subclass를 상속받을 sub-subclass 도 required init을 구현해야 하기 때문

&nbsp;

---

## Closure or Function으로 default value 설정하기







![]({{site.url}}/assets/post-image/automatic-init-inheritance.png)

&nbsp;

---

## Summary / Thoughts

- 초기화 과정에서는 non-optional property의 초기값을 지정해 주어야 한다
- class 는 상속으로 인해 initializer 구성이 복잡하다
- struct 가 memberwise initializer를 자동으로 제공하는데는 swift의 안전 우선 특성이 반영되어있다.
- initializer는 다른 initializer를 호출하여 초기화 과정을 서로 품앗이 할 수 있다
- initializer는 기본적으로 상속될 수 없지만, 특정 조건 하에서는 상속된다.
- 초기화 과정에서 init / default value가 적절한 상황을 고려해야 효율적인 설계가 될 것이다

&nbsp;

---

### Reference

- [swift language guide - Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#)

&nbsp;

&nbsp;