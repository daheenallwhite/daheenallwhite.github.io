---
layout: post
title:  "[iOS] View Controller 가 보여지는 방식"
date:  2019-07-23 23:09:59
author: Dana Lee
categories: iOS
tags: [UIViewController, View Controller, presentedViewController]
lastmod : 2019-07-23 23:09:59
sitemap :
  changefreq : weekly
  priority : 1.0
---



## View Controller 가 보여지는 방식

Presentation : 기존의 view controller의 content 를 가리면서 새로운 view controller 의 contents 가 modal 방식으로 올라옴

새로운 vc 가 이전 vc 를 가리면서 보여질 때, **UIKit 은 이전과 이후 vc 간 관계를 형성해준다**. 두 vc 의 다음 property 에 서로를 연결해준다. 

```swift
var presentedViewController? : UIViewController
var presentingViewController? : UIViewController
```

| presentedViewController                       | presentingViewController        |
| --------------------------------------------- | ------------------------------- |
| 해당 vc 에 의해 presented 된 다음 vc를 가리킴 | 해당 vc 를 present 해준 이전 vc |

![](/Users/allwhite/Desktop/Codesquad/swift-photoframe/images/vc-relationship.jpeg)



Container vc 는 children vc 를 위한 자체 presentaion 방식을 제공하므로, 그 안에서의 전환은 container vc 에서 담당한다. 

![](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG-container-and-presented-view-controller_2-4_2x.png)

&nbsp;

- [추가 학습거리 - presenting a view controller](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/PresentingaViewController.html#//apple_ref/doc/uid/TP40007457-CH14-SW7)

---

## 📌 Reference

- [View controller Programming Guide for iOS](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/index.html#//apple_ref/doc/uid/TP40007457-CH2-SW1)

