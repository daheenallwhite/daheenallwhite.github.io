---
layout: post
title:  "[Design Pattern] 디자인 패턴과 사용하는 이유"
date:  2019-07-09 17:43:59
author: Dana Lee
categories: [Design Pattern]
tags: [Behavior Pattern, Creational Pattern, Structural Patten]
lastmod : 2019-07-09 17:43:59
sitemap :
  changefreq : weekly
  priority : 1.0
---



> a general, [reusable](https://en.wikipedia.org/wiki/Reusability) solution to a commonly occurring problem within a given context in [software design](https://en.wikipedia.org/wiki/Software_design)<br>
> 빈번한(자주 발생하는, 흔히 발생하는) 문제에 대해 재사용 가능한 해결책으로 이미 검증된 해결방법

Design pattern 은 **문제 해결방법의 best practice** 이다. 비슷한 문제에 대해 해결한 방법들을 보니 공통된 방식이 사용되었다는 것이다. 대부분의 software 문제는 이미 예전에 누군가는 겪은 문제이고, 이를 해결하기 위해 여러 방법을 사용해 보았을 것이다. 그 방법들 중 이런 카테고리의 문제에는 어떤 방식이 좋은지 개발자들이 후기를 남겼고, 그 후기에서 자주 사용되는 공통된 패턴이 나타났다. 이 패턴을 모은 것이 design pattern 이다.

Design pattern 책의 부제는 *Elements of Reusable Object-Oriented Software* 이다. 재사용 가능하도록 객체 지향 소프트웨어를 설계하는 방법이다. 프로젝트에서 자주 사용되는 구조를 정형화한 것이다.

&nbsp;

### 사용하는 목적, 장점 🔆 

1. reusable, flexible : 재사용성을 높이고 변경을 쉽게 하도록 하는 구조

   경험 많은 개발자처럼 처음 보는 문제에 대해서도 단점을 최소화하는 설계가 가능함

2. 커뮤니케이션 : 구체적인 설명 없이 구조화된 패턴에 대한 사전 지식으로 커뮤니케이션에 드는 시간, 비용 절약 (shared terms). 새로 보는 소프트웨어에 대해서도 패턴에 대한 지식 기반으로 이해가 수월하다.

3. 설계 과정의 속도를 높일 수 있다 : 이미 검증되고 테스트된 구조이기 때문

&nbsp;

### 설계 방식에 대한 추상화

디자인 패턴은 스텝 1,2,3 명시하는 구체적인 구현체가 아니라 **추상화된 구조**이다. 구체적으로 어떤 클래스를 써라, 어떤 타입을 써라 가 아니다. 디자인 패턴은 **컨셉, 개념**일 뿐이고 각 언어, 혹은 프레임워크에서 이 패턴을 구현한다. 따라서 컨셉은 같지만 구현체는 조금씩 다를 수 있다.

디자인 패턴을 사용함에 있어서 정해진 정답은 없다. 항상 이 문제에는 이 정답만 있다고 알려주는게 아니라, 이런 문제에 이런 패턴을 사용해서 해결해보니 장단점이 뭐가 있더라 하는 제안일 뿐이다. 

&nbsp;

### 디자인 패턴의 분류

여러가지 디자인 패턴을 크게 다음 세 가지 부류로 나눌 수 있다. 

![](https://github.com/daheenallwhite/daheenallwhite.github.io/blob/master/assets/post-image/DesignPattern1.png?raw=true)

여기에 concurrency pattern도 추가되기도 한다. 데이터 lock 과 무결성 관련한 패턴인 것 같다.

각 카테고리에 해당하는 디자인 패턴은 다음과 같다

![](https://github.com/daheenallwhite/daheenallwhite.github.io/blob/master/assets/post-image/DesignPattern2.png?raw=true)

---

## 📌 Reference

- Design Pattern - Erich Gamma, Richard Helm, Ralph Johnson, Jone Vlisside 
- [Wikipedia - Software Design Pattern](https://en.wikipedia.org/wiki/Software_design_pattern)

