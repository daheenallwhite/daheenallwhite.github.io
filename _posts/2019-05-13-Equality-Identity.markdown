---
layout: post
title:  "Equality/Identity - Protocol Equatable & Comparable"
date:   2019-05-13 14:16:00
author: Dana Lee
categories: [Swift, Equatable, Comparable]
tags:    Protocol Extension 
cover:  "/assets/instacode.png"
---



#### :pushpin: Table of Contents

- equality  vs.  identity
- Equatable protocol
- Comparable protocol

## :mag: equality  vs.  identity

두 상수나 변수가 같다/다르다 - 판단하는 기준

### equality (동일성)

관찰 가능한 특징으로서 두 인스턴스가 동일한 값(value)를 가질 때

`==`, `!=` 로 체크 가능

### identity (정체성)

메모리 상에서 같은 instance를 가리킬 때

`===` 로 체크 가능

&nbsp;

### value type 끼리 비교하기

Equality :ok_woman:  Identity :no_good:

- value type 은 메모리 기준으로 비교 불가. 값으로 항상 전달되기 때문에
- Swift standard library에서 정의한 value type이외에 다른 value type의 equality를 custom 하고 싶다면 Hashable, Equatable protocol 채택을 고려해야 함.
- Hashable 은 판별기준이 되는 value를 구분해주기 위한 hash value를 생성하기 위해 필요한 protocol

### reference type 끼리 비교하기

Equality, Identity 둘 다 :ok_woman:

- Reference type은 전달시, instance가 있는 메모리 위치에 참조를 추가하는 방식이므로 identity는 원래 가능

- Equality 도 비교하고 싶다면 Equatable protocol을 준수해야 함.
  - 구현에서 equality 를 비교할 판단기준이 될 value를 명시해 주어야 함

&nbsp;

---

# Equatable protocol

> *A type that can be compared for **value equality*** <br>
>
> value가 같은지, 다른지 비교가 가능한 type의 자격요건을 담은 protocol

```swift
protocol Equatable
```

- swift 에서 대부분의 basic typ이 Equatable protocol을 준수한다

&nbsp;

### Equatable protocol 준수하기

_Conforming to the Equatable Protocol_

1. 자동으로 conform하는 경우

   - struct : 모든 property가 Equatable 준수
   - enum *with* associated value: value type이 Equatable 준수하면 가능
   - enum *without* associated value : 선언 없이도 자동으로 준수

2. 직접 conformance 구현해야 하는 경우

   방법 : Required function 을 구현한다.

   ```swift
   static func == (lhs: Self, rhs: Self) -> Bool
   ```

   - infix (중위 연산자)
   - `!=` 는 `==` 의 부정으로 자동으로 설정됨
   - _Example_

   ```swift
   struct Sneakers {
   	let brand: String
     let modelNumber: Int
     let size: Int
   }
   
   extension Sneakers: Equatable {
     static func ==(ls: Sneakers, rs: Sneakers) -> Bool {
       return ls.brand == rs.brand && ls.modelNumber == rs.modelNumber
               && ls.size == rs.size
     }
   }
   ```

   ```swift
   let listOfSneakers = [Sneakers(brand: "pfflyers", modelNumber: 930905, size: 240),
                        Sneakers(brand: "nike", modelNumber: 789011, size: 235),
                        Sneakers(brand: "pfflyers", modelNumber: 123456, size: 240)]
   let mySneakers = Sneakers(brand: "pfflyers", modelNumber: 930905, size: 240)
   
   for sneakers in listOfSneakers {
     print(sneakers == mySneakers)
   }
   // true, false, false
   ```

   

Hashable, Comparable 의 Base protocol (Equatable protocol을 상속받은 protocol)

&nbsp;

---

# Comparable

> A type that can be compared using the relational operators `<`, `<=`, `>=`, and `>` <br>
>
> 비교 연산자로 비교가 가능한 type의 자격요건을 담은 protocol

```swift
protocol Comparable
```

비교가 가능하다

= 순서가 있다 (두 변수/상수 중에 어떤 것이 더 작다/크다)

&nbsp;= sort() 가 가능하다

&nbsp;

## Comparable protocol 준수하기

_Conforming to the Comparable protocol_

> `<` 와 `==` 규칙 구현하면 모든 순서가 생긴다 <br>
>
> 나머지 비교 연산자는 <, == 을 사용해서 구현할 수 있다

두 operation은 static function으로 선언되어 있다.

1. `==` : Comparable protocol은 **Equatable protocol을 준수한다** 

   ```swift
   extension Comparable: Equatable
   ```

2. `<` : Required function 구현하기

   ```swift
   static func < (lhs: Self, rhs: Self) -> Bool
   ```

   _Example : Date struct 에 conformance 추가하기_

   ```swift
   struct Date {
     let year: Int
     let month: Int
     let day: Int
   }
   
   extension Data: Comparable {
     static func < (lhs: Date, rhs: Date) -> Bool {
       if lhs.year != rhs.year {
         return lhs.year < rhs.year
       } else if lhs.month != rhs.month {
         return lhs.month < rhs.month
       } else if lhs.day != rhs.day {
         return lhs.day < rhs.day
       }
     }
     
     // since Comparable extends Equatable protocol
     static func == (lhs: Date, rhs: Date) -> Bool {
       return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
     }
     
     // 나머지 연산자는 ==, <를 사용해서 모두 구현 가능
     // 자동으로 만들어짐? 
     static func <= (lhs: Date, rhs: Date) -> Bool {
     	return lhs == rhs || lhs < rhs
     }
     
     static func > (lhs: Date, rhs: Date) -> Bool {
       return !(lhs < rhs)
     }
     
     static func >= (lhs: Date, rhs: Date) -> Bool {
       return !(lhs < rhs) || lhs == rhs
     }
   }
   ```

   ```swift
   let myBday = Date(year: 1993, month: 9, day: 5)
   let yourBday = Date(year: 1993, month: 2, day: 28)
   
   if myBday < yourBday {
     print("my birthday is earlier than yours") 
   } else {
     print("my birthday is not earlier than yours") // this statement will be executed 
   }
   ```

   `<` 구현 논리 :  각 property에 대해, 같지 않으면, 왼쪽 < 오른쪽 인가?

&nbsp;

---

## 정리

1. Equality 는 value 가 같은지/다른지

   Indentity 는 메모리상의 instance 위치/주소가 같은지/다른지

2. Equatable 은 type이 같은지/다른지 비교할 수 있는 능력을 가지게 해줌

   == 연산자를 구현하여 준수한다

3. Comparable 은 type의 순서를 정할 수 있는 능력을 가지게 해줌

   비교 연산자를 구현하여 준수한다

&nbsp;