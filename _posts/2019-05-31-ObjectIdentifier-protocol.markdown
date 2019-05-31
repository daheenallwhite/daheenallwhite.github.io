---
layout: post
title:  "ObjectIdentifier protocol : object identity 비교하기"
date:   2019-05-31 15:44:59
author: Dana Lee
categories: Swift
tags: [ObjectIdentifier, Swift, identity operator]
cover:  "/assets/instacode.png"
---



# ObjectIdentifier

>  A unique identifier for a class instance or metatype.

객체의 Identity 가 같은지/다른지 판단해주는 struct

```swift
struct ObjectIdentifier
```

&nbsp;

- 사용되는 곳

  *Example*. `Equatable` protocol

  ```swift
  protocol Equatable {
    @inlinable // trivial-implementation
    public func === (lhs: AnyObject?, rhs: AnyObject?) -> Bool {
      switch (lhs, rhs) {
      case let (l?, r?):
        return ObjectIdentifier(l) == ObjectIdentifier(r)
      case (nil, nil):
        return true
      default:
        return false
      }
    }
  }
  ```

  &nbsp;

- Swift 에서는 **class instance** 와 **meta type** 만 unique identity를 가진다

- struct, enum, function, tuple 에는 identity 란 개념이 없다

- :mag: [eqaulity  vs.  Identity](https://daheenallwhite.github.io/swift/equatable/comparable/2019/05/13/Equality-Identity.html)

&nbsp;

- Identity Operator

  ```swift
  func === (lhs: AnyObject?, rhs: AnyObject?) -> Bool
  ```

  > Returns a Boolean value indicating whether two references point to the same object instance.

  reference 가 같은 instance 를 가리키는지 판단

&nbsp;

---

#### Reference

- [swift language guide - Identity Operator](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html#ID90)
- [apple developer documentation - ObjectIdentifier](https://developer.apple.com/documentation/swift/objectidentifier)

&nbsp;

&nbsp;

&nbsp;