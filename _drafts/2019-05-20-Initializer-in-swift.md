# Initializer

## Initialization

class, struct, enum 을 사용하기 전에 준비해 주는 과정

새로운 instance 를 사용준비 해주는 과정

> *Initialization* is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that is required before the new instance is ready for use.



특정 type내에서 정의되어있고, 새로운 instance 준비과정을 담당하는 method가 initializer



> You implement this initialization process by defining *initializers*, which are like special methods that can be called to create a new instance of a particular type. Unlike Objective-C initializers, Swift initializers do not return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they are used for the first time.

