---
layout: post
title:  "[iOS] UIKit, Foundation, Swift Standart Library - 무엇을 사용해야 할까?"
date:  2019-07-17 01:45:59
author: Dana Lee
categories: iOS
tags: [Cocoa, Cocoa Touch, Foundation, UIKit, Swift Standard Library]
lastmod : 2019-07-18 23:39:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

&nbsp;

![]({{site.url}}/assets/post-image/relationship.jpg)

## UIKit import 하면 Foundation ?

```swift
import UIKit
```

`UKit` import 하면 `Foundation`을 자동으로 import 해준다. 따라서 `UIKit` 을 import 하면 `Foundation` 을 import 할 필요 없음

&nbsp;

## Foundation import 하면 Swift 는?

```swift
import Foundation
import Swift
```

`Foundation`  은 Swift Standard Library 에 대한 reference 를 가지고 있음. 따라서 Foundation import 하면 Swift import 할 필요 없음

&nbsp;

## 언제 어떤걸 써야 할까?

|                        |                                                              |
| ---------------------- | ------------------------------------------------------------ |
| UIKit                  | user interface 포함한 app 개발할 때 - `UITableViewController`, `UIAlertController` 을 이용해야 할 때 |
| Foundation             | Strings, Dates를 사용해야 할 때, `NSObject`의 클래스 계층구조가 필요할 때 |
| Swift Standard Library | Swift 기본 데이터 타입만 사용해도 될 때                      |



## UIKit document 에 나오는 설명

> The UIKit and Foundation frameworks provide many of the basic types that you use to define your app’s model objects. UIKit provides a [`UIDocument`](https://developer.apple.com/documentation/uikit/uidocument) object for organizing the data structures that belong in a disk-based file. The Foundation framework defines basic objects representing strings, numbers, arrays, and other data types. The [Swift Standard Library](https://developer.apple.com/documentation/swift/swift_standard_library) provides many of the same types available in the Foundation framework.

- UIKit, Foundation : app 의 model 객체를 정의하는데 사용될 기본 타입들을 제공함
- UIKit : UIDocument - disk-base fiile 에 속한 데이터의 구조를 구성하는데 사용됨
- Foundation : string, numbers, array 등의 기본적인 데이터 타입을 제공
- Swift Standard Library : Foundation 에 있는 타입과 다수의 같은 타입을 제공

&nbsp;

### :mag: Swift Standard Library

> The Swift standard library implements the basic data types, algorithms, and protocols you use to write apps in Swift.

---

## 📌 Reference

- [Swift Standard Libary - Apple Developer Documentation](https://developer.apple.com/documentation/swift/swift_standard_library/)
- [Standard Library Design - Swift.org](https://swift.org/compiler-stdlib/#standard-library-design)
- [import swift vs. import foundation - stackoverflow](https://stackoverflow.com/questions/33943477/import-swift-vs-import-foundation)
- [About App Development with UIKit - Apple Developer Documentation](https://developer.apple.com/documentation/uikit/about_app_development_with_uikit)

