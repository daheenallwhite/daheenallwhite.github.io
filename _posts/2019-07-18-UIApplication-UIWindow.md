---
layout: post
title:  "[iOS] UIApplication, UIWindow - 가장 기본이 되는 class"
date:  2019-07-18 01:45:59
author: Dana Lee
categories: iOS
tags: [UIKit, UIApplicaion, UIWindow, event, App Life Cycle]
lastmod : 2019-07-23 17:18:59
sitemap :
  changefreq : weekly
  priority : 1.0
---



## UIKit Framework

- window and view architecture for implementing user interface
- event handling infrastructure for delivering Multi-Touch and other types of input to your app
- main run loop needed to manage interactions among the user, the system, and your app
- and other features..
- UIKit app의 core objects 를 제공
  - system 과 의사소통
  - 앱의 main event loop 실행하기
  - 보이는 스크린에 콘텐츠 보여주기 등..

![](https://docs-assets.developer.apple.com/published/4e7c26b6ad/ff7aa08f-4857-44ce-88d5-7dacbef84509.png)

- MVC 구조를 기반으로 한다.
  - model : 앱의 데이터와 비즈니스 로직 관리
  - view : 데이터의 시각적 표현을 제공
  - controller : model 과 view 사이의 연결자, 중재자

&nbsp;

## UIApplication 

**app 의 main event loop 를 실행시키고, 앱의 전반적인 라이프 사이클을 관리한다** 

- 들어오는 user event 를 그에 맞는 곳으로 연결해준다. 

- action message 를 적절한 target 객체로 보낸다.  

- `UIApplication` 은 `UIWindow` 객체 리스트를 가지고 있는데, 여기서 알맞은 `UIWindow` 객체에 event 를 보내서 적절한 `UIView` 객체가 받도록 한다.

-  `sendEvent(_ event: UIEvent)` method 통해서 적절한 reponder 객체가 받도록 함

- `UIEvent` : event 에 대한 정보를 캡슐화 한 클래스

- 메인 스레드 loop 가 event queue 의 애들을 하나씩 꺼내서 application object 에 전달한다.

  전달은 초당 몇십번씩

&nbsp;

## UIWindow

 **app user interface 의 배경, view 에 event 를 보내는 역할**

- Storyboard 는 app delegate 객체에서 `window` property가 반드시 있도록 요구함

- 주로 한 앱당 한 window 객체만 필요한데, 다른 외부 스크린에 contents 를 표시해야된다면 추가 window 가 사용될 수 있다. 

  ex. 하나의 앱을 애플 티비랑 폰에서 동시에 실행 - 윈도우는 두개, 앱은 하나

- 화면에는 항상 window & 최상위 root view 가 나옴

  - window 의 `rootViewController` property : window 를 채우는 vc 를 가리킴

- window 그 자체로는 시각적으로 보이지 않고, 대신에 다른 view 들을 보여주는 역할을 한다. 

