---
layout: post
title:  "Copy On Write in Swift - Value Type 은 매번 복사하지 않는다"
date:   2019-06-04 23:30:59
author: Dana Lee
categories: Swift
tags: [Swift, Copy on Write, Value type]
cover:  "/assets/instacode.png"
---



# Copy-On-Write (COW)

- Value type 중에 Array, Collection에 사용되는 기법

- value type : 변수에 value type할당할 때, 혹은 func에 인자를 넘길 때 copy! 즉, 값을 복사하여 넘긴다

- 이 때, 우려되는 점 : 엄청 큰 크기의 value type을 copy해야 할 경우엔 performance 저하가 우려된다

- 해결 : Copy on write behavior 를 사용한다

- 우려 가능성이 큰 Array & Collection 타입에만 구현되어있다.

- value type의 default behavior는 아니다.

- uniquely referenced → doesn't need to copy

- 해당 value type이 unique 한 레퍼런스를 가지면 copy 하지 않고

- 하나 이상의 reference가 있어야 할 경우 (ex. append) 그 때 copy 한다

    ```swift
     import Foundation
    
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
    
      //isKnownUniquelyReferenced(&<#T##object: T?##T?#>) 
      // swift optimization tips 참조
    
    ```

    custom value type에 이런 behavior 구현 가능
    
    &nbsp;

swift docs - Structure & Class - value type에서 관련 설명 나옴

> Collections defined by the standard library like arrays, dictionaries, and strings use an optimization to reduce the performance cost of copying. Instead of making a copy immediately, these collections share the memory where the elements are stored between the original instance and any copies. If one of the copies of the collection is modified, the elements are copied just before the modification. The behavior you see in your code is always as if a copy took place immediately.

&nbsp;

### :pushpin: Reference

- [Understanding Swift Copy-on-Write mechanisms](https://medium.com/@lucianoalmeida1/understanding-swift-copy-on-write-mechanisms-52ac31d68f2f)
- [apple/swift](https://github.com/apple/swift/blob/master/docs/OptimizationTips.rst#advice-use-inplace-mutation-instead-of-object-reassignment)

&nbsp;