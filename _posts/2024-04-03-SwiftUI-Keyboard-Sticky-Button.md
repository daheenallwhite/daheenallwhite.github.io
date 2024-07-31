---
layout: post
title: "[SwiftUI] Creating a Sticky Floating Button with Just One Spacer"
date: 2024-04-03 00:55:30
author: Dana Lee
categories: [iOS, SwiftUI]
tags: [SwiftUI, Button on keyboard, StickyButton on keyboard, Floating button on keboard]
lastmod : 2024-04-03 00:55:30
language: en
sitemap :
  changefreq : weekly
  priority : 1.5
excerpt: "This post shares a tip to implement a button that sticks to keyboard when the keyboard appears and disappears."
---

## Summary
🤔 How can I implement a sticky/floating button that satisfies the following?
1. It sticks to the bottom when the keyboard disappears.
2. It sticks to the right above the keyboard when it is appearing.

### Solution
**SwiftUI** : ⭐️ Spacer ⭐️ 

**UIKit** : 1. inputAccessaryView 2. modify constraints by observing keyboard event

&nbsp;

## StickyButton on Keyboard ? FloatingButton on Keyboard?

You might come across a button that behaves like this when using apps, typically entering information in textfields. 

![]({{site.url}}/assets/post-image/sticky-button-1.png)
(*reference: [Marshmallow](https://www.marshmallow.com/)*)

Recently, I found absolutely simple and short solution to implement this sticky/floating button in SwiftUI. **Just utilize the beauty of** [`Spacer`](https://developer.apple.com/documentation/swiftui/spacer). 

Here are the requirements that this button should satisfy:
1. It sticks to the bottom when the keyboard disappears.
2. It sticks to the right above the keyboard when appearing.

You can solve this by using `Spacer`!
Here is the detailed code. The crucial part is at the end. 

```swift
var body: some View {
      ZStack {
        backgroundView
        inputView
        
        // Here's the view to focus on
        VStack {
          Spacer()
          Button("Send Code") {
            // Add button action
          }
        }
      }.padding(.all)
      .onTapGesture {
        print("Tapped background")
        simpleFocus = false
      }
    }

```

All you need to do is to put **spacer and button in VStack**. Make sure that the spacer goes first and then button. Compared to existing solutions in UIKit, it is absolutely simple and straightforward.

⬇️ Here's a demonstration of the sticky/floating button implemented using the code described above:
![]({{site.url}}/assets/post-image/sticky-button-2.gif)
You can find detailed codes [here](https://github.com/daheenallwhite/KeyboardStickyButton/blob/main/StickyButton/StickyButton/SwiftUIStickyButton.swift). 

&nbsp;

## Underlying mechanism

The power of `Spacer` lies in its ability to fill available space. Let's break down how it works:

1. **Keyboard hidden**: The spacer expands to fill the VStack.
2. **Keyboard appearing**: As the keyboard rises, the available space decreases. The spacer shrinks, pushing the button upwards.
3. **Keyboard fully visible**: The button sits right above the keyboard.

This elegant solution stems from the Spacer's expanding characteristic. It simply shrinks as the keyboard rises.

What's stunning is how much simpler this SwiftUI solution is compared to UIKit. In UIKit, you'd typically use one of two more complex approaches:

1. Utilize `inputAccessaryView` ([official documents](https://developer.apple.com/documentation/uikit/uiresponder/1621119-inputaccessoryview))
2. Update view constraints by observing keyboard events

(These UIKit approaches will be covered in a future article, and you can find the codes in the repository [here](https://github.com/daheenallwhite/KeyboardStickyButton))