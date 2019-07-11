---
layout: post
title:  "[UIKit] viewDidLoad() 메소드는 언제 호출될까?"
date:  2019-07-11 18:33:59
author: Dana Lee
categories: iOS
tags: [iOS, UIKit, View Controller, viewDidLoad()]
lastmod : 2019-07-09 18:33:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

## viewDidLoad()

`UIViewController` 의 method로 **메모리에 view controller 가 올라오면 가장 먼저 실행**된다. 주로 추가적인 초기화 작업을 구현하기 위해 오버라이딩 되어 사용된다. 

### print(#file, #line, #function, #column) 을 viewDidLoad() 안에서 실행한 결과

해당 함수는 어떤 파일 몇번째 줄에서 어떤 어떤 함수가 실행되고 있는지를 출력해준다.

- tab bar controller 에 2개의 view controller 가 연결된 상태
- 실행하면 `FirstViewController` 의 `viewDidLoad()` 실행됨
- Tab bar에서 두번째 선택시, `SecondViewController` 의 `viewDidLoad()` 실행됨
- 그 뒤로는 아무리 tab bar item 바꿔도 어떤 vc `viewDidLoad()` 도 실행되지 않는다.
- 해석: view controller object 가 처음 메모리에 올라올 때만 `viewDidLoad()`가 실행되고, 그 뒤의 전환은 이미 메모리의 객체를 사용하기 때문. 메모리에 두 개의 view controller가 올라와 있음을 확인할 수 있다.

```
/Users/allwhite/Desktop/Codesquad/swift-photoframe/PhotoFrame/PhotoFrame/FirstViewController.swift 15 viewDidLoad() 40 <- 맨 처음 실행시
/Users/allwhite/Desktop/Codesquad/swift-photoframe/PhotoFrame/PhotoFrame/SecondViewController.swift 15 viewDidLoad() 40 <- second item 맨 처음 선택시
```

![viewDidLoad]({{site.url}}/assets/post-image/viewDidLoad.png)

---

## :pushpin: Reference 

[documentation - viewDidLoad() method](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621495-viewdidload)