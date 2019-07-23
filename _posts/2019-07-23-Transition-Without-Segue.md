---
layout: post
title:  "[iOS] Segue 없이 코드로 view controller 간 전환하기"
date:  2019-07-23 23:02:59
author: Dana Lee
categories: iOS
tags: [Segue, View Controller, Presentation]
lastmod : 2019-07-23 23:02:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

Segue 는 Interface Builder 에서 한 scene 에서 다른 scene 으로 전환/이동 할 수 있도록 해준다. 

다음은 Storyboard 에서 Segue 를 이용하여 다음 vc 로 전환하는 과정이다.

![](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_displaying-view-controller-using-segue_9-4_2x.png)

Segue 가 다음 view controller 를 `instantiateViewCotroller(withIdentifier:)` method 로 초기화하고 넘겨주는 과정을 담당한다.

&nbsp;

## segue 없이 코드로 이동하기

Segue 없이 코드로만 전환하는 과정도 이와 비슷하다. 그저 Segue 가 자동으로 해주던 일을 코드로 명시적으로 표현해주면 된다.

1. 다음 vc 의 storyboard ID 를 설정한다 - 이 ID 로 view controller를 코드에서 찾을 수 있다.

   ![]({{site.url}}/assets/post-image/storyboard-id.png)

2. Vc 가 있는 storyboard 를 참조한다

3. 해당 storyboard 에서 다음 vc 를 찾아 생성한다

4. 현재 vc → 다음 vc presenting

*FirstViewController → NextViewController*

```swift
class FirstViewController: UIViewController {
	//....
	@IBAction func nextButtonPressed(_ sender: UIButton) {
    // 2. Main.storyboard 를 참조한다.
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    // 3. 해당 storyboard 에서 NextVC id 를 가진 view controller 를 초기화한다
    let nextVC = mainStoryboard.instantiateViewController(withIdentifier: "NextVC")
    
    // 4. nextVC 를 present 한다.
    self.present(nextVC, animated: true, completion: nil)
    }	
}
```



---

### 📌 Reference

- [View controller Programming Guide for iOS](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/index.html#//apple_ref/doc/uid/TP40007457-CH2-SW1)
- [2 ViewController Navigation Without Segue](https://www.youtube.com/watch?v=c5blPI3Asmw)

