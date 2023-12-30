# Python OOPs Concepts

This repository contains Python files demonstrating various Object-Oriented Programming (OOPs) concepts such as inheritance, encapsulation, polymorphism, and abstraction.

## Files Included:

### 1. Inheritance (`inheritance.py`)

This file showcases the concept of inheritance in Python. Inheritance is a fundamental feature of OOPs that allows a class to inherit attributes and behaviors (methods) from another class.

#### How Inheritance Works:

- **Parent Class (Base Class)**: Defines attributes and methods common to multiple classes. In our example, the `Animal` class is the parent class.

- **Child Class (Derived Class)**: Inherits attributes and methods from the parent class and can also have its own unique attributes and methods. In our example, the `Dog` class is a child class that inherits from `Animal`.

#### Example:

The `inheritance.py` file demonstrates how a `Dog` class inherits from an `Animal` class:

```python
class Animal:
    def __init__(self, species):
        self.species = species

    def make_sound(self):
        pass

class Dog(Animal):
    def __init__(self, name):
        super().__init__('Dog')
        self.name = name

    def make_sound(self):
        return "Woof!"

my_dog = Dog('Buddy')
print(f"My {my_dog.species} named {my_dog.name} says: {my_dog.make_sound()}")
