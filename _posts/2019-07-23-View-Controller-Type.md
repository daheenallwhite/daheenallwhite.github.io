---
layout: post
title:  "[iOS] View Controller의 두 가지 타입"
date:  2019-07-23 23:09:59
author: Dana Lee
categories: iOS
tags: [UIViewController, View Controller, Container View Controller, Root View Controller]
lastmod : 2019-07-23 23:09:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

> view controller 는 mvc 패턴에서 c로 view 와 model 사이의 중개자 역할을 한다. <br>구현체로 UIKit의 UIViewController 가 있으며, 이는 view 와 좀더 밀접하게 연결되어있다. 

# View Controller

view controller 는 앱 내부 구조의 기반이 된다. 모든 앱은 최소 한 개 이상의 vc 를 가지고 있다. `UIViewController` 클래스가 UIKit 에서 view controller 가 해야할 책임들을 선언해놓았다. 

vc 를 만들 땐, 주로 `UIViewController` class 를 서브클래싱(subclassing), 즉, 이를 상속받는 하위클래스를 만들어 구현한다. 주로 서브클래싱을 통해 사용하지 바로 UIViewController 에서 인스턴스를 생성하는건 드물다.

프로젝트를 생성하면 자동으로 이렇게 subclassing 된 view controller 클래스가 있다.

```swift
class ViewController: UIViewController {...}
```

&nbsp;

## 책임

App 에서 하는 모든 처리의 중심지라고 볼 수 있다. 그래서 iOS 의 vc 는 *massive view controller*  라고 불리기도 한다.

![]({{site.url}}/assets/post-image/role-of-vc.jpeg)

- View 의 content upate - 주로 관련 데이터의 변화에 맞춰서
- user interaction 에 view 로 응답하기 - event handling
  - 주로 대부분의 control delegate or target 을 vc에서 담당한다.
- view 사이즈 조절 / 전반적인 인터페이스 레이아웃 관리
- 앱의 다른 객체 - 주로 다른 view controller - 와 협력

## Type

![]({{site.url}}/assets/post-image/vc-type.jpeg)

|           | Content VC                                             | Container VC                                     |
| --------- | ------------------------------------------------------ | ------------------------------------------------ |
|           | 일반 VC                                                | 다른 vc 들을 담는 vc<br />(vc 를 담는 container) |
| 관리 대상 | root view & view hierarchy 내 모든 view                | 자신의 view & 자신의 child vc 의 root view       |
| 관련 속성 | `view` property : root view 를 참조                    | `children` property : [`UIViewController`]       |
|           | root view 위의 하위 view 들에 접근하려면 IBOutlet 사용 | children vc 의 root view 크기, 위치 등을 관리    |

- Container View Controller 

  - `UINavigationController`
  - `UISplitViewController`
  - `UITabBarViewController`
  - `UIPageViewController`

- Container View Controller  관련 method

  ```swift
  func addChild(UIviewcontroller)
  func removeFromParent()
  func willMove(toParent:)
  func didMove(toParent:)
  ```

&nbsp;

### Content VC

![](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_ControllerHierarchy_fig_1-1_2x.png)

&nbsp;

### Container VC

![](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_ContainerViewController_fig_1-2_2x.png)

&nbsp;

## 특징

- ios 에서 view 는 view controller 와 밀접하게 연결됨 (tightly bound)

- view 계층구조에서 event 관리를 책임진다

  - `UIViewController` 는 `UIResponder` 의 하위클래스로 reponder chain 에 들어감

  - chain 내 위치 : view controller 의 root view 와 그 view 의 super view 사이

    ![]({{site.url}}/assets/post-image/location-of-vc-in-reponder-chain.jpeg)

&nbsp;

## Root View Controller

`UIWindow` 는 `rootViewController` property 를 가진다. 이 속성은 딱 한개의 view controller 만 연결되고, 이 view controller의 content 로 window 가 채워지게 된다. 

root view 의 크기와 위치는 해당 root view 를 관리하는 vc 의 소유자에 따라 결정된다. root view 밑의 하위 view 의 크기와 위치는 auto layout constraint에 의해 결정된다.

### window 가 주인 

window 를 다 채우는 사이즈로 view 크기가 결정된다.

![](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG-root-view-controller_2-1_2x.png)

&nbsp;

### container view controller 

container view controller 가 정한 해당 view controller 의 root view 크기대로 보여짐

![](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG-container-acting-as-root-view-controller_2-2_2x.png)

&nbsp;

## view - view controller 연결/설정하는 방법

- Interface Builder : canvas 에 view controller object 추가 후, scene 선택 → Identity Inspector → Custom Class 에 view controller subclass 연결

  이 때, 자동 완성되어야 클래스가 제대로 생성된 것임

- code : `loadView()` method of view controller - view 계층을 프로그래밍으로 생성하고 view controller 의 root view 를 `view` property 에 할당해줌

---

## 📌 Reference

- [View controller Programming Guide for iOS](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/index.html#//apple_ref/doc/uid/TP40007457-CH2-SW1)
- [UIViewcontroller](https://developer.apple.com/documentation/uikit/uiviewcontroller)

