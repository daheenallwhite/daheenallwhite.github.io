---
layout: post
title:  "UITabBarController - tab bar와 다른 view controller가 들어있는 conatainer"
date:  2019-07-11 18:33:59
author: Dana Lee
categories: iOS
tags: [iOS, UIKit, View Controller, UITabBarController]
lastmod : 2019-07-15 21:01:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

## Interface 인터페이스란?

계속해서 나오는 `인터페이스` 란 단어에 대해 용어 정리를 먼저 하고 들어가려고 한다. 사전적 의미는 다음과 같다. 

> 접촉(면), 경계(면)<br>
>
> The **interface** between two subjects or systems is the area in which they [affect](https://www.collinsdictionary.com/dictionary/english/affect) each other or have links with each other.

공통적으로 나오는 의미는 link(연결, 접촉) 이다. 인터페이스는 주로 중간에서 연결해주는 역할을 하는 장치나 소프트웨어에서 많이 사용되는 용어다. 

app 에서는 <u>사용자와 view</u> 가 서로 접촉한다. 앱에 display 되는 여러 view 중 하나를 선택하면 그에 맞는 처리가 되도록 view controller에 view 가 알려준다. User - Controller 사이에서 연결을 담당하는 것이 view가 된다. 따라서 **사용자와 앱이 서로 의사소통 할 수 있도록 중간에서 연결을 담당하는 모든 것이 app에서의 인터페이스이다.** 그 중에 하나가 view 이다. 

&nbsp;

## ViewController

> Manage your interface using view controllers and facilitate navigation around your app's content

view controller는 `UIKit` 앱의 사용자 인터페이스를 관리한다. view가 사용자로부터 user interaction을 받아 vc에 넘기면 그에 맞는 적절한 처리를 한다. 한 개의 view controller 는 한 개 이상의 view를 관리하며, 한 개의 app은 최소 한 개 이상의 view controller를 가지고 있다. 

view controller는 다시 2가지로 나눌 수 있다 - 일반적인 view controller 그리고 container view controller

**container view controller**는 다른 view controller를 자신의 root view 에 심는다(넣는다). 말 그대로 <u>다른 view controller 를 넣을 수 있는 틀</u>이 된다. view controller 한 개 이상을 자신이 감싸는 형태이므로 **container** 용어가 사용한 것으로 추측된다. 자신 안에 다른 view controller들을 가지고 있다가 특정 조건 혹은 인터랙션에 맞는 view controller를 보여주는 역할을 한다. navigation bar 의 처리를 담당하는 `UINavigationController` , tab bar 아이템 선택(모드)에 따라 지정된 view controller의 root view를 보여주는 `UITabBarController` 등이 이에 속한다. 일종의 view controller

&nbsp;

## Tab View Interface

tab bar 는 화면 가장 하단에 위치하여, 모드 선택에 따라 그에 맞는 view를 보여주는 인터페이스이다. 

### UITabBarController

```swift
class UITabBarController : UIViewController
```

> A **container view controller** that manages a radio-style selection interface, where the selection determines which child view controller to display.

tab bar 선택에 따라서 보여질 child view controller 를 결정하고, 관련된 처리를 담당하는 container view controller 이다. tab bar view(화면 하단) 과 선택하면 나올 view 들을 감싸는 container이다. tab bar 에 보여지는 tab bar item 은 각각 view controller 와 연결되어 있다. 

- `var viewControllers: [UIViewController]? ` 
  - tab bar controller 에 의해 보여질 child view 들의 root view 를 가지고 있는 속성
  - 이 배열의 순서 == 연관된 tab bar item 순서 (tab bar 에서 보여지는 순서)
- `var selectedViewController: UIViewController?`
  - 맨 처음 보여지는 view 의 view contoller
  - 현재 보여지는 view의 view controller
- `var tabBar: UITabBar` : tab bar view 를 관리하는 controller
- [`UITabBarControllerDelegate`](https://developer.apple.com/documentation/uikit/uitabbarcontrollerdelegate) : tab bar interface 와 user 간의 interaction 이 발생하면 tab bar controller가 delegate에 알림을 보낸다.

### UITabBar

```swift
class UITabBar : UIView
```

> A control that displays one or more buttons in a tab bar for selecting between different subtasks, views, or modes in an app.

주로 `UITabBarController` 에서 연결되어 사용되지만, 단독으로도 사용이 가능하다. tab bar iterm 을 여러 개 가질 수 있으며 `UITabBarIterm` 객체로 구현된다. 

&nbsp;

![container view controller diagram]({{site.url}}/assets/post-image/UITabBarViewController.png)

### 🔍 tool bar & tab bar

둘 다 화면 bottom edge 에 보여지는 bar

- Tool bar는 현재 화면에 대한 추가적인 조작 버튼을 담은 bar 

  (contains buttons for performing actions relevant to the current view or content within it)

- tab bar는 화면을 item에 맞게 다른 섹션 전환해주는 radio button 기능을 담은 bar. 흐름이 완전 바뀐다.

  (provides the ability to quickly switch between different sections of an app)

---

## :pushpin: Reference

- [UITabBarController](https://developer.apple.com/documentation/uikit/uitabbarcontroller)
- [UITabBar](https://developer.apple.com/documentation/uikit/uitabbar)
- [View Controllers](https://developer.apple.com/documentation/uikit/view_controllers)
- [UIKit](https://developer.apple.com/documentation/uikit)