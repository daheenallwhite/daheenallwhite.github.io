>  If an object has an intrinsic content size, it appears in the stack at that size. If it does not have an intrinsic content size, Interface Builder provides a default size. You can resize the object, and Interface Builder adds constraints to maintain its size.
>
> 고유 사이즈가 있다면 stack view 에서는 그 사이즈대로 나오고, 그렇지 않다면 ib 가 제공하는 디폴트 사이즈로 설정된다.

stck view 의 property로 좀더 세밀한 레이아웃을 바꿀 수 있다. 

- distribution: fillEqually, fill, equalSpacing 등



### Constraint Inequality

제약 조건에서는 = 만 쓸 수 있는게 아니라, >=, <= 도 쓸 수 있다.

- Ex. minimum, maximum 값



### Constraint Priorities

Constraint 에는 priority 가 있음 - 용도는 conflict 가 생길 때, 어떤 제약을 우선할 것이냐의 판단 기준이 됨

- 값은 1~1000
  - 1000 : required
  - 그 외 : optional
- `UILayoutPriority`
- 최악의 조건을 가장 높은 우선순위로, 최선을 가장 낮은 우선순위로 



### Intrinsic Content Size

일부 view 는 **content 사이즈로 자신의 사이즈를 결정**하기도 한다. 이 사이즈를 intrinsic content size 라고 함

- 빈 image view 는 intrinsic content size 가 없음
- text view 의 intrinsic content size
  - content or scrolling 여부에 따라 결정된다
  - scroll disabled : content 크기에 따라 계산된다
- content hugging : content 를 잘 감싸게 view의 사이즈를 같도록 view 를 안으로 끌어당기는 힘
- compression resistance : content 가 잘리지 않도록 view를 밖으로 밀어내는 힘

> The content hugging pulls the view inward so that it fits snugly around the content. The compression resistance pushes the view outward so that it does not clip the content.

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/intrinsic_content_size_2x.png)





```

    var testData = [Location(coordinate: Coordinate(lat: "37.5665", lon: "126.978"), name: "Seoul"), Location(coordinate: Coordinate(lat: "43.000351", lon: "-75.499901"), name: "New York"), Location(coordinate: Coordinate(lat: "15.3525", lon: "120.832703"), name: "San Francisco")]
```





