---
layout: post
title:  "[RxSwift] - observe(on:) vs. subscribe(on:) : when to use them to specify threads"
date: 2023-08-23 11:22:59
author: Dana Lee
categories: [RxSwift, iOS]
tags: [RxSwift, iOS, observe, subscribe]
language: en
lastmod : 2023-08-23 11:22:59
sitemap :
  changefreq : weekly
  priority : 1.5
excerpt: "This is a post explaining which one to use among two confusing operators when setting schedulers in RxSwift"

---

## Summary
🔑 `observe(on:)` : to set which scheduler (thread) you want to <u>receive events on</u> and use them. <br>
🔑 `subscribe(on:)` : to set where the observable does its work.

&nbsp;
![]({{site.url}}/assets/post-image/Rx_thread_1.png)

One of the confusing operations when using RxSwift is determining whether to use `observe(on:)` or `subscribe(on:)`. It is not difficult to decide, but it is something easy to get confused about, and I often forget and have to look it up most of the time.

Both of these are operators in Swift that allow you to set which thread (or scheduler) you would like your operation to run on. As you may know, specifying which thread, typically between the main and background threads, is a crucial task in iOS development.



## Preliminary Concepts

### Subscription

A subscription is created at the moment the `.subscribe()` operator is called on an Observable. When you call `.subscribe(onNext: …)`, what you create is a subscription. It is the act of subscribing - here is my observer, so please notify me when new events occur in the observable.

### Observer

In `.subscribe(onNext, onError…)`, an observer refers to the set of callbacks that define how to handle or react to each type of event in the event handler.

On the whole, subscription and observer are not exclusive concepts but are related.

### Summary
- **Observer**:
An "observer" is essentially a set of callbacks that define how to react to events emitted by an Observable.
- **Subscription**:
A "subscription" refers to the action or process of an observer subscribing to an Observable's emitted events.

```swift
Observable.just("Hello")
    .subscribe(onNext: { value in // The callback passed to onNext is the observer
        print("Received value: \\(value)")
    })
// This call creates a subscription, and with the returned disposable,
// you can also cancel the subscription.

```

## observe(on:) & subscribe(on:)

- `observe(on:)`: Specifies the thread on which the observer will be executed.
- `subscribe(on:)`: Specifies the thread on which the subscription is created.

To put it simply:

- `observe(on:)` is where the code that handles (reacts to) the events is executed.
- `subscribe(on:)` is where the Observable performs its work (generates events, etc.).

```swift
Observable<String>.create { observer in
				// This runs on the background thread
        print("Doing work on thread: \\(Thread.current)")
        observer.onNext("Some Value")
        return Disposables.create()
    }
    .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    .observe(on: MainScheduler.instance)
    .subscribe(onNext: { value in
				// This runs on the main thread
        print("Received value on thread: \\(Thread.current)")
        print("Received value: \\(value)")
    })

```
![]({{site.url}}/assets/post-image/Rx_thread_2.png)

- The Observable is created and works on the background queue because `subscribe(on:)` specifies the ConcurrentDispatchQueueScheduler. (the orange color part)
- The observer handles the events on the main thread because `observe(on:)` specifies the MainScheduler. (the blue color part)


