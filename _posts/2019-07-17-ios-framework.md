---
layout: post
title:  "[iOS] Cocoa, Cocoa Touch framework (코코아, 코코아터치 프레임워크)"
date:  2019-07-17 01:45:59
author: Dana Lee
categories: iOS
tags: [Cocoa, Cocoa Touch, Foundation, UIKit, Core Data]
lastmod : 2019-07-17 01:45:59
sitemap :
  changefreq : weekly
  priority : 1.0
---



## Cocoa & Cocoa Touch

cocoa 와 cocoa touch 둘 다 앱 개발 환경 (application environment)이다. 각각 macOS, iOS 에서 실행되는 앱을 개발하기 위한 API 이며, 이를 위한 프레임워크들을 포함한다. 

- Cocoa 는 Founcation, AppKit framework 를 포함하며 OS X에서 동작하는 앱을 개발하기 위해서 사용된다. 
- Cocoa Touch는 Founcation, UIKit framework 를 포함하며 iOS에서 동작하는 앱을 개발하기 위해 사용된다. 

### Cocoa environment

> Cocoa is **set of object-oriented frameworks** that provides a runtime environment for applications running in OS X and iOS.

Cocoa 는 여러 프레임워크가 포함한다. Foundation, AppKit, Core Data 등이 있다. 이들은 C, ANSI C, C++, Objective-C, Swift 로 구현되어 있다. 

### 특징

- mvc
- Late binding
- rich objects

&nbsp;

## Cocoa 의 역사

1980년대에서 90년대에 AppKit 과 Foundation 등의 프레임워크는 NeXT에 의해 NeXTStep 과 OpenStep 프로그래밍 환경에서 동작하는 프레임워크로 만들어졌다. 1996년에 Apple 이 NeXTStep 을 인수했고, macOS에 해당 프레임워크들이 삽입되었다. 

클래스 이름 중에 `NS` 로 시작하면 이는 NeXTStep 의 약자이다. 

&nbsp;

## Cocoa 이름의 유래

>  The resulting software framework received the name *Cocoa* for the sake of expediency, because the name had already been trademarked by Apple. For many years before this present use of the name, **Apple's *Cocoa* trademark had originated as the name of a multimedia project design application for children**. The application was [originally developed](https://en.wikipedia.org/wiki/Stagecast_Creator#History) at the [Apple Advanced Technology Group](https://en.wikipedia.org/wiki/Apple_Advanced_Technology_Group) under the name *KidSim*, and was then renamed and trademarked as "Cocoa". The name, coined by Peter Jensen who was hired to develop Cocoa for Apple, was **intended to evoke "Java for kids"**, as it ran embedded in web pages.[[3\]](https://en.wikipedia.org/wiki/Cocoa_(API)#cite_note-3) The trademark, and thus the name "Cocoa", was re-used to avoid the delay which would have occurred while registering a new [trademark](https://en.wikipedia.org/wiki/Trademark) for this software framework. The original "Cocoa" program was discontinued at Apple in one of the [rationalizations](https://en.wikipedia.org/wiki/Rationalization_(economics))that followed [Steve Jobs](https://en.wikipedia.org/wiki/Steve_Jobs)'s return to Apple. It was then licensed to a third party and marketed as [Stagecast Creator](https://en.wikipedia.org/wiki/Stagecast_Creator) as of 2011. …. (*wikipedia*)



Cocoa 원래 아이들을 위한 앱 디자인 프로젝트에서 나온 이름이다. 초반에는 어린이를 위한 Java 라는 생각을 떠올리도록 Cocoa라고 이름지었다. 그 이후에 이 이름이 다시 사용되게 되는데, 이 프레임워크에 새로운 이름과 트레이트 마크를 부여해서 오는 인지 딜레이를 막기 위함이었다.

현재 Cocoa 라는 용어는 objective-C 런타임을 기반으로 하고, NSObject 를 상속받는 모든 클래스 혹은 객체를 가리킬 때 사용된다. 

&nbsp;

## Cocoa & Cocoa Touch 를 구성하는 frameworks

### Foundation

>  The Foundation framework defines a base layer of functionality that is required for almost all applications.

가장 기반이 되고, 필수적인 기능을 정의한 framework

> Access essential data types, collections, and operating-system services to define the base layer of functionality for your app.

다음을 구현함

- NSObject 
  - 최상위 클래스
  - basic object behavior 를 선언해 놓은 클래스
- Fundamentals
  - Numbers, Data, Basic Values
  - Strings and Text
  - Collections
  - Dates and Times
  - Units and Measurement
    - 시간, 날짜 등의 단위
  - Data Formatting
  - Filters and Sorting
- internalization (국제화)
- Files and Data Persistence
  - 영속성(persistence)은 데이터를 생성한 프로그램의 실행이 종료되더라도 사라지지 않는 데이터의 특성을 의미한다.
- Networking
- XML processing 등등...

Foundation 은 framework, 즉, 앱 개발을 위한 기반 기능을 제공한다. Foundation 은 Objective - C 로 구현되어 있었다. Swift 의 등장에 따라 동일한 API 를 Swift 로 구현하여 사용할 수 있게 되었다. - [swift-corelibs-foundation](https://github.com/apple/swift-corelibs-foundation) 

&nbsp;

### UIKit

> for developing user interface<br/>
>
> Construct and manage a graphical, event-driven user interface for your iOS or tvOS app

User interface 개발 목적으로 만들어진 framework

- event handling
- drawing
- image-handling
- text processing
- typography
- interapplication data transfer
- user interface elements - views, sliders, buttons, text fields, and alert dialogs

AppKit과 user interface에 대한 목적은 같지만 platform 이 다르다 - AppKit은 OS X, UIKit은 iOS, tvOS

&nbsp;

### Core Data

> Persist or cache data and support undo on a single device. <br/>
>
> Use Core Data to save your application’s permanent data for offline use, to cache temporary data, and to add undo functionality to your app on a single device.

앱에서 지속되야하는 데이터(앱 종료되어도 저장되어 있어야 하는 데이터)를 관리하고 싶을 때 사용

---

## 📌 Reference

- [Cocoa(API) - wikipedia](https://en.wikipedia.org/wiki/Cocoa_(API))
- [애플공식문서 - Cocoa(Touch)](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/Cocoa.html)
- [애플공식문서 - Cocoa Fundamental Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/WhatIsCocoa/WhatIsCocoa.html#//apple_ref/doc/uid/TP40002974-CH3-SW16)
- [Foundation - Swift.org](https://swift.org/core-libraries/#foundation)
- [swift-corelibs-foundation](https://github.com/apple/swift-corelibs-foundation)
- [Cocoa Touch Framework - 부스트코스](https://www.edwith.org/boostcourse-ios/lecture/17994/)
- 