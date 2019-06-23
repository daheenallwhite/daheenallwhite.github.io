---
layout: post
title:  "Computed Property vs Method - What to choose (Computed Property와 Method 중에 무엇을 써야 할까?)"
date:   2019-05-09 00:21:00
author: Dana Lee
categories: Swift 
tags:    [Swift, Computed Property, Method]
cover:  "/assets/instacode.png"
---

# Computed Property  vs  Method

**_computed property 와 method 중에 무엇을 쓰는게 좋을까?_** :confused:

&nbsp;

둘 다 뭔가 계산한 결과 값을 사용하는 건데, 어떤 것을 선택하는게 struct/class/enum에서 더 적절할지 의문이 들었다.

결론만 보자면 **관점의 차이** 로 선택하면 된다.

&nbsp;

외부에서 봤을 때, 해당 object에서 내가 추가하려는 어떤 특성이

> 연산의 결과물, 즉, 계산을 통해서 나와야 한다면 **method** <br>
>
> 상태 값, 지속되며 가지고 있는 속성이라면 **property**를 사용하는게 좋다.

&nbsp;

| Computed Property                     | Method                                 |
| ------------------------------------- | -------------------------------------- |
| 외부에서 보기에 property 가 적합한 것 | 외부에서 보기에 연산, 계산이 필요한 것 |
| computed 는 내부 구현 방식을 의미한다 |                                        |

&nbsp;

computed property가 사용되는 이유는 구현하는 입장에서 stored 보단 computed가 더 낫기 때문이다.

_example_

온도를 나타내는 struct type 이 있을 때, 이 온도를 섭씨, 화씨로 나타내는 property를 가진다고 하자

이 때, 매번 온도가 바뀜에 따라 섭씨, 화씨를 각각 2번씩이나 계산해서 바꿔야할 필요는 없다.

값이 변동되면 섭씨만 바꾸고 화씨가 필요할 때만 섭씨→화씨로 변환해서 사용하면 될 것이다.

```swift
struct Temperature {
	var celcius: Int // 기준
  var ferenheit: Int {
    return Int(celcius × 9/5) + 32
  }
  
  init(celcius: Int) {
    self.celcius = celcius
  }
}
let currentTemperatue = Temperature(celcius: 0)
print(currentTemperatue.ferenheit) // 32
```

&nbsp;

#### 오해하기 쉬운 부분 :warning:

computed property는 어디까지나 **property** 이지, 연산이 필요하다고 해서 method 가 아니다!

&nbsp;

&nbsp;

#### 참고할 부분 :mag:

swift standard library에서 String 같은 친숙한 type을 고른 뒤, computed property와 method 중 어떤 걸 선택했는지 보면 좀 더 도움이 된다고 한다.

다른 blog에서는 시간 복잡도가 작으면 property, 크면 method를 사용하라는 의견도 있었다.

&nbsp;

&nbsp;

&nbsp;