---
layout: post
title:  "[iOS] Navigation Controller - stack 구조로 계층적으로 화면 구현하기"
date:  2019-07-25 23:19:59
author: Dana Lee
categories: iOS
tags: [UIViewController, Container View Controller, UINavigationController]
lastmod : 2019-07-25 23:19:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

&nbsp;

# Navigation View Controller

- 계층구조로 구성된 content를 순차적으로 보여주는 container view controller
- stack 구조로 구현되어 있다 - navigation stack
- 계층 구조 탐색으로 앱 content 를 보여주기에 적절하다
- 한번에 한 child view controller 의 content 만 보여진다.
- ex. Setting, Clock

![](https://github.com/daheenallwhite/swift-photoframe/blob/photoframe-step6/images/container-view-controller-2.jpg?raw=true)

tree 구조처럼 상위 카테고리에서 점차 하위카테고리로 넓어져 가는 구조를 표현한다. 다시 상위 카테고리로 돌아가기 위해서는 가장 최근에 보여진 vc부터 역순으로 거쳐 가야된다. 즉, LIFO(Last In First Out) 특성의 stack 구조가 이를 구현하기에 적절하다. Navigation Conroller 의 pop/push method를 사용하여 보여지는 child view controller 를 변경한다. 

![](https://github.com/daheenallwhite/swift-photoframe/blob/photoframe-step6/images/container-view-controller-3.jpg?raw=true)

![](https://github.com/daheenallwhite/swift-photoframe/blob/photoframe-step6/images/container-view-controller-4.jpg?raw=true)



## 구성

![](https://docs-assets.developer.apple.com/published/83ef757907/NavigationViews_2x_e69e98a2-aaac-477e-9e33-92e633e29cc7.png)

&nbsp;

## Navigation Bar - UINavigationBar

- 화면 상단에 있는 항상 보여지는 bar

- root view 외의 모든 view 에서 **back** button 이 있어서, user 가 계층구조에서 다시 뒤로 올라갈 수 있게끔 해준다. 

- 현재 stack 의 top level 에 있는 view controller (`topViewController`) 가 변하면, 그에 맞게 navigation controller의 navigation bar도 그에 맞게 변한다.

- navigation bar button item : left, middle, right

  ![](https://docs-assets.developer.apple.com/published/dde7452123/3abba22e-4aef-47dd-b4e2-a9965c424338.png)

- View controller - `title` property 설정시 navigation bar의 가운데에 표시됨

&nbsp;

## Optional Tool Bar

- Tool bar 는 현재 content 에서 할 수 있는 조작을 보여주는 bar

- tab bar 는 content 간 전환에 사용됨. tool bar 는 현재 content 내에서의 가능한 동작을 보여주는 용도

  ![](https://github.com/daheenallwhite/swift-photoframe/blob/photoframe-step6/images/tool-bar.jpg?raw=true)

- Tool Bar 보여주기
  - `isToolBarHidden` property == false 이면 tool bar displayed
  -  Interface Builder 에서 ✅ Show Toolbar 
- Tool Bar item 추가하기
  - toolbar 가 보여질 때, 현재 활성화된(active) view controller 의 `toolBarItems` property 를 보여준다
  - view controller 의 toolBarItems (`UIBarButtonItem` type) 에 객체 넣어주면 tool bar에 item이 보인다.

&nbsp;

## Appearance

appearance 관련 callback (viewWillAppear, viewDidDisappear 같은) 에 container view controller 는 child vc 에게 이 알림들을 전달해야한다. 

`shouldAutomaticallyForwardAppearanceMethods` property 로 appearance 관련 콜백을 child vc로 전달할지 아닐지를 결정한다. true 이면 전달, false 이면 전달 안함. default 는 true. 이 전달 관련 처리를 직접 하고 싶다면 property 를 override 하여 false 로 설정하면 된다.

```swift
var shouldAutomaticallyForwardAppearanceMethods: Bool { get }
```



## 관련 property / method

```swift
var topViewController: UIViewController?
// navigation stack top 에 있는 vc

var visibleViewController : UIViewController?
// 현재 보이는 view 와 관련된 vc
// navigation stack top 혹은 navigation controller 그 자체에 modal로 보여지는 vc

var viewControllers: [UIViewController]
// 현재 navigation stack 에 있는 vc
```

&nbsp;

navigation stack 조작 method - 모두 처리 후 디스플레이 업데이트 함

```swift
func pushViewController(UIViewController, animated: Bool)
// vc 를 stack 에 push 하고 디스플레이 업데이트

func popViewController(UIViewController, animated: Bool) -> UIViewController?
// navigation stack top을 pop & 디스플레이 업데이트

func popToRootViewController(animated: Bool) -> [UIViewController]?
// root view controller 제외한 vc 모두 pop 후 디스플레이 업데이트

func popToViewController(UIViewController, animated: Bool) -> [UIViewController]?
// 특정한 vc가 navigation stack top 에 있을 때까지 pop & 디스플레이 업데이트
```

---

### 📌 Reference

- [View Controller Programming Guide for iOS](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/ImplementingaContainerViewController.html)

- [UINavigationController](https://developer.apple.com/documentation/uikit/uinavigationcontroller)