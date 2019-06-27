---
layout: post
title:  "Shuffle Algorithm : 무작위로 섞기 알고리즘 - Fisher-Yates Shuffle & Knuth Shuffle"
date:  2019-06-27 19:20:59
author: Dana Lee
categories: [Programming, Algorithm]
tags: [Shuffle Algorithm, Knuth Shuffle, Fisher-Yates Shuffle, Random]
lastmod : 2019-06-27 19:20:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

## Shuffle Algorithm 

음악 앱에 있는 "무작위 재생" 기능은 어떤 알고리즘을 사용할까?

주어진 리스트의 element 를 무작위로 섞는(Randomly Shuffle) 알고리즘엔 대표적으로 **Fisher-Yates Shuffle**가 사용된다.

&nbsp;

## 무작위 순열(random permutation) 만들기

- 무작위로 선택할 때, 고려할 점
  - 이미 뽑혔던 element 가 안 뽑혀야 됨 -> 기존에 있는 요소인지 체크하는 과정 필요 -> 복잡도 ▲ 성능 ▼
  - 기존에 뽑았던 요소를 배제하고 이 과정을 반복하는 알고리즘이 필요

### Fisher-Yates shuffle algorithm 

> **Fisher–Yates shuffle** is an [algorithm](https://en.wikipedia.org/wiki/Algorithm) for generating a [random permutation](https://en.wikipedia.org/wiki/Random_permutation) of a finite [sequence](https://en.wikipedia.org/wiki/Sequence)—in plain terms, the algorithm [shuffles](https://en.wikipedia.org/wiki/Shuffling) the sequence. ([wikipedia 참조](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle#Fisher_and_Yates'_original_method))

- 방법
  1. 1~n 까지의 숫자를 쓴다
  2. 지워지지 않은 숫자 중 random number *k*를 고른다
  3. 남은 숫자의 개수를 세고, 지워지지 않은 숫자 *k*를 지우고, 그 숫자를 별도의 list에 쓴다.
  4. 모든 숫자가 지워질 때까지 2번을 반복
  5. 3번에서 쓴 별도의 list가 최종 random permutation 결과이다.
- 섞은 결과가 한쪽으로 편향되지 않고, 골고루? 잘 섞이는 방법이라고 한다.
- 시간 복잡도 : `O(n^2)`
  - 매 반복마다 남은 (지워지지 않은, 선택 안된) 숫자를 세는 과정이 필요 - O(n)
  - 랜덤 숫자 선택을 리스트 요소 개수에 비례해서 해야 함 - O(n)

### Knuth Shuffle

- Fisher-Yates shuffle 의 현대 버전
- 각 반복마다 **남은 element 개수를 셀 필요가 없음** -> `O(n)`
- 별도의 list 가 필요 없음. swap 할거니까

- 핵심 개념

  - 한쪽 끝(앞 혹은 뒤)부터 한자리씩 이동하면서 각 자리에 들어갈 요소를 랜덤하게 뽑음
  - 랜덤 숫자 대상: 그 자리를 포함해서 아직 정하지 않은 자리에 있는 요소들
  - 랜덤하게 뽑힐 대상 리스트를 줄여가면서, 기존에 뽑힌 요소를 배제함
  - 랜덤 함수가 O(1) 의 시간복잡도를 가지면, 전체 알고리즘은 O(n)

- pseudo code -- To shuffle an array a of n elements (indices 0..n-1):

  ```
  // list 뒷자리부터 한자리씩 섞기
  for i from n−1 downto 1 do
       j ← random integer such that 0 ≤ j ≤ i
       exchange a[j] and a[i]
       
  // list 앞에서부터 한자리씩 고를 경우
  for i from 0 to n−2 do
       j ← random integer such that i ≤ j < n
       exchange a[i] and a[j]
  ```

- 뽑는 대상 list는 그 자리도 포함(inclusive) 해야한다. - 그래야 원래자리에 그대로 있는 경우도 포함해서 랜덤하게 섞을 수 있음

- 대상 list가 하나 남은 경우는 어차피 뽑아도 그 요소이므로 배제

- for 문 도는 대상 Index 는 **0 ~ n-2** / **1 ~ n-1** 이어야 함

- *Example* : 앞 자리부터 한자리씩 골라 섞는 경우 

  ![]({{site.url}}/assets/post-image/shuffle-algorithm.png)

- *Example* : in Swift

  ```swift
  var array = [ 1,2,3,4,5 ]
  
  for i in 0..<array.count - 1 { // 0 ~ n-2
      let randomIndex = Int.random(in: i..<array.count)
      
      let temp = array[i]
      array[i] = array[randomIndex]
      array[randomIndex] = temp
  }
  
  print(array)
  //[2, 5, 1, 4, 3]
  ```

---

## :pushpin: Reference

- [wikipedia - Fisher-Yates shuffle](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle#Fisher_and_Yates'_original_method)
- http://www.programming-algorithms.net/article/43676/Fisher-Yates-shuffle
- https://www.geeksforgeeks.org/shuffle-a-given-array-using-fisher-yates-shuffle-algorithm/

&nbsp;