#!/usr/bin/env python3

# Parent class
class Animal:
    def __init__(self, species):
        self.species = species

    def make_sound(self):
        pass

# Child class inheriting from Animal
class Dog(Animal):
    def __init__(self, name):
        super().__init__('Dog')
        self.name = name

    def make_sound(self):
        return "Woof!"

# Creating an instance of Dog
my_dog = Dog('Buddy')
print(f"My {my_dog.species} named {my_dog.name} says: {my_dog.make_sound()}")
