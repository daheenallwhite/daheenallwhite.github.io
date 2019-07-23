---
layout: post
title:  "[iOS] View Controller Life Cycle"
date:  2019-07-23 23:09:59
author: Dana Lee
categories: iOS
tags: [UIViewController, View Controller, Life Cycle, viewDidLoad()]
lastmod : 2019-07-23 23:09:59
sitemap :
  changefreq : weekly
  priority : 1.0
---



## view controller loads their view lazily

- 요청이 있을 때, 그때 생성한다는 의미
- `view` property 에 접근할 때 되서야 view controller 가 생성하고 로드함
- 그 전에 미리 view 를 생성해 놓지 않음 
- [`loadView()`](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621454-loadview) method
  - `view` property 에 접근했는데, 그 값이 nil 이면 자동으로 호출되어 해당 vc 의 root view 를 생성한다.
  - 직접 호출하는 것은 권장되지 않음
  - Overriding 은 괜찮음

&nbsp;

## View Controller Life Cycle

vc 에는 view 의 상태와 관련된 method 가 있다. 이 method 들은 view 의 상태변화에 따라 호출되며, 이 method 를 override 하여 각 상태 변화 시기에 원하는 처리를 구현할 수 있다.

상태 변화 관련해서는 크게 두가지로 나눌 수 있다. - 메모리 관련 / visibility 관련

- 메모리 관련
  - loadView
  - `viewDidLoad()` : view 가 메모리에 올라오면 가장 먼저 실행되는 method ([이전 post 참조](https://daheenallwhite.github.io/ios/2019/07/11/View-Did-Load/))
  - didReceiveMemoryWarning() 
- Visibility 관련
  - `viewWillAppear()` : 스크린에 보이도록 view 를 준비해라
  - `viewWillDisappear()` : view 가 사라지니 그동안 변동된 내용이나 다른 정보를 저장해라
  - `viewDidAppear()` : 스크린에 view 가 보인 직후에 호출
  - `viewDidDisappear()` : 스크린에 view 가 사라진 뒤 호출

유의할 점은 한 vc 에서 다음 vc 로 넘어갈 때, will, did 의 순서이다. 다음은 **FirstViewController → NextViewController → FirstViewController** 순서대로 vc 간 전환했을 때, 각 method 가 호출되는 순서이다.

```
FirstViewController : viewDidLoad
FirstViewController : viewWillAppear
FirstViewController : viewDidAppear
-------------------------- // NextVC로 전환
NextViewController : viewDidLoad
FirstViewController : viewWillDisappear
NextViewController : viewWillAppear
NextViewController : viewDidAppear
FirstViewController : viewDidDisappear
--------------------
NextViewController : viewWillDisappear
FirstViewController : viewWillAppear
FirstViewController : viewDidAppear
NextViewController : viewDidDisappear

```

- viewDidLoad 는 맨 처음 생성시에만 호출된다
- 나타날 vc 가 appear 완료한 뒤에, 이전 vc 가 disappear 완료하는 것을 알 수 있다.

&nbsp;

### View State Transitions

![](https://docs-assets.developer.apple.com/published/f06f30fa63/UIViewController_Class_Reference_2x_ddcaa00c-87d8-4c85-961e-ccfb9fa4aac2.png)

&nbsp;

---

## 📌 Reference

- https://zeddios.tistory.com/43
- [View controller Programming Guide for iOS](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/index.html#//apple_ref/doc/uid/TP40007457-CH2-SW1)
- [UIViewcontroller](https://developer.apple.com/documentation/uikit/uiviewcontroller)