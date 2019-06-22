---
layout: post
title:  "Functional Programming - 함수형 프로그래밍 : what to do 를 알려준다? "
date:  2019-06-22 13:24:59
author: Dana Lee
categories: Swift
tags: [Swift, Functional Programming, side effect, higher order function, pure function]
cover:  "/assets/instacode.png"
---

# Functional Programming

### :pencil2: **요약**

함수형 프로그래밍은 순수 함수를 연속으로 조합하여 프로그램을 구성하는 방식이다. 순수 함수는 항상 같은 입력 값에 같은 출력 값을 내는 함수이다. 순수 함수는 내부에 상태 값을 갖지 않고, 이는 함수형 프로그래밍의 변수의 immutable 속성과도 관련된다. 따라서 순수 함수는 side effect가 없다. 

함수형 프로그래밍에는 higher order function이 있다. 이는 일련의 동작인 함수 또한 추상화 하는 개념이다. higher order function 은 인자 혹은 리턴값이 함수가 오는 함수이다. 이는 함수형 프로그래밍에서 함수는 first class 이기 때문에 가능하다. 함수는 변수에 할당되거나, 인자로 넘겨지거나, 리턴될 수 있다는 속성이다. 함수를 한 번만 사용할 경우, 주로 람다-익명함수, swift에서는 closure- 라는 이름 없는 함수를 사용한다.

프로그래밍 패러다임은 크게 두 갈래 - Imperative(명령형), Declarative(선언형) 으로 나뉜다. 명령형은 c, java 이 해당하며 이미 익숙한 방식이다. 일을 어떻게 처리하면 되는지 방법에 대해서 알려준다. 반면에 선언형에서는 일을 처리하는 동작도 추상화해서 그 동작이 무엇인지 알려준다.

&nbsp;

## Programming Paradigm

프로그래밍 패러다임엔 크게 2가지 - *Imperative*(명령형), *Declarative*(선언형) 이 있다.

![](https://successfulsoftware.files.wordpress.com/2008/04/functional-programming-taxonomy.png?w=625)

|              | Imperative                                            | Declarative(Functional)         |
| ------------ | ----------------------------------------------------- | ------------------------------- |
|              | commanding<br />give the computer a sequence of tasks | tell the computer what stuff is |
|              | give it instruction of how to do, what to do          | tell it what it is              |
| state change | O (mutable)                                           | X (immutable)                   |
| side effect  | O                                                     | X                               |

> **Imperative** programs spend lines of code describing the specific steps used to achieve the desired results — the **flow control: How** to do things.
>
> **Declarative** programs abstract the flow control process, and instead spend lines of code describing the **data flow: What** to do. The *how* gets abstracted away.

선언형 중에서 **함수형** 프로그래밍은 순수함수를 조합해서 소프트웨어를 만드는 방식이다. 순수함수를 연속으로 연결해서 결과값을 낸다. 

반면에 **명령형**은 상태의 변화를 통해 흐름을 제어하는 방식이다. 명령형은 다시 순차적인 처리를 통해 문제를 해결하는 방식인 **절차형**과, 객체간의 상호작용(메세지)를 이용하는 **객체지향**으로 나뉜다.

많은 글에서 함수형과 명령형의 차이를 다음과 같이 설명한다

> Declarative(Functional) : what to do - ***무엇을*** 하는지 알려준다 <br>Imperative                    : how to do - **어떻게** 하는지 알려준다.

Imperative 의 단어 뜻을 보면 command, instruction 의 느낌이 나는데 그런 의미가 내포된 듯하다. 이해하고 나니 어떤 개념인지 파악할 수 있었다.

함수형에서는 함수도 변수에 할당할 수 있다. 이 first class 속성이 what to do 를 가능하게 한다.

명령형에서는 프로그램에서 어떤 일을 하려면 그것을 <u>어떻게 하는지 방법을 알려줘야 했다</u>. n번 반복해서 출력을 해야한다면, 반복문을 돌리고, 그안에 출력함수를 부르고, 이 전체 흐름을 한 함수로 감싸서 프로그램에 선언하고 사용한다.

함수형에서는 이 어떻게 하는지를 설명한 **방법**(함수) 가 변수에 담길 수 있다. 따라서 그 방법이 담긴 변수가 무엇인지만 명시해주면 된다. 

#### *Example* : 특정 함수를 n번 반복해서 실행하는 프로그램

in **Imperative** programming - 1~n 의 2배수 출력하는 프로그램

```swift
func print(until max: Int) {
  for i in 1...max {
    let doubled = i * 2
    print(doubled)
  }
}

if let n = readLine() {
  print(until: n)
}
```

🧐 만약, 여기서 1~n 을 한번씩 **출력** 하지 않고 **다른 동작**을 해야 한다면?

- imperative : 매번 동작이 바뀔 때 마다 저 반복문 안의 내용을 다른 동작, 혹은 다른 함수로 수정해야 한다. 매 수정 때 마다, <u>어떻게</u> 동작해야 하는지를 알려줘야 한다.
- Functional : **동작, 즉 함수**를 인자로 넘겨서 동작이 무엇인지만 알려주면, 동작이 변경되어도 코드를 수정할 필요가 없다.

```swift
func repeat(until max: Int, sub: Int -> Void) {
  for i in 1...max {
    sub(i)
  }
}

if let n = readLine() {
  repeat(n) { print($0) }
}

// later
repeat(n) { print("count: \($0)")}
```

반복하는 함수를 만들어 반복 횟수와 반복될 동작(클로져)을 넘겨준다. 매번 수정시마다 <u>무엇을</u> 반복할 건지(2번째 argument)가 바뀌게 된다. *무엇을 한다는 동작도 추상화를 한다.* 

&nbsp;

## 왜 functional programming 이 필요할까?

- Concurrency (동시성)
  - 상태 값을 허용한다면, 한 instance 에 대해 여러 thread 가 접근할 경우, data 무결성을 보장할 수 없다. (*무결성: 데이터의 정확성과 일관성을 유지/보증하는 특성)
  - 이를 위해 lock 같은 기법을 사용 → performance 저하, 복잡도 증가
  - 원인은 상태 값의 변경을 허용하기 때문 (mutable)
  - functional programming 의 immutable 특성(데이터 변경 불가능)이 cuncurrency 관련 문제 원천 봉쇄
- 코드의 간결함
  - 함수는 입력과 출력뿐. 내부에 상태값을 가지고 있지 않음. no side effect
  - First class, higher order function - 함수도 변수에 할당하고, 인자나 리턴값으로 사용가능

&nbsp;

---

## 관련 개념

functional programming 은 다소 생소한만큼, 개념도 생소하다. 그만큼 이해하는데도 오래 걸렸다. 이걸 다 어떻게 정리하지 싶었다. 지금도 사실 완전히 이해했다고 확신할 수는 없지만 사용해 보면서 익혀보고 싶다.

모든 개념은 다 상호 연결되어 있거나, 서로를 설명하는 특성이다.

&nbsp;

### :pencil2: pure function 순수함수

functional programming 은 순수함수의 조합으로 구성된다. 함수를 연속적으로 연결해서 앞의 output 이 그다음 input이 되는 방식이다.

![](https://cdn.app.compendium.com/uploads/user/e7c690e8-6ff9-102a-ac6d-e4aebca50425/0561a02c-aa92-4c26-a013-52fe36e3b119/File/1807bc29c27387527086d814a07a584a/functional_programming.png)

↑ 이런 함수가 쭉쭉쭉 연결되어 있는게 프로그램이 된다.

####  순수 함수 특성

1. 항상, 언제나 ***같은 input 에 대해 같은 output을 낸다 (referencial transparency)***
2. ***no side effects*** : 상태 값이 불변이기 때문에 의도치 않은 side effect도 없다.
3. ***Lazy evaluation*** - 진짜 계산 해야되기 전까지 계산을 미룬다. 어차피 같은 input 엔 항상 같은 output을 내니까 시점에 대해 고려하지 않아도 된다.
4. ***immutable data*** - 상태 값이 변할 수 없다. 

&nbsp;

### :pencil2: Immutable

함수형 프로그래밍에서는 변수에 어떤 값을 할당하면, 이후에 다른 값으로 재할당 할 수 없다. 이런 특성을 불변성(Immutable)이라고 한다. 

mutable, immutable 은 상태값이 변할 수 있는지에 대한 개념이다. 변할 수 있다면 mutable, 변할 수 없다면 immutable이다.

객체지향에서 instance 는 항상 상태 값을 가지며, 이는 변경될 수 있고, 상태 값에 따라 다르게 행동한다. (mutable)

데이터 변경이 필요하면 복사본을 사용한다. swift 에서 value type이 생각난다.

Type inference, safety 를 가능하게 해주는 특성이라고 생각한다.

&nbsp;

### :pencil2: ​No Side Effect

side effect 는 예상치 못한 결과를 냈다는 의미이다. 같은 input에 대해 때에 따라 다른 값이 나오는 함수라면 결과를 예상하지 못하므로 side effect 가 있다. random() 같은 함수는 항상 다른 값을 내니까 side effect가 있다고 볼 수 있다. 또 숫자 2개를 받아 합을 출력하는 함수에 출력문이 들어가 있다면, 예측한 결과(두 수의 합)와는 다르므로 이 또한 side effect 이다.

순수 함수는 항상 같은 input에 대해 같은 output을 낸다. 결과에 대해 항상 예측이 가능하니까 side effect가 없다. 함수 내부에 **상태를 가지고 있지 않기 때문에** 가능한 특성이다. 

객체지향에서는 instance 가 가진 상태 값에 따라 다르게 행동하므로 side effect 가 있다.

&nbsp;

### :pencil2: ​Lamda Calculus 람다 계산식

> *Lambdas* are anonymous functions that we use when we need a function only once.

anonymous function - 이름 없는 함수라는 뜻이다. swift 에서는 closure 가 lamda이다. 

주로 higher order function에 넘길 때, 한번 사용할 목적으로 만든다. 클로져는 함수를 포함하는 개념이다.



### :pencil2: First Class Fuction (일급 객체)

함수형 프로그래밍에서 함수는 first class(first citizen) - 일급객체 - 이다.

🧐 first class ?

- 변수에 할당할 수 있다
- 인자로 넘길 수 있다.
- return value 로 사용할 수 있다.

즉, 함수를 변수에 할당하거나, parameter 로 넘기거나, return type 이 될 수 있다는 뜻이다.

이 특성은 뒤의 higher order function(HOF) 를 가능하게 하는 필수 속성이다.

&nbsp;

### :pencil2: Higher Order Function 고차 함수

다음 두 조건 중 하나 이상 만족하는 함수를 higher order function 이라고 한다

- 인자로 함수를 받는다
- 함수를 반환한다

함수형 프로그래밍에서 함수는 일급 객체로, 변수에 할당하거나, 함수에 인자로 넘길 수 있거나, 반환타입이 될 수 있으므로 고차함수의 개념을 실현 가능하게 한다. 고차함수는 일급 객체에 포함되는 개념(부분집합)이다.

higher order function 은 first order function 보다 더 추상화 된 개념이라고 생각한다. first order function 은 인자로, 반환값으로 함수를 받지 못하는 함수를 말한다. fist order 에서 함수를 추상화할 수 있으면 higher order 이 된다.

&nbsp;

#### higher order function 왜 사용될까?

크게 두가지 이유라고 생각한다.

1. **추상화** : 함수를 인자로 받아서 어떤 동작을 할지도 추상화한다. 함수 조합을 가능하게 한다
   how to 에 대한 것도 추상화를 해버린다.
2. Immutable 특성에 기인 - 값을 변경할 수 없으니, 데이터 변환이 필요할 땐, map, filter 함수로 복사본을 반환하도록..



### :pencil2: lazy evaluation

- eager, strict evaluation : 수식이 변수에 접근하는 순간 계산된다. 일반적인 프로그래밍 언어에서 사용되는 방식.

- lazy evaluation : 계산의 결과 값이 필요할 때까지 계산을 늦춘다.

- *Example*

  ```
  x = 1+2
  print(x)
  ```

  - 일반적인 프로그래밍 언어 - 조급한 계산법
    - 수식을 만나면 바로 계산해서 변수에 넣어버림
  - 지연 계산법 - `x` 에 `1+2` 라는 수식을 갖고 있다가 print 문에서 사용될 때 x를 불러서 계산함

- [lazy evaluation - 이해하기 좋은 예시](https://dororongju.tistory.com/137)

&nbsp;

### :pencil: 더 알아볼 개념

- functor
- monad
- In swift 
- higher function in swift - map, filter ….

&nbsp;

---

## :pushpin: Reference

- [함수형 프로그래밍 요약](http://velog.io/@kyusung/함수형-프로그래밍-요약)
- [함수형 프로그래밍](https://devhue.github.io/blog/functional-programming)
- [왜 함수형 프로그래밍이 좋을까?](http://ruaa.me/why-functional-matters/)
- [자바 Lazy Evaluation이란?](https://dororongju.tistory.com/137)
- [Swift와 함수형 프로그래밍의 역사](https://academy.realm.io/kr/posts/tryswift-rob-napier-swift-legacy-functional-programming/)
- [Learn you a Haskell for Great Good]([https://github.com/clojurians-org/haskell-ebook/blob/master/Learn%20You%20a%20Haskell%20for%20Great%20Good!%20A%20Beginner's%20Guide.pdf](https://github.com/clojurians-org/haskell-ebook/blob/master/Learn You a Haskell for Great Good! A Beginner's Guide.pdf))

&nbsp;

---

### :mag: function  vs.  procedure

https://www.fpcomplete.com/blog/2017/04/pure-functional-programming

![](https://i.imgur.com/fQUJjqf.png)





&nbsp;