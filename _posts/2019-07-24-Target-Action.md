---
layout: post
title:  "[iOS] Target-Action : UIControl 객체가 이벤트에 응답하는 방식"
date:  2019-07-24 00:00:59
author: Dana Lee
categories: iOS
tags: [UIControl, Target-Action, UIButton, IBAction]
lastmod : 2019-07-24 00:00:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

&nbsp;

# Target - Action Design Pattern 

[`UIControl`](https://developer.apple.com/documentation/uikit/uicontrol) 객체가 이벤트에 응답하는 방식

control 이 직접 이벤트를 처리하지 않고, 처리할 target 과 처리하는 방식인 action method 로 넘기는 방식이다. UIControl 및 그 subclass 에서 이 방식으로 이벤트를 처리한다. 하위 클래스로 `UIButton`, `UIDatePicker`, `UISlider` 등이 있다. 

## terminology

- **sender** : action message 를 보내는 객체. event handling 담당
- **target** : action 이 호출될 객체. action message 를 받는 객체
- **action** : event 발생했을 때, 그에 응답하여 호출될 method
- **action message** : 이벤트 발생시 전송된, 불려지는 메세지

&nbsp;

## How it works

![](https://github.com/daheenallwhite/swift-photoframe/blob/daheenallwhite/images/sender-target.jpeg?raw=true)

- `UIControl.Event` : control 이 감지하고 응답할 수 있는 event

- 이 event 중, 특정 event 에 응답할 target 과 응답하는 방식을 구현한 action method 를 설정한다. 

- 설정하는 방법

  1. 코드 : control.addTarget() - **target, action method, event** 를 설정한다

     ```swift
     func addTarget(_ target: Any?, 
             action: Selector, 
                for controlEvents: UIControl.Event)
     
     //Example - view controller 내에서 IBOutlet 으로 연결된 button 객체
     button.addTarget(self, #selector(ViewController.touchActionMethod()), touch)
     ```

  2. Interface Builder : `@IBAction` 을 method 선언 앞에 명시한 뒤, 해당 method 와 인터페이스 빌더의 control 객체에서 원하는 event 와 연결한다.

     ```swift
     @IBAction func doSomething()
     @IBAction func doSomething(sender: UIButton)
     @IBAction func doSomething(sender: UIButton, forEvent event: UIEvent)
     ```

- target 은 어떤 object 도 될 수 있다. 주로 해당 control 을 가진 최상위 view 의 view controller 로 설정함

- user 가 control 과 상호작용 -> UIControl.Event type 에 연결된 이벤트가 그에 맞는 action method 를 trigger -> UIApplication 객체에 의해 처리를 담당할 알맞은 객체를 찾아 전달됨. 

&nbsp;

## IBAction

- 특정 객체에서 지정된 **이벤트** 발생시 일련의 프로세스를 실행

- 인터페이스 빌더의 객체의 특정이벤트 발생시 실행될 action method 앞에 붙여 인지할 수 있도록 해주는 역할

- Example : touchUpInside event 발생시, button title 바꾸기

  ```swift
  @IBAction func changeTitle(sender: UIButton) {
  	sender.title = "touched"
  }
  // changeTitle() 을 interface builder 에서 touchUpInside event 와 연결하기
  ```

&nbsp;

## UIButton

- 구현 

  ![](https://github.com/daheenallwhite/swift-photoframe/blob/daheenallwhite/images/button-simulation.gif?raw=true)

  - First : firstLabel background color - yellow 로 설정
  - Second: firstLabel text color - purple 로 설정

- 버튼 한 event 에 액션 여러 개 추가 가능할 수 있을까? - **가능** 

  ```swift
  secondButton.addTarget(self, action: #selector(FirstViewController.setTextColorPurple), for: .touchUpInside)
  
  secondButton.addTarget(self, action: #selector(FirstViewController.setBackgroundColorYellow(_:)), for: .touchUpInside)
  ```

  - `touchUpInside` event 에 action method 두 개 추가 -> 정상 동작함

- 버튼이 여러 개일 때 하나의 액션에 추가할 수 있는가? - **가능**

  - 서로 다른 button 의 event 에 같은 action method 등록 가능

- `UIControl.Event` : control 이 감지하고 응답할 수 있는 event

  | UIControl.Event        |                                                              |
  | :--------------------- | ------------------------------------------------------------ |
  | touchDown              | 컨트롤을 터치했을 때 발생하는 이벤트                         |
  | touchDownRepeat        | 컨트롤을 연속 터치 할 때 발생하는 이벤트                     |
  | touchDragInside        | 컨트롤 범위 내에서 터치한 영역을 드래그 할 때 발생하는 이벤트 |
  | touchDragOutside       | 터치 영역이 컨트롤의 바깥쪽에서 드래그 할 때 발생하는 이벤트 |
  | touchDragEnter         | 터치 영역이 컨트롤의 일정 영역 바깥쪽으로 나갔다가 다시 들어왔을 때 발생하는 이벤트 |
  | touchDragExit          | 터치 영역이 컨트롤의 일정 영역 바깥쪽으로 나갔을 때 발생하는 이벤트 |
  | touchUpInside          | 컨트롤 영역 안쪽에서 터치 후 뗐을때 발생하는 이벤트          |
  | touchUpOutside         | 컨트롤 영역 안쪽에서 터치 후 컨트롤 밖에서 뗐을때 이벤트     |
  | touchCancel            | 터치를 취소하는 이벤트 (touchUp 이벤트가 발생되지 않음)      |
  | valueChanged           | 터치를 드래그 및 다른 방법으로 조작하여 값이 변경되었을때 발생하는 이벤트 |
  | primaryActionTriggered | 버튼이 눌릴때 발생하는 이벤트 (iOS보다는 tvOS에서 사용)      |
  | editingDidBegin        | `UITextField`에서 편집이 시작될 때 호출되는 이벤트           |
  | editingChanged         | `UITextField`에서 값이 바뀔 때마다 호출되는 이벤트           |
  | editingDidEnd          | `UITextField`에서 외부객체와의 상호작용으로 인해 편집이 종료되었을 때 발생하는 이벤트 |
  | editingDidEndOnExit    | `UITextField`의 편집상태에서 키보드의 `return` 키를 터치했을 때 발생하는 이벤트 |
  | allTouchEvents         | 모든 터치 이벤트                                             |
  | allEditingEvents       | `UITextField`에서 편집작업의 이벤트                          |
  | applicationReserved    | 각각의 애플리케이션에서 프로그래머가 임의로 지정할 수 있는 이벤트 값의 범위 |
  | systemReserved         | 프레임워크 내에서 사용하는 예약된 이벤트 값의 범위           |
  | allEvents              | 시스템 이벤트를 포함한 모든 이벤트                           |

  - *Example* : touchUpOutside event 발생시 버튼 색 gray 로 변경

  ![](https://github.com/daheenallwhite/swift-photoframe/blob/daheenallwhite/images/touchUpOutside.gif?raw=true) 

---

## :pushpin: Reference

- [Target-Action - Boostcourse iOS](https://www.edwith.org/boostcourse-ios/lecture/16854/)
- [UIControl](https://developer.apple.com/documentation/uikit/uicontrol)

### 

## 