---
layout: post
title:  "Difference Between Value type and Reference type in Swift"
date:   2019-04-29 13:19:00
author: Dana Lee
categories: Swift
tags:    [Value type, Reference type]
lastmod : 2019-06-26 20:13:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

# Difference between Value type and Reference type in iOS Swift

> [Difference between value type and a reference type in iOS swift?](https://medium.com/@abhimuralidharan/difference-between-value-type-and-a-reference-type-in-ios-swift-18cb5145ad7a)

in Swift

**Class = of Reference type**

**Struct = of Value type**

&nbsp;

## Value type

> each instance keeps a unique copy of its data
copying — the effect of assignment, initialization, and argument passing — creates an independent instance with its own unique copy of its data

- 값 할당, 초기화, 함수 인자로 넘길 때 - 해당 instance의 모든 data를 copy한 새로운 instance를 만들어서 반환한다.

- swift의 모든 basic type은 모두 value type 으로 구현됨

> Collections defined by the standard library like arrays, dictionaries, and strings use an optimization to reduce the performance cost of copying. Instead of making a copy immediately, **these collections share the memory where the elements are stored between the original instance and any copies.** If one of the copies of the collection is modified, the elements are copied just before the modification. The behavior you see in your code is always as if a copy took place immediately.  (COW)

&nbsp;

## Reference type

> instances share a single copy of the data

값 할당, 초기화, 함수 인자로 넘기면 해당 인스턴스의 reference를 가지며, 결국 한 instance를 share하게 됨

&nbsp;

&nbsp;

# Why Value type Over Reference type

> One of the primary reasons to choose value types over reference types is the ability to more easily reason about your code. If you always get a unique, copied instance, you can trust that no other part of your app is changing the data under the covers. This is especially helpful in multi-threaded environments where a different thread could alter your data out from under you. This can create nasty bugs that are extremely hard to debug.

- reference type 단점
    - 여러 변수가 한 instance를 share 하기 때문에 생기는 문제
    - Multi-thread
    - 코드 파악의 어려움
- value type

&nbsp;

# let으로 선언시 차이점

### class 변수 let으로 선언

- 내부 property 변동 가능
- reference 값만 못 바꿈
- class에서 let, var 차이는 **instance를 reassign 가능/불가능 여부**
- 할당된 instance를 바꿀 수 있음 → var / 없음 → let

### struct 변수 let으로 선언

- 내부 property 변동 불가!
- constant object를 만듬

&nbsp;

&nbsp;

# 메모리 저장시에 차이점

- **value type** - stack memory : static memory allocation
- **reference type** - managed heap memory : dynamic memory allocation
- ex) class type인데 안에 value type property가 있다 → heap memory
    - 모든 reference type ⇒ heap memory에 있으므로 그 안의 속성들도 다 heap memory together!

&nbsp;

&nbsp;

# stack, heap memory

- stack : 함수가 호출되면 관련 지역, 전역변수가 저장되는 곳
- heap : 사용자(코드)에 의해 동적으로 생성된 변수가 저장되는 곳

> → Stack is tightly managed and optimized by the CPU. When a function creates a variable, the stack stores that variable and is destroyed when the function exits. Variables allocated on the stack are stored directly to the memory and access to this memory is very fast. When a function or a method calls another function which in turns calls another function etc., the execution of all those functions remains suspended until the very last function returns its value. The stack is always reserved in a LIFO order, the most recently reserved block is always the next block to be freed. This makes it really simple to keep track of the stack, freeing a block from the stack is nothing more than adjusting one pointer. Since the stack is very well organized, it is very efficient and fast.

> →The system uses the heap to store data referenced by other objects. The heap is generally a large pool of memory from which the system can request and dynamically allocate blocks of memory. The heap doesn’t automatically destroy its object like the stack does. External work has to be done to do this. ARC does the job in apple devices. Reference count is tracked by the ARC and when it becomes zero, the object is deallocated. Hence, the overall process (allocation , tracking the references and deallocation) is slower compared to stack. So value types are faster than reference types.

> copying — the effect of assignment, initialization, and argument passing — creates an *independent instance* with its own unique copy of its data:



### ARC

??



## Class

ios 프레임워크의 대부분의 큰 뼈대는 모두 class 로 구성

상속은 class 만 가능



## Struct

swift의 대부분의 큰 뼈대는 모두 struct로 구성

### 구조체는 언제 쓸까?

연관된 몇몇 값을 모아 하나의 데이터 타입으로 표현하고 싶을 때

다른 곳으로 전달시 참조가 아닌 복사를 원할 때 (원본 데이터 변화 원하지 않을 때)

상속받을 필요가 없을 때



## Enum

of value type

(instance/type) method, computed property 가질 수 있음



## 상속

추상적 → 구체적 인 type으로 가는 개념

점차 점차

ex. 사람 → 학생 → 대학생



단일상속





## 참조

[Swift 성능 이해하기: Value 타입, Protocol과 스위프트의 성능 최적화](https://academy.realm.io/kr/posts/letswift-swift-performance/)