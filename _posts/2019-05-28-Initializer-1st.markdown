---
layout: post
title:  "Initializer (1) : get ready for new instance! "
date:   2019-05-28 21:37:59
author: Dana Lee
categories: Swift
tags: Initializer Swift
cover:  "/assets/instacode.png"
---



# Initializer

## Initialization

> Initialization이란, class, struct, enum 을 사용하기 전에 준비해 주는 과정이다. 즉, 새로운 instance 를 사용을 위해 준비 해주는 과정이다

> *Initialization* is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that is required before the new instance is ready for use.

&nbsp;

***Initializer*** : 특정 type 내에서 정의되어있고, 그 type의 새로운 instance 준비 과정을 담당하는 method

> You implement this initialization process by defining *initializers*, which are like special methods that can be called to create a new instance of a particular type. Unlike Objective-C initializers, Swift initializers do not return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they are used for the first time.

&nbsp;

### :pushpin: Table of Contents

1. **목적**
2. **Initializer** 
   - **custom**
   - **default**
   - **memberwise**
3. **Initializer Delegation for Value types**
4. Class Inheritance & Initializer
   - Designated / Convenience
   - 2단계 초기화 (2 Phase Initialization)
   - Initializer Inheritance & Overriding
   - Automatic Initializer Inheritance
5. Failable Initializer
6. Required Initializer
7. Closure or Function으로 default value 설정하기

&nbsp;

## 1. 목적

- instance 를 생성하기 위한 준비

- 준비 과정에서 하는 것 : 

  ***모든 stored property에 초기값 지정하여 새 instance를 사용할 수 있는 상태로 만든다.***

- optional이 아닌 모든 stored property 은 초기값을 지정해 줘야됨
  - non-optional : 메모리 공간안에 반드시 값이 있음을 의미
  - optional : 메모리 공간 안에 값이 없을 수도 있음을 의미
- swift 는 안전을 최우선으로 하는 언어 → 빈 메모리 공간에 접근할 일이 없도록 하는 것이 initializer의 목적

- 초기값 지정 방법

  1. initializer : `init()` 안에서 값을 넣는 방식
  2. default value : property 선언하면서 초기값 넣는 방식

  ```swift
  // using initializer
  struct Person {
    let name: String
  }
  
  // using default value
  struct Person {
    let name = "Dana"
  }
  ```

  

- :question: 언제 init? 언제 default?

  - 항상 같은 값으로 초기화 된다면 default value가 적절. default value로 초기화하는게 declaration에 좀 더 가까운 방법이다.
  - 객체 생성시 마다 다른 값으로 setting 되어야 한다면 initializer 가 적절

&nbsp;

---

## 2. Initializer

### Custom Initializer

- 상수(constant) property : `let` 으로 선언된 속성도 initializer에서 초기값 설정 가능
  - 단, **해당 클래스**에 의한 초기화에서만 constant value 설정 가능하다
  - subclass에서는 상속받은 constant property 세팅할 수 없다
- Optional type property 
  - initializer에서 필수로 초기화할 필요 없음
  - 따로 설정안하면 `nil` 로 초기화 된다
  - 용도: 초기화 시점에 값이 정해지지 않거나, 나중 어느 시점에 no value(absence of value)를 허용해야 할 경우

### Default Initializer

- `init()`
- custom init을 선언해주지 않은 경우, 자동으로 제공해주는 initializer
- 모든 stored property에 대해 default value로 초기화 진행
- 자동 생성 조건
  - custom init이 없음
  - 모든 stored property에 대해 default value 지정해줌
  - class 의 경우, super class가 없어야 됨
  - struct 의 경우, memberwise init도 자동 생성됨

### Memberwise Initializer

- struct 에서 custom init을 선언하지 않는 경우, 자동으로 생성되는 initializer

- swift는 안전을 최우선으로 하기 때문에, init을 만들어주지 않아도, 모든 value type을 초기화 함에 있어서 값이 지정되어 메모리가 비어있는 것을 방지하려고 한다.

&nbsp;

---

## 3. Initializer Delegation for Value type

- Initializer Delegation : 일종의 품앗이 개념
- init 안에서 다른 init을 불러 나머지 초기화 처리를 맡긴다(위임한다)
- 목적
  - 코드의 중복 방지 (to avoid duplicating code)
  - 이전에 구현해둔 init의 활용
- 방법 : `self.init` 
- Initializer Delegation
  - for struct, enum : 상속이 없으므로, 해당 struct,enum 안의 다른 init을 사용. 상대적으로 단순
  - for class : 상속이 있으므로, 상속받은 property에 대한 init도 고려해야됨. 상대적으로 복잡

&nbsp;

---

### Reference

[swift language guide - Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#)

