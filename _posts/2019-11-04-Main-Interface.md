---
layout: post
title:  "[Xcode] Main Interface : 맨 처음 나오는 storyboard 지정하기"
date:  2019-11-04 22:05:59
author: Dana Lee
categories: [iOS, Xcode]
tags: [Initial View Controller, Initial Storyboard, Main Interface, Xcode]
lastmod : 2019-11-04 22:05:59
sitemap :
  changefreq : weekly
  priority : 1.5
---

# 앱 가장 처음에 나올 storyboard 지정하는 법

오늘 하루 종일 삽질하다가 Xcode 에 **Main Interface** 란게 있다는 사실, 그리고 왜 맨 처음 앱을 생성하면 나오는 storyboard 의 이름이 **Main** 인지도 알게 되었다.

&nbsp;

iOS 앱에서 LanchScreen 이후에 가장 먼저 나올 Scene을 지정하는 방법은 다음 두가지이다.

```
1. Xcode 에서 설정해준다 
2. AppDelegate 에서 Launch 과정에서 programmatically 하게 코드로 지정한다.
```

그중에서 Xcode에서 설정하는 방법은 Main Interface에서 설정하면 된다.

![]({{site.url}}/assets/post-image/main-interface.png)

- **Project** → **Target** 에서 원하는 앱 선택 → **Deployment Info** 에 있는 **Main Interface** 에서 지정 가능!
- Main Interface 옆에 화살표를 눌러 프로젝트에 있는 모든 storyboard 중 하나를 고를 수 있다!

&nbsp;

저 Main Interface 부분을 비워두고 AppDelegate 에서 코드로만 구현해도 된다고 한다.

프로젝트를 생성하면 디폴트로 Main이 설정되어 있다. 

혹시 맨 처음 나올 Storyboard (및 그에 연결된 ViewController)를 Main 이 아닌 자신이 만든 다른 것으로 지정하고 싶다면 편리하게 여기서 바꾸면 된다!!

&nbsp;

오늘 로그인 구현하는 코드를 보다가 AppDelegate에서 지정하는 줄 알았는데 일단 무조건 Main Interface에서 지정한 Storyboard Scene 을 타는지도 모르고 계속 삽질하다가 알게 되었다.. :sweat: 

&nbsp;

