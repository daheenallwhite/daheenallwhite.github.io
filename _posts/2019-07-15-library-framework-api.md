---
layout: post
title:  "Framework, Library, API"
date:  2019-07-15 22:43:59
author: Dana Lee
categories: [Programming]
tags: [API, Framework, Library]
lastmod : 2019-07-15 22:43:59
sitemap :
  changefreq : weekly
  priority : 1.0
---



## Framework

프레임워크는 **소프트웨어 개발을 위한 개발 환경 및 토대, 즉, 기반 시설을 제공한다**. 앱의 운영을 위해 필수적으로 갖춰야 할 기반 요소 기능을 미리 만들어 둔 것이다. 특정 인프라나 환경에서 동작할 수 있도록 기반 시설을 담당해주는 것이 프레임워크의 역할이다. 일종의 사회간접자본, 국가 기반시설에 비유할 수 있다. 어떤 환경에서 동작하기 위한 가장 기본적인 토대를 마련해주는 것이다. 

예를 들어 한 나라의 도로는 주로 국가가 나서서 만든다. 물론 민간 자본도 있지만 대부분은 국가가 주도하여 건설한다. 이는 국가가 운영, 동작하기 위한 최소한의 기반시설이기 때문이다. 우리나라에도 국토교통부와 같은 기관이 있듯이 말이다.

소프트웨어 개발도 비슷하다. macOS 앱 개발을 위한 Cocoa, ios 앱 개발을 위한 Cocoa Touch 프레임워크가 그 예이다. 

&nbsp;

## Library

**공통으로 사용될 수 있는 특정한 기능들을 모듈화한 것이다.** 쉽게 말해 특정 기능(functionality)을 미리 만들어 두어 다른 여러 소프트웨어에서 라이브러리를 import 하여 그 기능을 사용할 수 있다. 내가 직접 기능을 구현할 수도 있지만 누군가가 이미 구현해 놓은 기능을 가져다 쓸 수 있다. 이때 미리 만들어 놓은 이 기능을 라이브러리라고 한다. 

iOS 에서 cocopod 을 통해 받아오는 SwiftyJSON 같은 것들이 전부 라이브러리다. 내가 json 파싱을 구현할 수도 있고, Codable 을 사용할 수도 있지만, 이미 다른 사람이 잘 구현해 놓은 resource 를 내 코드에 첨가하여 사용한다. 

&nbsp;

## Framework  vs.  Library

가장 큰 차이점은 이것 **없이도 앱이 동작할 수 있는지 여부**이다. 프레임워크는 소프트웨어가 개발되고 동작하는 기반 시설의 역할을 하므로 프레임워크가 없이는 앱이 동작할 수 없다. 반면에 라이브러리는 특정 기능을 미리 만들어 둔 것으로 사실상 앱에 같은 기능을 구현한 코드가 있다면 해당 라이브러리를 쓸 필요가 없다. 따라서 라이브러리가 없어도 앱은 동작할 수 있다.

![]({{site.url}}/assets/post-image/library-framwork-1.png)

![]({{site.url}}/assets/post-image/library-framwork-2.jpeg)

또한 구성 방식에서도 차이가 있다. 프레임워크는 기반 요소이므로 그 위(안)에서 구현된 코드가 실행된다. 반면에 라이브러리는 내가 구현한 코드가 라이브러리를 import 불러와서 사용한다. 프레임워크는 내 코드를 호출하고, 내 코드는 라이브러리를 호출한다. 

&nbsp;

## API (Application Programming Interface)

> an **application programming interface** (**API**) is a set of subroutine definitions, [communication protocols](https://en.wikipedia.org/wiki/Communication_protocols), and tools for building software 

API 는 **공통 소통 창구**이다. 소통하는데 최소한으로만 알면 되는 일종의 프로토콜이다. api의 구현은 다 다를 수 있지만 그 앞모습은 모두 같다. 이 공통된 앞모습을 api 라고 한다. [인터페이스](https://daheenallwhite.github.io/ios/2019/07/11/UITabBarController/)는 접촉하는 면, 중간에서 연결하는 역할을 한다. '이런 기능을 하고 싶으면 이 곳으로 연결하자' 라는 공통된 약속을 만들어 둔 것이 api이다.

![]({{site.url}}/assets/post-image/api.jpeg)

JDBC 로 예를 들어보자. JDBC 는 Java 에서 DBMS 에 접근할 수 있도록 해주는 API 이다. DBMS 에서 필요한 기능, select, update 같은 기능은 api 에서 정의, 선언해둔다. 실제 구현은 DBMS 를 제공하는 oracle 같은 회사에서 한다. 각 DBMS 별로 구성 방법이나 sql 문법은 차이가 있다. 하지만 Java 안에서 공통 소통 창구로 만들어 둔 API 를 사용해서 select 해주세요 라고만 요청하면 해당 DBMS 에서 구현한 코드를 수행하여 같은 select 기능을 가능하게 해준다.

이는 Swift 의 protocol 과도 유사하다. 이 프로토콜의 자격요건만 프로토콜에서 명시해두고, 구체적인 구현은 이를 채택하는 타입에서 하게된다. 해당 프로토콜을 준수하는 타입을 사용하는 곳에선 공통 소통 창구, 즉, 선언해둔 자격요건 함수나 속성을 호출하면 된다. 

---

## :pushpin: Reference

- [API - wikipedia](https://en.wikipedia.org/wiki/Application_programming_interface)
- [software library - wikipedia](https://en.wikipedia.org/wiki/Library_(computing))
- [Library vs. Framework](https://www.programcreek.com/2011/09/what-is-the-difference-between-a-java-library-and-a-framework/)