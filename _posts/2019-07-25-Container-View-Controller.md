---
layout: post
title:  "[iOS] Container View Controller - child view controller 추가/삭제하기"
date:  2019-07-25 23:14:59
author: Dana Lee
categories: iOS
tags: [UIViewController, Container View Controller]
lastmod : 2019-07-25 23:14:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

&nbsp;

# Container View Controller

다른 vc 들을 담는 vc 로, 자신의 틀 안에서 여러 개의 child vc 를 관리하는 view controller. 이미 존재하는 전체 틀 내에서 특정 부분의 content 만 바뀌어야 되는 구조에서 주로 사용된다. 동시에 한개 혹은 여러개의 vc 를 보여줄 수 있다.

## 구현된 class

|                          | container 고정 요소                  | child vc 개수 |
| ------------------------ | ------------------------------------ | ------------- |
| `UINavigationController` | navigation bar (+ optional tool bar) | 1             |
| `UITabBarController`     | tab bar                              | 1             |
| `UISplitViewController`  | -                                    | 2             |

&nbsp;

## 구조

### Navigation View Controller

![](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_structure-of-navigation-interface_5-1_2x.png)

### Split View Controller

![](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG-split-view-inerface_5-2_2x.png)

### Tab Bar Controller

![](https://github.com/daheenallwhite/swift-photoframe/blob/photoframe-step6/images/tab-bar.jpeg?raw=true)

&nbsp;

## Child View Controller

- 접근

  ```swift
  var children: [UIViewController]
  ```

- 추가 

  1. parent(container vc) 에서 child 추가 - `addchild()`

  2. Child vc 의 root view 를 parent view 계층구조에 연결 - `addSubView()` 등...

  3. Child vc 의 root view 의 layout 관련 제약을 추가

  4. child 가 parent 에 추가되었음 - `didMove(toParent:)`

     ```swift
     // containerVC 내에서
     self.addChild(childVC)
     self.view.addSubView(childVC.view)
     self.view.addConstraints(childVC.view.constraints)
     childVC.didMove(toParent: self)
     ```

     

- 제거

  1. child 에서 parent 제거/이동 - `willMove(toParent:)` (nil이면 no parent)

  2. Child vc의 constraints 제거

  3. child vc 의 root view 를 parent view 계층에서 제거

  4. child에서 `removeFromParent()` 호출

     ```swift
     childVC.willMove(toParent: nil)
     childVC.view.removeFromSuperview()
     childVC.removeFromParent()
     ```

&nbsp;

### 