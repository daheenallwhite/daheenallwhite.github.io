---
layout: post
title:  "[iOS] View Controller 생성 관련 메소드 정리 - instantiateViewController & viewDidLoad"
date: 2020-01-29 17:55:59
author: Dana Lee
categories: [iOS]
tags: [UIViewController, Storyborad, instantiateViewController, viewDidLoad]
lastmod : 2020-01-29 17:55:59
sitemap :
  changefreq : weekly
  priority : 1.5
---



## viewDidLoad & instantiate - 언제 호출될까?

View Controller 객체 생성과 관련된 메소드 두 가지가 있다.

1. Storyboard 객체를 통해 ViewController 를 생성하는 [`instantiateViewController(:..)` ](https://developer.apple.com/documentation/uikit/uistoryboard/1616214-instantiateviewcontroller)
2. UIViewController 의 [`viewDidLoad()`](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621495-viewdidload)

View Controller 의 life cycle에 따른 구현이 필수이기 때문에 꼭 알고 넘어가야 한다.

storyboard를 통한 생성은 memory allocation 이며, viewDidLoad는 해당 view controller 의 모든 subview가 메모리에 로드된 후 불린다. 

> storyboard를 통해 view controller 객체를 생성 != 해당 view controller의 하위 view 가 메모리에 로드되었음

&nbsp;

### Storyboard - instantiateViewController

> Creates the view controller with the specified identifier and initializes it with the data from the storyboard.

- storyboard 파일로 부터 데이터를 불러와서 view controller를 생성한다
- **메모리 공간의 allocation 을 의미**
- 이 메소드가 호출될 때마다, `init(coder: )` method 를 통해 매번 새로운 view controller 인스턴스를 생성한다

&nbsp;

### viewDidLoad()

> Called after the view controller’s view has been loaded into memory.

- 해당 view controller 의 모든 view 들이 memory 에 로드 되었을 때 호출된다
- **해당 view controller가 가진 view hierarchy 의 모든 subview 들이 메모리에 올라왔음을 의미**
- 따라서 이 메소드를 override 해서 subview configuration 이 가능