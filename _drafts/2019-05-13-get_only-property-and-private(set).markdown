# Private(Set) 

*get-only property 와 private(set) 의 차이점*

&nbsp;

## get-only property

내가 값을 세팅할 수 없는, 값을 조작할 수 없는 property

읽기만 가능한 property



## computed property with only getter

computed property에서 getter만 설정한 경우

선언한 class/struct/enum 안에서 접근 불가..?



computed property with setter

다른 property value를 간접적으로 setting 하기 위해서

## private(set)

값 setting 에 한해서 private access level을 가진다는 뜻이다

읽기는 그 앞에 설정한 것에 따라 다름

getter와 setter가 있을 때, setter에 더 제한된 access level을 부여할 수 있다.

Stored, computed property 둘다 적용할 수 있다.

private은 해당 property가 속한 type안에서만 조작할 수 있다는 의미



## 개념적 차이

> 공통점 :  get-only property 개념에 private(set)이 포함됨

읽기만 가능하다는 점에서 get-only property와 private(set) 이 일맥상통

> 차이점 : 

