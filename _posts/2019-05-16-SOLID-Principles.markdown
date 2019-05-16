---
layout: post
title:  "SOLID Principles"
date:   2019-05-16 18:40:59
author: Dana Lee
categories: [Programming, OOP, SOLID principles]
tags: SOLID, OOP, CRC, object, indirection
cover:  "/assets/instacode.png"
---

# SOLID principles 

_소프트웨어 확장을 위해서 꼭 이해하고 고려해야 하는 원칙_

&nbsp;

## What is SOLID principles ? :confused:

> 프로그램의 확장성을 높여주고, 구조를 확실하게 이해할 수 있게 해주는 코드의 특성 5가지

Robert C Martin (갓 클린코드를 쓴 사람) 이 제안했으며 OOP design spectrum에서 널리 쓰인다

&nbsp;

## Why SOLID principles ?

> 확장, 변경이 필요할 때, 코드를 최소한으로, 효율적으로 추가/변경하면 되도록 해주기 때문이다.

소프트웨어 유지보수란 변화하는 세상에서 해당 소프트웨어가 계속 유용하도록 하는 것이다.

변경이 필요한 class만 수정하면 OK 👌 가 되도록!



#### 프로그램 설계 과정

> [요구사항] - 설계 - [아키텍처] - 개발 - [코드]

여기서 아키텍처를 설계하는 부분이 제일 중요하다. 아키텍처 설계에 따라 변경되는 요구사항에 대처할 수 있는 프로그램의 능력이 판가름 나기 때문이다. 이 때 고려하는 5가지 원칙이 SOLID 이다.

소프트웨어 공학에서 배운 바로는 프로젝트 비용의 70% 정도가 유지보수에 쓰인다고 한다. 흔히 새로운 기능을 개발하는 것이 제일 중요하다고 생각한다. 하지만 소프트웨어 개발 또한 유지보수, 즉, 변화와 확장(기능 추가)에 유연하게 대응하고, 이를 잘 뒷받침 해주는 구조를 최우선으로 고려해야 한다. 이런 특징을 가진 코드는 변경/추가에 따른 코드 변화가 최소가 되고, 기존 기능도 이전처럼 정상적으로 작동한다. 딱 변경할 부분을 담당하는 class 만 수정하면 된다.

한번 만들고 절대 수정되지 않을 것이라고 100% 확신하는 프로그램이라면 이런 원칙들 모두 고려하지 않아도 상관없다. 하지만 현실에 그런 소프트웨어가 얼마나 있을까? 실제로 나도 기능 하나를 추가하기 위해서 전체 프로그램 전체를 수정하거나, 예상치 못한 곳에서 끝없이 튀어나오는 수정이 필요한 코드에 짜증난 적이 많다… :angry: 다른 개발자에게 욕을 덜 먹기 위해서라도 SOLID 원칙은 필수이다.

&nbsp;

#### 그렇다면 확장과 변경에 열려있는 코드의 특징은 무엇일까?

> 결합도 낮게, 응집도 높게

- 결합도 : **서로 다른 모듈, 클래스**가 서로 의존하는, 긴밀하게 연결되어있는 정도
- 응집도 : **한 클래스 내의 코드**가 서로 밀접하게 연관되어있는 정도

&nbsp;

---

## SOLID

![SOLID diagram](../assets/SOLID.png)

- SIP 가 가장 먼저 고려해야하고, 우선순위가 높은 원칙이다
- OCP는 모든 원칙의 기반이 된다 
- DIP 에 Factory Pattern이 해당될 수 있다

&nbsp;

### CRC card (Class-Responsibility-Collaboration card)

*brainstorming tool for object oriented software*

![CRC card](../assets/CRC-card.png)

- 객체 지향 프로그램의 각 class가 SIP 원칙을 준수하는지 확인할 수 있다.
- *Knowing* : 이 책임/역할을 하려면 알아야 할 것으로 property에 해당한다
  - can be value or object
- *Doing* : 이 책임/역할을 가진 객체가 하는 행동으로 method에 해당한다
- *Collaborator*: 해당 class/struct 가 알아야 되는 다른 object
- knowing 에 해당하는 object → 이 class의 instance와 의존성이 높다

&nbsp;

---

## 객체 설계 패러다임

### 객체 ''중심'' 프로그래밍

객체 **지향** 보단 **중심** 이 OOP의 개념을 더 잘 설명하는 단어라는 뜻에서 객체 중심 프로그래밍

*특징*

- property, method
- encapsulation
  - 객체가 알고있는 값은 객체 내에서만 접근 가능해야 함. 외부에서 접근 불가
  - 정보보호의 의미
- inheritance
  - 하위 클래스는 상속을 통해 상위 클래스의 property와 method를 그대로 물려받고, 추가로 자신만의 기능을 가진다
  - 수직 확장
- Polymorphism
- class, instance
- design pattern

&nbsp;

### Don't get it, Just ask them 

*객체 속성을 가져오지 말고 객체가 일하도록 시켜라*

객체의 값을 직접 가져와서 어떤 행동을 하는 일련의 일을 객체에게 맡겨버리자

- 객체 method를 실행한다 = 객체가 message를 받아서 그에 맞는 action을 취한다
- 어떤 행동을 취할지는 해당 객체가 결정하고 판단한다. method 를 call한 쪽에서는 일을 맡기면 된다. 객체 안에서의 구체적인 방식은 몰라도 된다.
- ex. point 2개를 property로 가지는 좌표상의 선을 나타내는 class MyLine
  - 점 두개가 같은지 확인하고 싶다면? 
  - → 직접 point 두개의 값을 가져와서 비교한다 :x:
  - → point a 객체에 point b를 넘겨서 같은지 확인하게 일을 시키고 결과만 받아온다 :o:
- 최대한 class 내부 속성은 private으로 보호 정도를 높이고 일을 시켜서 결과값만 받아오도록 한다

&nbsp;

### enum 사용 - OCP 원칙 위배 가능성 :up:

enum case 추가할 경우, 해당 enum을 사용하는 곳마다 코드 추가가 필요할 수 있다.

enum을 사용할 경우, switch-case 문으로 각 case에 대한 처리를 하게된다. 만약, case를 추가해야되는 상황이라면, 해당 enum에 case 추가하는 작업에 더불어 switch-case 사용하는 곳마다 추가된 case에 대한 처리도 추가해야된다. 최악의 상황이라면 코드를 죄다 뜯어고쳐야 될 수도 있다.. :tired_face: 변경을 최소화 해야되는데 case 추가로 변경이 최대화 될 수 있다.

&nbsp;

---

## What is the meaning of OBJECT

*객체(object)와 이를 바라보는 관점의 차이에 대해 알아보기*

### 객체 object

> 사전) 객체[客體] : 주체로부터 독립되어 있는 인간의 인식과 실천의 대상

객체 = ***대상 = 사물*** 

주체가 빠져있는, 주체로부터 독립되어 있는 대상을 의미한다. 여기서 주체는 나 자신으로 내 기준 나를 뺀 모든 것이 객체라고 할 수 있다. OOP에서 객체란 현실 세계의 관념이나 사물을 코드 상에 옮겨놓은 것으로 상태와 행동을 가진다.

플라톤과 아리스토텔레스의 철학적 관점으로도 설명할 수 있다. 둘 다 사물의 본질인 이데아가 존재한다고 생각했다. 플라톤은 이데아만 참으로 존재한다고 믿었던 반면, 아리스토텔레스는 보편자와 개별자가 서로 상호의존적이라고 보았다. 이를 OOP에 적용해보면, 본질은 class, 구체적인 사물이 instance 를 의미한다. 본질은 불변의 특성을 가지고 구체적인 사물은 그것을 둘러싼 상황이나 여러 요소에 의해 변할 수 있다.

동양과 서양의 객체에 대한 관점은 다르다. 동양에서는 사물과 나 자신을 동일시하는 일명 '물아일체' 관점으로 생각하는 반면, 서양에서는 대상을 각각의 부분 속성으로 나누고 그것에 집중한다.

&nbsp;

### 간접참조 Indirection

값 자체보다 컨테이너, 연결, 별명 등을 사용해서 우회하여 참조하도록 하는 방식이다. 대표적으로 pointer가 있다. 한 단계 이상 거쳐서 간접적으로 접근하는 모든 것은 간접참조가 된다.

함수 호출, instance를 생성해서 내가 만든 이름의 변수에 담는 것 모두 indirection에 해당된다. class 이름 자체도 indirection이다. class definition이 저장된 memory location을 class 이름이 가리킨다.

&nbsp;

---

## Reference 

- [SOLID Principles every Developer Should Know](https://blog.bitsrc.io/solid-principles-every-developer-should-know-b3bfa96bb688)
- [Understanding SOLID Principles: Dependency Inversion](https://codeburst.io/understanding-solid-principles-dependency-injection-d570c15560ab)











