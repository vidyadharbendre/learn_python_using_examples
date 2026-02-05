#!/usr/bin/env python3

# Parent class
class Animal:
    def __init__(self, species: str) -> None:
        self.species = species

    def make_sound(self) -> str:
        raise NotImplementedError


# Child class inheriting from Animal
class Dog(Animal):
    def __init__(self, name: str) -> None:
        super().__init__("Dog")
        self.name = name

    def make_sound(self) -> str:
        return "Woof!"


# Creating an instance of Dog
if __name__ == "__main__":
    my_dog = Dog("Buddy")
    print(f"My {my_dog.species} named {my_dog.name} says: {my_dog.make_sound()}")
