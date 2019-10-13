---
layout: post
title:  "[iOS] Notification Center - 관찰해서 알려주는 역할"
date:  2019-10-13 18:12:59
author: Dana Lee
categories: [iOS]
tags: [NoficiationCenter, Observer Pattern]
lastmod : 2019-10-13 18:12:59
sitemap :
  changefreq : weekly
  priority : 1.5
---

# NotificationCenter

> 미리 등록된 observer 들에게 notification 을 전달하는 역할의 클래스

`NotificationCenter` 클래스는 Observer pattern 에서 observer 를 등록하고, notification 을 주는 역할만 빼서 추상화 레벨을 올린 구현체이다. 기존의 Observer pattern 에서는 Subject 가 observer list를 관리하고, 알림을 줄 일이 발생하면 직접 notification을 dispatch 했다면, 이제는 notification dispatch 도 외주를 맡기는 셈이다.

subject 와 observer 둘다 NotificationCenter 에만 등록되어 있다면 그에 맞는 notification 발생시 NotificationCenter에서 그에 맞는 일을 알아서 해준다.



iOS 의 MVC 패턴에서는 주로 model 이 subject, view controller 가 observer 가 된다. 만약 model 에 변화가 생기면 그에 맞는 view를 변화시켜야 한다면, view controller가 model의 변화 notification에 observer 등록하고, model에서 update가 생기면 post notification을 하면 된다.

![]({{site.url}}/assets/post-image/notification-center-1.jpeg) 

&nbsp;

### NotificationCenter 생성

- app's default notification center

  ```swift
  class var `default` : NotificationCenter { get }
  
  // usage
  NotificationCenter.default.addObserver(....)
  ```

  

- 직접 notificationcenter 객체를 생성할 수도 있다. (default만이 답이 아닐수도 있다.)

  - NotificationCenter 으로 notification 이 오면, center 는 등록된 observer list를 모두 스캔한다. 
  - 이는 앱 성능을 저하시킬 가능성이 있다
  - 따라서, 적절히 하나 이상의 notification center를 만들어 사용하는 게 notification 이 발생했을 때, observer 스캔하는데 드는 시간을 줄여 앱 performance를 높여줄 수 있다.

&nbsp;

## Notification

같은 클래스에서 발생한 notification 이라도 다른 notification 으로 post 하고 싶을 수 있다. 예를 들어 어떤 array list 에 아이템이 추가된 경우와, 삭제된 경우를 구별하고 싶다면 각각에 맞는 Notification 객체가 전달되어야 한다. 

`NotificationCenter` 를 통해 모든 observer 에게 전달되는 `Notification` 구조체가 있다. 해당 구조체엔 notification 정보가 담겨있고, 해당 알림을 등록한 observer 에게만 전달된다.

> Notification : A container for information broadcast through a notification center to all registered observers

### Notification 객체 생성

string으로 고유의 indentifier를 넣어 notification을 생성해준다.

```swift
let creationNotificationo = Notification.Name("InformationCreated")
```

&nbsp;

## Notification 등록하고 반응하기

observer pattern 개념을 구현한 `NotificationCenter` 이므로, observer 를 등록하고 notification 을 post 하는 원리는 동일하다. 

- 등록 : `addObserver(--)`
- 알림 : `postNotification(--)`

&nbsp;

### Example : 스크린샷 에 observer 등록해서 알림받기

앱을 실행 중에, 사용자가 스크린샷을 찍는 notification 을 observing 해보자.

- UIKit 에서 사전에 정의된 스크린샷 notification 이 있음

  ```swift
  UIApplication.userDidTakeScreenshotNotification
  // Posted when the user presses the Home and Lock buttons to take a screenshot.
  ```

  

- AppDelegate 에서 `didFinishLaunchingWithOption` method 에서 default notification center 에 스크린샷 notification 이 오면 alert 를 띄우는 method 가 실행되도록 등록한다

  ( `didFinishLaunchingWithOption` method - 런칭 프로세스가 거의다 끝났고, 앱을 실행할 준비가 거의다 되었다고 알리는 delegate method )

  ```swift
  // AppDelegate.swift 
  // inside of didFinishLaunchingWithOption method
  
  NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: nil,  using: applicationUserDidTakeScreenshot)
  ```

- notification 이 오면 실행 될 method 를 구현한다

  root view controller 위에 alert를 띄워보자

  ```swift
  func applicationUserDidTakeScreenshot() {
    guard let keywindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
              let rootVC = keywindow.rootViewController else {
              return
          }
          let alert = UIAlertController(title: "스크린샷 감지", message: "스크린샷이 감지되었습니다.", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
              NSLog("The \"OK\" alert occured.")
          }))
          rootVC.present(alert, animated: true, completion: nil)
  }
  ```

&nbsp;

## Observer 등록하기 (2가지)

```swift
func addObserver(forName name: NSNotification.Name?, 
          object obj: Any?, 
           queue: OperationQueue?, 
           using block: @escaping (Notification) -> Void) -> NSObjectProtocol
```

>  **name**-notification이 **object** 에서 발생하면 **block** 이 실행된다

#### name: NSNotification.Name

- observer 를 등록할 notification 의 이름
- 해당 name 을 가진 notification 만 operation queue에 block 을 넣을 수 있다.
- NSNotification.Name : NSString class 

#### object 

- observer 가 이 객체의 notification을 받고 싶어함
- 이 object 로 부터 전달된 notification 만 observer에게 전달된다.
- notification **sender**
- nil 일 경우 : notification sender 를 notification 을 observer 에 전달할지 결정할 때 사용하지 않는다

#### queue

- block 이 들어갈 operation queue
- nil 일 경우 : posting thread 에서 동기로 실행됨

#### block

- notification 을 받으면 실행될 block



```swift
func addObserver(_ observer: Any, 
        selector aSelector: Selector, 
            name aName: NSNotification.Name?, 
          object anObject: Any?)
```



#### observer



#### selector

- receiver 가 observer에게 보내는 알림이 어떤 메시지인지 구체적으로 알려주는 것



#### name

- observer 를 등록할 notification 의 이름

#### object

- observer 가 이 객체의 notification을 받고 싶어함



---

### :pushpin: Reference

- [NoficationCenter - Apple Documentation](https://developer.apple.com/documentation/foundation/notificationcenter)
- [How to resolve: 'keyWindow' was deprecated in iOS 13.0](https://stackoverflow.com/questions/57134259/how-to-resolve-keywindow-was-deprecated-in-ios-13-0)

