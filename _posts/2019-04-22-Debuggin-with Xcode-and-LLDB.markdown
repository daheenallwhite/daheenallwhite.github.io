---
layout: post
title:  "Debuggin with Xcode and LLDB"
date:   2019-04-22 15:45:59
author: Dana Lee
categories: Swift
tags: Debuggin Xcode LLDB
cover:  "/assets/instacode.png"
---
# Debugging with Xcode and LLDB

&nbsp;

## Reference

1. [Xcode 공식 문서](<https://help.apple.com/xcode/mac/10.2/index.html?localePath=en.lproj#/devda5478599>)
2. [LLDB apple 공식 문서](<https://developer.apple.com/library/archive/documentation/General/Conceptual/lldb-guide/chapters/Introduction.html>)
3. 그외 사용 팁
   - [Debugging with Xcode and LLDB](<http://minsone.github.io/ios/mac/xcode-lldb-debugging-with-xcode-and-lldb>)
   - [Debug console command 정리](<https://ohgyun.com/635>)
   - [LLDB 유용한 명령어 모음](<http://bartysways.net/?p=682>)
   - [Debugging Swift code in Xcode](<https://medium.com/flawless-app-stories/debugging-swift-code-with-lldb-b30c5cf2fd49>)

&nbsp;

&nbsp;

## When debugging in Xcode
![Xcode Debugging]({{ "/assets/post-image/Xcode-Debugging.png" | absolute_url }})

- Debugging navigator 
  - 어느 스레드에서 문제가 발생했는지 알 수 있다.
  - stack..
- debugging area - ctrl + shift + y 누르면 나오는 곳
  - 왼쪽 : 현재 scope에서 유효한 변수
  - 오른쪽 : 콘솔. lldb command 입력하는 곳
- 아이콘 (왼쪽 → 오른쪽 순서)
  1. breakpoint enable/disable
  2. 다음 breakpoint까지 실행
  3. 라인별 실행
  4. step in : 함수 안으로 들어감
  5. step out : 현재 실행되는 함수 밖으로 나감
- 관련 공식 문서
  [Xcode help - Debug your app](<https://help.apple.com/xcode/mac/10.2/index.html?localePath=en.lproj#/devda5478599>)

&nbsp;

&nbsp;

##  What To do When Error Occured

### :one: 오류메시지를 정확히 파악하기

- debugging area 에 있는 오류 메시지를 읽기!!

- 'nil 상태인 애가 unwrapping 되어서 문제가 생겼다' 라고 나옴

  ```swift
  func abc(_ param: String!) {
    var aa:String! = param
    print(param)
    
    aa = nil
    aa = aa + "abc" // 여기서 nil을 unwrapping 하다가 에러남
    print(aa)
  }
  
  abs("myName")
  ```

- Error 위치에 breakpoint 찍고 실행해 보기 보다는 일단 먼저 에러메시지를 읽고 원인을 파악하는게 먼저다.
  그 뒤에 디버깅 과정이 수행되어야 함

&nbsp;

&nbsp;

### :two: lldb : 디버깅 명령어

- 할 수 있는 일
  - 콘솔에서 변수 추가 하거나 기존 변수에 값을 임의로 넣을 수 있다.
- 종류
  - po
  - expr
  - 등등

- 사용 권장 사항
  - **자주 쓰는거 이외에도 다양하게 커버해보기!**

