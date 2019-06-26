---
layout: post
title:  "Swift CharacterSet 으로 입력 문자열 검사하기 (Checking Input String Using CharacterSet in Swift)"
date:   2019-05-01 13:19:00
author: Dana Lee
categories: Swift 
tags:    CharacterSet
lastmod : 2019-06-26 20:13:59
sitemap :
  changefreq : weekly
  priority : 1.0
---
# Checking Input String by Using CharacterSet

_입력 문자열에 포함되면 안되는 문자열이 있는지 검사하기 - swift CharacterSet을 사용해서_

&nbsp;

## CharacterSet 

> A set of Unicode character values for use in search operations. ([documentation](<https://developer.apple.com/documentation/foundation/characterset>))

&nbsp;

#### 사용 목적: **검색**

- to group characters together **_for searching operations_**, so that they can **_find any of a particular set of characters during a search._**
- 검색을 위한 character를 한 그룹에 모아 검색 관련 method를 내장

&nbsp;

#### 특징

- **standard character set** 제공 : `decimalDigits`, `alphanumerics` 같은 값들..  
  - type property로 제공함(static var)
- ⭐️ 검색에 유용한 method (Combining Character Set)
  - 집합 관련 method로 두개의 CharacterSet간의 비교가능 : **union, subset, superset..**
  - `isSuperset` , `isSubset`
- `insert()` : characterset 요소 추가
- String으로 초기화 가능 : `init(charactersIn: String)`
  - String에 있는 모든 character를 요소로 한 CharacterSet instance를 만든다.

&nbsp;

#### 구현 예시 : 입력받은 String에 입력할 수 없는 문자가 포함되어있는지 체크하기

- 좌표값 (x, y) 입력받기

- 입력 형식 : `(10,10)`

- `validCharacterSet` : 입력가능한 문자만 있는 set - 괄호, 쉼표, 숫자만(음수, 소수 안됨) 합친 집합

- ` validCharacterSet.isSuperset(of: inputCharacterSet)` : 체크하는 핵심 메소드
  

(`validCharacterSet` 에 `inputCharacterSet이` 부분집합으로 포함되어야 한다.)

  ```swift
  //입력 가능한 문자만 있는 set
  var validCharacterSet: CharacterSet = CharacterSet(charactersIn: "(,)")
  // forUnion: Sets the value to a union of the CharacterSet with another CharacterSet.
  // 합집합. 합치기 with decimalDigits
  validCharacterSet.formUnion(CharacterSet.decimalDigits)
  
  // standard와 비교할 입력 받은 문자열
  let inputCharacterSet = CharacterSet(charactersIn: "(10,11)")
  
  // 기준에 입력받은 문자열이 완전히 포함되는지 -> true
  validCharacterSet.isSuperset(of: inputCharacterSet)
  // 입력받은 문자열이 기준에 완전히 포함되는 부분집합인지 -> true
  inputCharacterSet.isSubset(of: validCharacterSet)
  
  // ** 허점 발생! 괄호가 없거나, 쉼표가 없어도 true로 인식됨
  let invalidCharacterSet = CharacterSet(charactersIn: "11,11")
  invalidCharacterSet.isSubset(of: validCharacterSet)
  ```

&nbsp;

- 문제점 보완 : 괄호, 쉼표, 숫자를 점점 추가해가며 비교 (완벽하게 체크하고 싶은 경우)

  ```swift
  let inputCharacterSet = CharacterSet(charactersIn: "(10,11)")
  let invalidCharacterSet = CharacterSet(charactersIn: "11,10")
  
  //1. parenthesis
  var validCharacterSet = CharacterSet(charactersIn: "()")
  validCharacterSet.isSubset(of: inputCharacterSet)   // true
  validCharacterSet.isSubset(of: invalidCharacterSet) // false
  
  //2. comma
  validCharacterSet.formUnion(CharacterSet(charactersIn: ","))
  validCharacterSet.isSubset(of: inputCharacterSet)   //true
  validCharacterSet.isSubset(of: invalidCharacterSet) //false
  
  //3. decimalDigits
  validCharacterSet.formUnion(CharacterSet.decimalDigits)
  validCharacterSet.isSuperset(of: inputCharacterSet)   //true
  validCharacterSet.isSuperset(of: invalidCharacterSet) //true
  ```

&nbsp;

#### 추가 참고

- `strictSubset` / `strictSuperSet` 은 **해당 set과 동일한건 불포함임**
  - 자신과 같은 집합은 subset, superset이라고 취급안하면 **strict**가 붙는다.
  - ex. {a, b}에서 {a}, {b}는 strictSubset. {a, b}는 불포함

- standard character set 중 ```decimalDigits``` : **0 포함. 음수 불포함**

  ```swift
  let zero = CharacterSet(charactersIn: "0")
  let negative = CharacterSet(charactersIn: "-1")
  CharacterSet.decimalDigits.isSuperset(of: zero)
  CharacterSet.decimalDigits.isSuperset(of: negative)
  ```

&nbsp;

&nbsp;

> reference : [Understanding Swift's CharacterSet](<https://medium.com/livefront/understanding-swifts-characterset-5a7a89a32b54>)

&nbsp;
