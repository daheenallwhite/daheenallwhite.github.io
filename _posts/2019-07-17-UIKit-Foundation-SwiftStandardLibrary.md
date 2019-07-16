---
layout: post
title:  "[iOS] UIKit, Foundation, Swift Standart Library - 무엇을 사용해야 할까?"
date:  2019-07-17 01:45:59
author: Dana Lee
categories: iOS
tags: [Cocoa, Cocoa Touch, Foundation, UIKit, Swift Standard Library]
lastmod : 2019-07-17 02:03:59
sitemap :
  changefreq : weekly
  priority : 1.0
---



## 🔍 UIKit / Foundation / Swift Standard Library 

![](/Users/allwhite/Desktop/blog/daheenallwhite.github.io/_posts/%7B%7Bsite.url%7D%7D/assets/post-image/relationship.jpg)

```swift
import UIKit
```

`UKit` import 하면 `Foundation`을 자동으로 import 해준다. 따라서 `UIKit` 을 import 하면 `Foundation` 을 import 할 필요 없음

```swift
import Foundation
import Swift
```

`Foundation`  은 Swift Standard Library 에 대한 reference 를 가지고 있음. 따라서 Foundation import 하면 Swift import 할 필요 없음

### 언제 어떤걸 써야 할까?

UIKit : user interface 포함한 app 개발할 때 - UITableViewController, UIAlertController 을 이용해야 할 때

Foundation : Strings, Dates를 사용해야 할 때, `NSObject`의 클래스 계층구조가 필요할 때

Swift Standard Library

> The Swift standard library implements the basic data types, algorithms, and protocols you use to write apps in Swift.

---

## 📌 Reference

- [Swift Standard Libary - Apple Developer Documentation](https://developer.apple.com/documentation/swift/swift_standard_library/)
- [Standard Library Design - Swift.org](https://swift.org/compiler-stdlib/#standard-library-design)
- [import swift vs. import foundation - stackoverflow](https://stackoverflow.com/questions/33943477/import-swift-vs-import-foundation)







##  

https://developer.apple.com/documentation/uikit/about_app_development_with_uikit