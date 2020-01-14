---
layout: post
title:  "[iOS|Rx] View Controller 의 Life Cycle 이벤트를 observing 하기"
date:  2020-01-14 22:37:59
author: Dana Lee
categories: [iOS, Rx]
tags: [RxViewController, RxAppState, methodInvoked, sentMessage, RxSwift]
lastmod : 2020-01-14 22:40:59
sitemap :
  changefreq : weekly
  priority : 1.5
---

# View Controller 의 Life Cycle 이벤트를 observing 하기

ViewController 의 Life Cycle 이벤트를 Observable sequence로 받아서, 구독해서 사용할 수 있다.

View model을 바인딩을 하는 등 여러가지 상황에서 view controller의 현재 상태를 알아야 하는 경우가 종종 필요하다. 가령 viewWillAppear 가 실행된 이후에 데이터 fetch를 시작해야던지, sub view 의 event 를 활성화 시켜야 한다면 life cycle event를 구독하여 받아 볼 수 있다면 유용할 것이다.

## ViewController + Rx

다음의 Library에서는 RxCoaoa에서 제공하는 메소드를 활용하여 UIViewController의 Life Cycle Event를 받아볼 수 있는 extension을 구현했다.

- [RxAppState](https://github.com/pixeldock/RxAppState)
  - UIViewController & UIApplication state 까지 구독 가능
- [RxViewController](https://github.com/devxoul/RxViewController)
  - UIViewController 의 life cycle event 를 ControlEvent type으로 사용 가능

&nbsp;

## Rx Implementation

둘의 라이브러리는 약간의 차이가 있지만, 핵심은 RxCoaoa 에서 AnyObject의 extension 에서 구현된 `methodInvoked()` 를 사용한다. 이 메소드는 Selector 로 넘겨준 메소드가 해당 객체에서 실행 된 이후에 event를 emit 한다.

RxAppState 에서는 UIViewController의 viewWillAppear 를 다음과 같이 wrapping 했다.

```swift
extension RxSwift.Reactive where Base: UIViewController {
	public var viewWillAppear: Observable<Bool> {
    return methodInvoked(#selector(UIViewController.viewWillAppear))
       .map { $0.first as? Bool ?? false }
  }
}
```

&nbsp;

`methodInvoked()` 코드 쪽을 보면 구현이 비슷한 `sentMessage()` 라는 메소드도 있다.

둘의 차이점은 Selector로 넘겨준 메소드가 호출되기 전/후에 알려준다는 점이다.

```
sentMessage()  ----- 메소드 호출 ----- methodInvoked() 
```

RxCocoa 내의 설명 부분도 다음과 같다

- sentMessage

  > Each element is produced **before** message is invoked on target object.

- methodInvoked

  > Each element is produced **after** message is invoked on target object.

