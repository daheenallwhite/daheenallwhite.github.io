---
layout: post
title:  "[Swift] Pattern 과 Pattern Matching"
date:  2019-07-01 21:52:59
author: Dana Lee
categories: Swift
tags: [Pattern, Pattern Matching]
lastmod : 2019-07-01 22:26:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

> A *pattern* represents the structure of a single value or a composite value.

![]({{site.url}}/assets/post-image/Pattern.png)

## For Destructing Values - 값 추출하는 패턴

### Wildcard Pattern

underscore `_`

```swift
for _ in 1...10 {
	// do something ten times
}
```



### Identifier Pattern

값을 변수나 상수 이름에 연결짓는 것

```swift
let age = 27
```



###  Value-Binding Pattern

> Bind : v. 결합하다, 묶다

패턴에 맞는 값을 상수나 변수 이름에 연결짓는 것

```swift
let point = (2, 4)

switch point {
	case let (x, y): //(let x, let y) 도 같은 의미
  	print("point: \(x), \(y)")
}

switch point {
  case (let i, _):
  	print("\(i)")
}

switch point {
  case(_, var j):
  	j += 10
  	print("move point up \(j)")
}
```



### Tuple Pattern

```swift
let points = [(0, 0), (1, 0), (1, 1), (2, 0), (2, 1)]
// This code isn't valid.
// because the element - in the tuple pattern (x, 0) is an expression pattern
for (x, 0) in points {
    /* ... */
}
```



괄호안에 element 가 하나인 경우는 tuple pattern 이 적용 안됨. 

다음 세개는 다 동일한 의미 (equivalent)

```swift
let a = 2
let (a) = 2
let (a) : Int = 2
```

&nbsp;

## for full pattern matching

### Enumeration Case Pattern

`switch` 문 만 case 를 쓸 수 있는게 아니다!

`If`, `while`, `guard`, `for-in` 구문 안에서도 case 조건 사용할 수 있다!

```swift
let aString = "ABC"
if case "ABC" = aString { // }
  
enum Dish {
 case pasta(taste: String)
 case chicken(withSauce: Bool)
 case airRice
}
  
var dishes = [Dish]()
var myDinner : Dish = .pasta(taste: "cream")
dishes.append(myDinner)
if case .pasta(let taste) = myDinner { }
  
myDinner = .chicken(withSauce: true)
dishes.append(myDinner)
while case .chicken(let sauced) = myDinner {
 break
}
  
myDinner = .airRice
dishes.append(myDinner)
if case .airRice = myDinner { }
  
for dish in dishes {
 switch dish {
 case let .pasta(taste): print(taste)
 case let .chicken(sauced): print(sauced ? "양념" : "후라이드")
 case .airRice: print("공기밥")
 }
}
```



### Optional Pattern

```swift
let someOptional: Int? = 42
// Match using an enumeration case pattern.
// optional은 enum 으로 구현되어있음 .some(Wrapped), .none
if case .some(let x) = someOptional {
    print(x)
}

// Match using an optional pattern.
if case let x? = someOptional {
    print(x)
}
```

optional value로 구성된 배열이 for 반복문 돌 때, nil 아닌 값만 수행되도록 하는 방법

```swift
let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]
// Match only non-nil values.
for case let number? in arrayOfOptionalInts {
    print("Found a \(number)")
}
// Found a 2
// Found a 3
// Found a 5
```



### Type Casting Pattern

`is` type

pattern `as` type



### Expression Pattern

```swift
let point = (1, 2)
switch point {
case (0, 0):
    print("(0, 0) is at the origin.")
case (-2...2, -2...2):
    print("(\(point.0), \(point.1)) is near the origin.")
default:
    print("The point is at (\(point.0), \(point.1)).")
}
// Prints "(1, 2) is near the origin."

```

infix operator `~=` : pattern match (Precedence group -comparison Precedence)

`~=`  operator를 overloading 해서 expression matching behavior 커스텀하기

```swift
// Overload the ~= operator to match a string with an integer.
func ~= (pattern: String, value: Int) -> Bool {
    return pattern == "\(value)"
}
switch point {
case ("0", "0"):
    print("(0, 0) is at the origin.")
default:
    print("The point is at (\(point.0), \(point.1)).")
}
// Prints "The point is at (1, 2)."
```



---

## :pushpin: Reference

- https://outofbedlam.github.io/swift/2016/04/04/PatternMatching/
- https://docs.swift.org/swift-book/ReferenceManual/Patterns.html#
- https://alisoftware.github.io/swift/pattern-matching/2016/03/27/pattern-matching-1/ (유용한 패턴 매칭 예시)
- https://alisoftware.github.io/swift/pattern-matching/2016/03/30/pattern-matching-2/
- https://alisoftware.github.io/swift/pattern-matching/2016/04/24/pattern-matching-3/