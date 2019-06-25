---
layout: post
title:  "[Swift] guard elese statement 완전 정복"
date:  2019-06-25 17:59:59
author: Dana Lee
categories: Swift
tags: [guard-else, control flow]
---

`guard` statement 제대로 알기 :eight_pointed_black_star:

&nbsp;

## guard - else 

> A `guard` statement, like an `if` statement, executes statements depending on the Boolean value of an expression. You use a `guard` statement to require that a condition must be true in order for the code after the `guard` statement to be executed. Unlike an `if` statement, a `guard` statement always has an `else` clause—the code inside the `else` clause is executed if the condition is not true.

guard else 는 swift에서 제공하는 control flow statements 중 하나로, if 랑 비슷하다.

수식이 참이 되면 다음 코드로 계속 진행하고, false 이면 else 이후의 문장을 실행하고 종료되어야 한다.

### syntax

```swift
guard [expression] else {
	// statements executed if the expression is false 
}
```

&nbsp;

## Early Exit

swift language guide 에서 `guard` statement 가 소개되는 파트는 [Early Exit](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html#ID525) 이다.

수식이 참이 되어야 계속될 수 있고, 거짓일 경우 종료되거나 나와야 하는 경우 사용하라고 만든 방법인가보다.

`else` 문 뒤에 나오는 코드는 반드시 현재 `guard` 문이 있는 code block 을 *exit* 하도록 해야 한다. 

- exit 방법 : return, break, contrinue, throw, fatalError 같은 return 하지 않는 function

> If that condition is not met, the code inside the `else` branch is executed. That branch must transfer control to exit the code block in which the `guard` statement appears. It can do this with a control transfer statement such as `return`, `break`, `continue`, or `throw`, or it can call a function or method that doesn’t return, such as `fatalError(_:file:line:)`.

&nbsp;

## condition in guard statement

조건문에 올 수 있는 것은 크게 두 종류가 있다.

### 1. optional binding

```swift
guard let id = students["Dana"] else {
	print("There is no student named \"Dana\"")
	return
}
print("Dana's id : \(id)")
```

- unwrapping 에 성공하면(nil이 아닌 경우) 조건문은 true, 실패시 false 가 된다
- optional 변수 값이 nil 이면 수행을 멈춰야 하는 flow 에서 사용한다.
- 성공하면 조건식 안에서 선언된 변수는 guard 문이 있는 scope 에서 사용가능하다

&nbsp;

### 2. just condition 그냥 조건식 아무거나

내가 착각했던 부분이 이 부분이다.

guard 문이 주로 optional unwrapping 에 쓰여서 착각했었는데, 저기 조건문엔 if 에서 쓰이는 것 같은 조건식도 들어올 수 있다.

조건식이 true 일 경우에만 계속 그 다음 코드를 수행한다.

```swift
guard id == 12345 else {
	print("This is not the id I'm looking for")
	return
}
```

:arrow_up_small: 이런식으로도 사용 가능하다.

&nbsp;

### 3. 조건식 여러 개도 사용가능

여러 개 사용시엔 하나라도 false 이면 전체 false 가 된다.

```swift
guard let id = students["Data"], id == 12345 else {
  print("invalid result")
  return
}
```

&nbsp;



## if  :vs: ​ guard - what to use?

### control flow

- **If** : **true**일 때, 추가 처리가 필요한 경우
  - else if 는 가독성이 떨어지기 때문에 사용 지양하라고 권장됨
  - else if 를 써야하는 경우라면 guard 로 바꾸자

- **guard** : **false** 일 때, 추가 처리가 필요한 경우 - control flow 가 바뀌어야 하는 경우
  - false 일 때 사용하면 가독성이 if 보다 좋음
  - 앞에 ! 나 else if 안써도 되니까 가독성이 좋아짐

&nbsp; 

### optional binding

조건문 안에서 선언된 변수의 scope 이 다르다

- **If** : if 문 내에서만 사용 가능
- **guard** : guard 문 scope 과 같음. 단, nil 이 아닌 경우만(unwrapping 성공한 경우만)

```swift
if let id = students["Dana"] {
  print("Dana's id: \(id)")
}

print("\(id)") // error
```

```swift
guard let id = students["Dana"] else {
	return
}
print("\(id)") // ok
```



&nbsp;

## 요약

- guard statement 는 조건식이 참이면 다음 수행으로 넘어갈 수 있고, 거짓이면 else 블록에 명시한 현재 control flow 를 바꾸는(옮기는) 처리를 할 수 있다. 
- 조건식엔 일반 조건식과 optinal unwrapping 이 올 수 있다. 여기서 선언된 변수는 guard 문의 유효 scope 과 동일한 scope 이다. 
- false 일 때, 수행이 지속 될 수 없을 때, 즉, true 일 때만 계속되어야 하는 경우엔 guard 사용이 좋고 가독성을 높일 수 있다.

&nbsp;

---

## :pushpin: Reference

- [Swift Language Guide - Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html#ID525)
- [Swift Language Guide - Optionals](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html#ID330)

&nbsp;