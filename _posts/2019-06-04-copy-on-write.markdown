---
layout: post
title:  "Copy On Write in Swift - Value Type 은 매번 복사하지 않는다"
date:   2019-06-04 23:30:59
author: Dana Lee
categories: Swift
tags: [Copy On Write, Value type, Optimization]
lastmod : 2019-06-26 20:13:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

# Copy-On-Write (COW)

Swift value type 은 함수에 값을 넘기거나, 프로퍼티에 저장할 때, 한 인스턴스를 공유하지 않고, 복사하여 사용한다. 

그렇다면 매번 복사해서 사용하는 걸까? Array 에 엄청나게 많은 값이 있을 때도? 혹은 2차, 3차원 배열일때도? 

항상 복사한다면 저장된 값의 수가 많을 수록 성능 저하를 일으킬 것이다. Swift 에서는 이런 경우를 대비해서 관리하는 방법이 있다. 바로 Copy-On-Write behavior이다. 한마디로 정리하자면 필요할 때만, 복사가 필요하다고 판단될 때만 복사하고, 아닐땐 그냥 그 instance를 그대로 참조해서 사용하는 방법이다.

- Value type 중에 Array, Collection에 사용되는 기법

- value type : 변수에 value type할당할 때, 혹은 func에 인자를 넘길 때 copy! 즉, 값을 복사하여 넘긴다

- 이 때, 우려되는 점 : 엄청 큰 크기의 value type을 copy해야 할 경우엔 performance 저하가 우려된다

- 해결 : Copy on write behavior 를 사용한다

- 우려 가능성이 큰 Array & Collection 타입에만 구현되어있다.

- value type의 default behavior는 아니다.

- uniquely referenced → doesn't need to copy

- 해당 value type이 unique 한 레퍼런스를 가지면 copy 하지 않고

- 하나 이상의 reference가 있어야 할 경우 (ex. append) 그 때 copy 한다

- *Example*

    {% highlight javascript %}
    
    // memory address 출력하기 위한 함수
    func print(address o : UnsafeRawPointer) {
      print(String(format: "%p", Int(bitPattern: o)))
    }
    
    var array1: [Int] = [1,2,3]
    var array2 = array1
    
    print(address: array1)
    print(address: array2)
    // 0x7f8a90f194a0 
    // 0x7f8a90f194a0 
    // 두 배열 reference 가 같다
    // uniquely referenced라면 copy 안하기 때문
    
    array2.append(4)
    print(address: array2)
    // 0x7f8a90c04fc0 -> reference 바뀜
    // 요소 추가로 다른 reference 추가되어 copy 수행
    
    {% endhighlight %}
    
    
    
- 처음엔 같은 array instance 참조. *복사 안함*
  
    - array2 에 element 추가 → 두 개의 reference → 새로운 element 추가 전에 memory 에 새로 복사한 뒤에 추가됨.

&nbsp;

- custom value type에 이런 behavior 구현 가능
  - [Writing High-Performance Swift Code - The cost of large Swift values](https://github.com/apple/swift/blob/master/docs/OptimizationTips.rst#advice-use-copy-on-write-semantics-for-large-values)

&nbsp;

swift docs - Structure & Class - value type에서 관련 설명 나옴

> Collections defined by the standard library like arrays, dictionaries, and strings use an optimization to reduce the performance cost of copying. Instead of making a copy immediately, these collections share the memory where the elements are stored between the original instance and any copies. If one of the copies of the collection is modified, the elements are copied just before the modification. The behavior you see in your code is always as if a copy took place immediately.

&nbsp;

### :pushpin: Reference

- [Understanding Swift Copy-on-Write mechanisms](https://medium.com/@lucianoalmeida1/understanding-swift-copy-on-write-mechanisms-52ac31d68f2f)
- [Writing High-Performance Swift Code](https://github.com/apple/swift/blob/master/docs/OptimizationTips.rst)

&nbsp;