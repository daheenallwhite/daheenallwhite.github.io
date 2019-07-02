---
layout: post
title:  "Lamda Calculus and Currying - 함수형 프로그래밍, 람다식, 커링"
date:  2019-07-03 21:52:59
author: Dana Lee
categories: Programming
tags: [Lamda Calculus, Currying, Functional Programming]
lastmod : 2019-07-03 22:26:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

source : https://en.wikipedia.org/wiki/Lambda_calculus#The_lambda_calculus

## Lamda Calcus

> **Lambda calculus** (also written as **λ-calculus**) is a [formal system](https://en.wikipedia.org/wiki/Formal_system) in [mathematical logic](https://en.wikipedia.org/wiki/Mathematical_logic) for expressing [computation](https://en.wikipedia.org/wiki/Computability) based on function [abstraction](https://en.wikipedia.org/wiki/Abstraction_(computer_science)) and [application](https://en.wikipedia.org/wiki/Function_application) using variable [binding](https://en.wikipedia.org/wiki/Name_binding) and [substitution](https://en.wikipedia.org/wiki/Substitution_(algebra)). It is a universal [model of computation](https://en.wikipedia.org/wiki/Model_of_computation) that can be used to simulate any [Turing machine](https://en.wikipedia.org/wiki/Turing_machine). 

튜링머신에서 사용되는 계산 모델로, function을 추상화하고 적용하는 것을 표현하는 수학 로직이다.

튜링머신에는 "현재 상태 다음에 어떤 상태가 오면 이 값이다"라는 매핑테이블이 있다. (모든 조합을 다 알려주는 테이블인 셈) 이런 상태표들의 조합을 만드는게 튜링머신에서의 프로그래밍이다. 초반에는 매핑테이블로 관리했으나 점차 복잡해지는 계산으로 인해 상태표가 너무 길어지고, 구조적으로 나누어지지 않았다.

&nbsp;

### 함수의 표현

```
λx.M (M은 function definition 을 뜻한다)
```

이는 일반 함수의 abstraction 이다.

```
λx.x+2 is abstraction for the function f(x) = x + 2 
```

&nbsp;&nbsp;

### 매개변수가 여러 개인 함수

function with multiple arguments

![]({{site.url}}/assets/post-image/lamda1.png)

*Example*

![]({{site.url}}/assets/post-image/lamda3.png)



### Currying 

> 여러 개의 매개변수를 가진 함수를 한개의 매개변수를 가진 여러개의 함수의 연결로 나타내는 방법 (method that transfoms a function that takes multiple arguments into a chain of functions each with a single argument.)

인자가 여러 개인 함수 → 한개의 매개변수를 가진 함수를 연결해서 표현하기

![](/Users/allwhite/Desktop/blog/daheenallwhite.github.io/_posts/%7B%7Bsite.url%7D%7D/assets/post-image/lamda2.png)

한개의 매개변수를 가진 함수는 다시 한개의 매개변수를 가진 function을 리턴한다. 

![](/Users/allwhite/Desktop/blog/daheenallwhite.github.io/_posts/%7B%7Bsite.url%7D%7D/assets/post-image/lamda4.png)

&nbsp;

### Currying in Swift

커링(currying) : 인자가 여러 개인 함수 → 한개의 매개변수를 가진 함수를 연결해서 표현하기

커링을 Swift 에서 구현해보자.

*Example* : 2개의 인자를 갖는 함수를 1개 인자를 받는 함수 2개 연결로 바꾸기

Swift 에서 operator 또한 function 이다. 따라서 함수를 인자로 넘기는 곳에 `+`, `-` 같은 이항 연산자를 넣어도 클로져를 넘긴 것과 같은 역할을 한다

```swift
let list = [3,2,5,6,8]

list.sorted(by:>) // 역순 정렬
// [8, 6, 5, 3, 2]
```



Int 2개를 받아 Int를 반환하는 메소드를 만들자

```swift
typealias Method = (Int, Int) -> Int
```

매개변수에 들어갈 값 2개(`v1`, `v2`) 와 매개변수 두개를 받아 처리후 반환하는 함수 `Method`

```swift
func _calculate(_ method: Method, v1: Int, v2: Int) -> Int {
	return method(v1, v2)
}
```

이 방식은 매개변수 2개를 한번에 같이 넣어야 된다.

&nbsp;

이번엔 매개변수를 1개씩 넣는 함수로 바꿔보자. 매개변수를 1개씩 넣으면 또 다른 함수를 반환한다.

```swift
func calculate(_ method: @escaping Method) -> (Int) -> (Int) -> Int {
	return { v1 in
		return { v2 in
			return method(v1, v2)
		}
	}
}
```

&nbsp;

```swift
calculate(+)(10)(3)
```

![](/Users/allwhite/Desktop/blog/daheenallwhite.github.io/_posts/%7B%7Bsite.url%7D%7D/assets/post-image/lamda5.png)

&nbsp;

```swift
let adder = calculate(+)
//  (Int) -> (Int) -> Int : adder type
adder(5)(3)
```

adder는 다시 함수를 반환한다.

![](/Users/allwhite/Desktop/blog/daheenallwhite.github.io/_posts/%7B%7Bsite.url%7D%7D/assets/post-image/lamda6.png)

&nbsp;

```swift
let adder100 = adder(100)
// 100 -> (Int) -> Int
adder(3)
```

![](/Users/allwhite/Desktop/blog/daheenallwhite.github.io/_posts/%7B%7Bsite.url%7D%7D/assets/post-image/lamda7.png)

