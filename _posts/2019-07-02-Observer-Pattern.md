---
layout: post
title:  "[Design Pattern] Observer Pattern - 구독하고 알림받기"
date:  2019-07-02 21:52:59
author: Dana Lee
categories: [Design Pattern]
tags: [Observer Pattern]
lastmod : 2019-07-02 22:26:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

> 관심 있는 것을 구독하고 변경될 때마다 알림을 받을 수 있게 해주는 패턴 (Behavior Pattern 범주에 속함)

**Observer** pattern은 크게 두가지로 구성된다. 

1. **Subject** (publisher) : 속성의 변경이 있으면 구독자가 알림받고 싶어하는 주체
2. **Observer** (subscriber) : subject 가 변경될 때마다 알림을 받아서 그에 맞는 처리, 대응을 해야되는 object

&nbsp;

유투버나 인스타 등 sns에서 누군가를 `follow` 하면 그 사람이 새로운 영상이나 사진을 올리면 나에게 `notification` 이 오는 구조와 비슷하다. 변화를 감지해야 될 대상에 '내가 너를 관찰하고 있다' 라고 등록하면 변화가 있을 때마나 나에게 알려주는 방식이다.

어플리케이션 측면에서 어떤 곳에서 필요할지 생각해보자. 데이터가 바뀔 때마다 디스플레이도 바뀌어야 된다면? 현재 기온을 알려주는 앱이라면 시간이 지남에 따라 바뀌는 온도 데이터를 계속해서 업데이트 해줘야 한다. 이 경우 디스플레이는 Observer, 기온 데이터는 Subject 가 되어 기온데이터의 변화를 알림 받을 때마다 디스플레이를 업데이트 해주면 된다. 

MVC 환경에서 model 이 controller 에게 데이터가 변경되었다고 알려줄 때 주로 observer pattern 이 사용된다고 한다.

&nbsp;

## 자격요건 명세와 구현

![]({{site.url}}/assets/post-image/observer-pattern-diagram.png)

> **The Observer Pattern** defines a one-to-many dependency between objects so that when one object changes state, all of its dependents are notified and updated automatically.

### Subject 😎

1. register observer : observer 등록하기
2. remove observer : observer 등록 취소(제거)하기
3. notify : 변화가 있을 때 observer 에게 알려주기

subject는 자신을 구독한 observer list를 가지고 있다.

### Observer 😍

1. update : subject로 부터 알림을 받으면 취하는 행동

&nbsp;

### 구현

subject와 observer 의 자격 요건을 정의한 프로토콜을 채택해서 구현한다.

프로토콜을 사용해서 구현하는 이유는 subject와 observer 간의 의존도를 줄이고 loose coupling의 이점을 이용하기 위해서이다.

&nbsp;

### 장점 - loose coupling!

- 개별 객체의 property에 의존하지 않는다 
  - 구체적인 하위 class 의 속성과 메소드에 관계 없이 프로토콜에서 정의한 기능으로 소통한다
- 결합도가 낮다. 독립적이다 (loosely coupled) 
  - subject 와 observer 가 서로에 대해 아는 내용은 protocol 을 준수했다는 사실 뿐, 구체적인 구현은 몰라도 된다.
  - Loose coupling : 서로 의사소통은 하되, 서로에 대한 최소한의 정보만 가지고 있는다. 
- loosely coupled 의 장점
  - 서로의 변화에 영향을 받지 않는다. 
  - 재사용성이 높다
- subject가 데이터에 대한 유일한 주인(sole owner)이므로 observer 의 데이터에 대한 의존도가 낮아진다
  - observer에 데이터 변화와 그에 따른 처리도 다 들어있다면 모든 observer에 공통된 코드가 많아질 것

### 단점

observer 들에 의해 같은 동작이 반복해서 수행될 가능성이 있다.

&nbsp;

### 일대 다의 관계가 되어야 하는 이유

subject 는 데이터 state 와 그에 대한 처리(control)을 가지고, observer는 그 state를 가지고 있지 않더라도 이용하는 관계이다. 한 subject 의 state 를 원하는 여러개의 observer 가 있을 수 있기 때문에 일대다의 관계가 되어야 한다.

&nbsp;

### Example

유투버 뽀니가 새로 동영상을 올릴 때, 구독자에게 알림이 가는 시나리오

- `Subject`, `Observer` protocol 정의

  ```swift
  protocol Subject {
      func register(observer: Observer)
      func remove(observer: Observer)
      func notify(with data: String)
  }
  
  protocol Observer {
      var id: String { get }
      func update(_ updatedValue: String)
  }
  ```

  

- `Youtuber` class - `Subject` protocol 준수

  - 유투버가 영상을 올릴 때, observer 에게 `notify()`

  ```swift
  class Youtuber: Subject {
      let name: String
      var subscribers = [Observer]()
      
      init(name: String) {
          self.name = name
      }
      
      func register(observer: Observer) {
          subscribers.append(observer)
      }
      
      func remove(observer: Observer) {
          subscribers.removeAll(where: {$0.id == observer.id})
      }
      
      func notify(with videoTitle: String) {
          for subscriber in subscribers {
              subscriber.update(videoTitle)
          }
      }
      
      func uploadVideo(title: String) {
          print("\(self.name)이 새로운 영상 \(title)을 업로드 했습니다.")
          notify(with: title)
      }
  }
  ```

  

- `Subscriber` class - `Observer` protocol 준수

  - 알림을 받으면 시청하고 좋아요👍 를 누름

  ```swift
  class Subscriber: Observer {
      var id: String
      var nickname: String
      init(id: String, nickname: String) {
          self.id = id
          self.nickname = nickname
      }
      
      func update(_ videoTitle: String) {
          print("\(self.nickname)이 \(videoTitle) 시청")
          thumbsUp(for: videoTitle)
      }
      
      func thumbsUp(for videoTitle: String) {
          print("\(self.nickname)이 좋아요를 눌렀습니다.")
      }
  }
  ```

- 유투버 뽀니와 구독자 두명 생성, 구독자 등록하기

  ```swift
  let BBoni = Youtuber(name: "빵튜버 뽀니")
  
  let Dana = Subscriber(id: "dana123", nickname: "dana")
  let Kate = Subscriber(id: "kate111", nickname: "kate")
  
  // 구독하기
  BBoni.register(observer: Dana)
  BBoni.register(observer: Kate)
  ```

- 새로운 영상을 올리면?

  ```swift
  // 새로운 영상 올림
  BBoni.uploadVideo(title: "북촌 디저트 카페")
  
  /*결과
  빵튜버 뽀니이 새로운 영상 북촌 디저트 카페을 업로드 했습니다.
  dana이 북촌 디저트 카페 시청
  dana이 좋아요를 눌렀습니다.
  kate이 북촌 디저트 카페 시청
  kate이 좋아요를 눌렀습니다.
  */
  ```

&nbsp;



## iOS - NSNotificationCenter

*Foundation > NSNotificationCenter*

observer pattern 을 구현해 놓은 구현체이다. (Design pattern 은 추상적인 구조이고 framework나 library에는 이를 구현한 구현체가 있을 수 있다. 디자인 패턴 그자체가 framework or library는 아니다.)

NSNoficficationCenter 는 **subject - observer 사이에 위치**하여 indirection의 역할을 수행한다. 즉, subject 와 observer 사이에서 변화에 대해 알려주면 observer에게 notify 하는 역할을 담당한다. subject가 직접 주던 notification을 담당하는 것이다. 

![]({{site.url}}/assets/post-image/nsnotificationcenter1.png)

중간에 이렇게 indirection 이 하나 더 들어가게 되면 더 유연한 구조를 만들 수 있다. subject 는 더 이상 어떤 observer가 등록되어 있는지 몰라도 된다. NSNoficationCenter 가 알아서 처리해주기 때문이다. 그저 변화가 있으면 NSNotificationCenter 에 알려주기만 하면 자신의 일은 끝난다. <u>대신 일을 시키는 것이다.</u>

앞의 example 유투버 또한 비슷한다. 사실상 Youtuber 는 자신이 일일히 구독자에게 알림을 보내지 않다. 그저 동영상을 업로드 하면 Youtube 서비스, 구체적으로는 서버에서 그 일을 처리해준다.

또한 자신이 담당하던 notify() 일을 NSNoficationCenter 가 대신해주는 동안, Subject는 다른 일을 할 수 있다. 구현 방법은 동기 혹은 비동기 방식으로 가능하다. 

- 동기 - pushNotification - 보내는 거 끝날 때까지 기다림
- 비동기 - queue 에 넣는다 - 안 기다림. 일 시키고 다른일 할 수 있음

&nbsp;

### indirection 넣은 Example

![](![]({{site.url}}/assets/post-image/nsnotificationcenter2.png))

구조 : `Subject` - `NotificationCenter` - `Observer`

- `Subject` protocol : `NotificationCenter` 연결됨

  ```swift
  protocol Subject {
      var notificationCenter: NotificationCenter { get set }
  }
  ```

- `Observer` protocol : `NotificationCenter` 에 의해 불릴 method `update()`

  ```swift
  protocol Observer {
      var id: String { get }
      func update(with data: String)
  }
  ```

  

- `NotificationCenter` protocol : observer 등록, 제거, subject 에 의해 불릴 `post()`, observer 알려주는 `broadcast()`

  ```swift
  protocol NotificationCenter {
      func post(with data: String)
      func add(observer: Observer)
      func remove(observer: Observer)
      func broadCast(with data: String)
  }
  ```

- `Youtuber` class - `Subject` 채택

  ```swift
  class Youtuber: Subject {
      let name: String
      var subscribers = [Observer]()
      var notificationCenter: NotificationCenter
      
      init(name: String, notificationCenter: NotificationCenter) {
          self.name = name
          self.notificationCenter = notificationCenter
      }
  
      func uploadVideo(title: String) {
          print("\(self.name)이 새로운 영상 \(title)을 업로드 했습니다.")
          notificationCenter.post(with: title)
      }
  }
  ```

- `Subscriber` class - `Observer` 채택

  ```swift
  class Subscriber: Observer {
      var id: String
      var nickname: String
      init(id: String, nickname: String) {
          self.id = id
          self.nickname = nickname
      }
  
      func update(with videoTitle: String) {
          print("\(self.nickname)이 \(videoTitle) 시청")
          thumbsUp(for: videoTitle)
      }
  
      func thumbsUp(for videoTitle: String) {
          print("\(self.nickname)이 좋아요를 눌렀습니다.")
      }   
  }
  ```

  

- `YoutubeNotificationCenter` class - `NotificationCenter` 채택 

  - 편의상 한 subject 당 하나의 notification center 가 등록되어있다고 가정 (1:1 관계)

  ```swift
  class YoutubeNotificationCenter: NotificationCenter {
      var subscribers = [Observer]()
      
      init() {}
      
      func post(with title: String) {
          broadCast(with: title)
      }
      func add(observer: Observer) {
          subscribers.append(observer)
      }
      
      func remove(observer: Observer) {
          subscribers.removeAll {
              $0.id == observer.id
          }
      }
      
      func broadCast(with title: String) {
          for subscriber in subscribers {
              subscriber.update(with: title)
          }
      }
  }
  ```

- 유투버 생성, 알림센터 생성, 구독자 생성

  ```swift
  let youtubeNotificationCenter = YoutubeNotificationCenter()
  let Bboni = Youtuber(name: "빵튜버 뽀니", notificationCenter: youtubeNotificationCenter)
  
  let Dana = Subscriber(id: "dana123", nickname: "dana")
  let Kate = Subscriber(id: "kate111", nickname: "kate")
  ```

- 구독

  ```swift
  youtubeNotificationCenter.add(observer: Dana)
  youtubeNotificationCenter.add(observer: Kate)
  ```

- 새로운 동영상 업로드

  ```swift
  Bboni.uploadVideo(title: "빵 뷔페")
  
  /*결과
  빵튜버 뽀니이 새로운 영상 빵 뷔페을 업로드 했습니다.
  dana이 빵 뷔페 시청
  dana이 좋아요를 눌렀습니다.
  kate이 빵 뷔페 시청
  kate이 좋아요를 눌렀습니다.
  */
  ```

### observer 의 조건

- notification name - 어떤 알림을
- sender - 어떤 객체가
- 값이 nil 이면 상관없이 다 받는다는 의미

이 두가지 정보를 가지고 noticenter 가 어느 observer 에 보낼지 판단함

각 observer 가 설정한 두 조건에 다 부합하는 observer 에만 noti를 받음

&nbsp;

### MVC 패턴

![]({{site.url}}/assets/post-image/mvc-notificaioncenter.png)

Mvc 패턴에서 

상위 모듈 - 컨트롤러

하위 모듈 - 모델

모델은 어디서 자신이 사용되는지 모른다. 모델에 변화가 있으면 알려주는 일을 누가 담당해줘야 된다. 

알려주는 일을 NSNotificationCenter에 시키면 옵저버 등록된 애들에게 알려준다. 이때, 받는 대상, 즉 observer가 컨트롤러 혹은 뷰도 될 수 있다.

iOS 에서 컨트롤러와 뷰는 긴밀한 관계이다. 반면에 모델(하위)는 어떤 컨트롤러가 자신을 사용하는지 모름



inputview -> 자료구조 변경 -> 출력

입력을 받아서 어떤 모델을 변경할건지 판단해서 처리 하고, 변경이 끝나면 notify 줘서 알려준뒤, 그걸 처리하는 컨트롤러가 다시 그에 맞는 뷰를 업데이트한다



예시

좋아요 누름 -> 백엔드 서버에 알려줌 -> 내 팔로워가 내가 좋아요 누른걸 안다

​                        notificationcenter



입력-처리-출력으로 모든 시스템을 만들 수 있음



설계와 구현패턴을 구분해봐야 한다

- 설계 패턴
- 구현 패턴 - 언어마다 그 설계 구현을 위해 어떤 구조, 어떤 타입을 사용하는지

&nbsp;

## 🧐 다른 점 : publisher-subscriber pattern & observer pattern 

- publisher 는 subscriber 가 못받은 메시지를 queue에 넣고 있다가 다시 전해주는 동작도 더 필요
- 주로 메시지 관련 프로그램. 네트워크쪽, 통신쪽에서 많이 씀
- observer 가 더 구조적으로 나뉘어져 있고, publisher 는 더 메시지 관련
- 기본적인 아이디어는 동일

---

## :pushpin: Reference

- Head First Design Patterns