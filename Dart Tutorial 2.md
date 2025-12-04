# Dart Basics

**Goal:** Master the fundamentals of the Dart programming language to prepare for Flutter development or server-side Dart.

## 1\. Introduction & Setup

Dart is a client-optimized language for fast apps on any platform. It uses **JIT (Just-In-Time)** compilation for fast development (Hot Reload) and **AOT (Ahead-Of-Time)** compilation for high-performance production binaries.

* **Try it instantly:** [DartPad](https://dartpad.dev/) (No installation required)
* **Install locally:** [Get the Dart SDK](https://dart.dev/get-dart)
* **Documentation:** [Dart Overview](https://dart.dev/overview)

## 2\. Variables and Data Types

Dart is type-safe. You can define types explicitly `String` or use type inference (`var`).

### Key Concepts

* **`var`:** Let Dart guess the type.
* **`final`:** A variable that can only be set once (runtime constant).
* **`const`:** A compile-time constant (must be known before the app runs).

```dart
void main() {
  String name = 'Voyager I'; // Explicit
  var year = 1977;           // Inferred as int
  
  final planet = 'Jupiter';  // Cannot be changed later
  const double gravity = 9.8; 
  
  print('Flyby object: $name'); // String interpolation
}
```

* **Doc Link:** [Variables](https://dart.dev/language/variables)
* **Doc Link:** [Built-in Types](https://dart.dev/language/built-in-types)

### The Dynamic Keyword

Dart provides flexibility when you need to break out of the strict type system or ignore specific values.

Dart is typed, but sometimes you don't know the type of data until the code runs (e.g., parsing a complex JSON response).

* **Definition:** `dynamic` explicitly tells Dart: "Don't check the type. I know what I'm doing."
* **The Risk:** It disables compile-time safety. If you call a function that doesn't exist on the object, the app will crash at runtime.

```dart
void main() {
  dynamic variable = 'I am a string';
  print(variable.length); // Works
  
  variable = 42; // Allowed: Changing type from String to Int
  
  // variable.substring(0,1); // CRASH! Int doesn't have substring(), but compiler won't warn you.
}
```

Avoid `dynamic` whenever possible. Use `Object?` if you want to accept any value but still keep type safety (forcing you to check the type before using it).

### Wildcards (The Underscore `_`)

In Dart, the underscore `_` works as a wildcard. When working with lists, maps, or switch statements, you often receive data you don't need. The `_` acts as a placeholder that matches any value and discards it.

```dart
void main() {
  var list = [1, 2, 3, 4];
  
  // Destructuring: We only want the first and fourth items
  var [first, _, _, fourth] = list; 
  
  print(first); // 1
  print(fourth); // 4
}
```

### Summary of "Any Type" confusion

It is common to confuse these three. Here is a quick reference table:

| Keyword | Behavior | Type Check? | Type Safe? |
| :--- | :--- | :--- | :--- |
| `var` | Dart guesses the type once. It creates a fixed type. | Yes | Yes |
| `Object` | Accepts any value, but you can only use `Object` methods (like `.toString`). | Yes | Yes |
| `dynamic`| Accepts any value and lets you call any method. | **No** | No |

### Null Safety

Dart enforces sound null safety. Variables cannot be null unless you explicitly say they can be. This prevents "Null Reference" crashes.

* `String` : Non-nullable (Must have a value).
* `String?` : Nullable (Can be a string OR null).
* `!` : Bang (converts a nullable to a non-nullable).

```dart
void main() {
  String? name; // Can be null
  name = 'Dart';

  print(name?.length); // SAFE: Prints length if name exists, null if it doesn't.
  print(name.length); // Throws error if name is null
}
```

**Doc Link:** [Null Safety Understanding](https://dart.dev/null-safety/understanding-null-safety)

## 3\. Control Flow Statements

Standard logic control found in C-style languages.

### Control Statments

Dart has switch cases and if statements

### If and More

#### If and Else Statement

```dart
void main() {
  int age = -1;
  if(age < 18) {
    print("You're a minor");
  } else {
    print("You're a major");
  }
}
```

#### Ternary Operators

```dart
void main() {
  int age = 19;
  print(age < 18 ? "You are a minor" : "You are a major");
}
```

#### Switch Case

##### With Numbers

```dart
void main() {

  int dayOfWeek = 3; // Let's check for Wednesday
  switch (dayOfWeek) {
    case 1:
      print('It\'s Monday. Time to start the week!');
      break; // 'break' exits the switch statement.
    case 2:
      print('It\'s Tuesday. Keep up the good work!');
      break;
    case 3:
      print('It\'s Wednesday. Middle of the week!');
      break;
    case 4:
      print('It\'s Thursday. Almost there!');
      break;
    case 5:
      print('It\'s Friday. Weekend is near!');
      break;
    case 6:
      print('It\'s Saturday. Enjoy your free day!');
      break;
    case 7:
      print('It\'s Sunday. Relax and recharge!');
      break;
    default:
      print('Invalid day of week value. Please enter a number between 1 and 7.');
  }
}
```

##### With Enums

```dart
enum Key { up, down, left, right }

void main() {
  Key k = Key.up;
  switch (k) {
    case Key.up:
      print("UP");
      break;
    case Key.down:
      print("DOWN");
      break;
    case Key.left:
      print("LEFT");
      break;
    case Key.right:
      print("RIGHT");
      break;
  }
}
```

### Loops

#### For and For In Loops

```dart
void main() {
  var list = [1, 2, 3, 4];
  
  // For in
  for (final i in list) {
    print(i); 
  }
  
  // For loop
  for (var i = 1;i < 5;i++) {
    print(i);
  }
}
```

#### Do While Loops

```dart
import 'dart:io';

void main() {
  String? run;
  do {
    print("Do you want to continue running the program (y/n): ");
    run = stdin.readLineSync();
  } while (run != "n");
}
```

#### While Loops

```dart
while (true) {
  if (shutDownRequested()) break;
  processIncomingRequests();
}
```

#### Labels

```dart
void main() {
  outerLoop:
  for (var i = 1; i <= 3; i++) {
    for (var j = 1; j <= 3; j++) {
      print('i = $i, j = $j');
      if (i == 2 && j == 2) {
        break outerLoop;
      }
    }
  }

  print('outerLoop exited');
}
```

#### Loops and Arrays

```dart
void main() {
  List<String> arr = ["alice", "bob", "charlie", "daisy"];
  arr.map((str) => str[0].toUpperCase() + str.substring(1))
    .forEach((name) => print(name));
  
  arr.where((str) => str.length == 5)
    .forEach((name) {
      print(name);
    });
}
```

* **Resource:** [Lists in Dart](https://www.codecademy.com/resources/docs/dart/list/add)
* **Doc Link:** [Control flow](https://dart.dev/language/loops)

## 4\. Functions

Functions are objects in Dart. Key features include **Named Parameters** (very common in Flutter) and **Arrow Syntax**.

### Functions

```dart
// Standard Function
int add(int a, int b) {
  return a + b;
}

// Arrow Syntax (for one-liners)
int multiply(int a, int b) => a * b;
```

### Named Parameters

```dart
void greet({required String? firstName, String? lastName, String title = "Mx."}) {
  print('Hello $title $firstName $lastName');
}

void main() {
  greet(firstName: "Fictitious", lastName: "Formulation"); // Readable usage
  greet(firstName: "Alex", title: "Ms.");
}
```

* **Doc Link:** [Functions](https://dart.dev/language/functions)

## 5\. Object-Oriented Programming (OOP)

### Classes and Constructors

#### Classes and Objects

```dart
import 'dart:math';

class Point {
  double _x;
  double _y;
  Point(this._x, this._y);

  double distanceFrom(Point b) {
    return sqrt(pow(this._x - b._x, 2) + pow(this._y - b._y, 2));
  }
}
```

```dart
import 'point.dart';

void main() {
  var p1 = Point(0, 0);
  var p2 = Point(3, 4);
  print(p1.distanceFrom(p2));
}
```

#### Extending Objects

Some coding patterns rely on tightening a type by overriding a parameter's type with a subtype, which is invalid. In this case, you can use the `covariant` keyword to tell the analyzer that you're doing this intentionally. This removes the static error and instead checks for an invalid argument type at runtime.

```dart
class Point3D extends Point {
  double _z;

  Point3D(double x, double y, this._z) : super(x, y);
  
  // We use 'covariant' because normally you can't change the type of the 

  double distanceFrom(covariant Point3D b) {
    return sqrt(pow(this._x - b._x, 2) + pow(this._y - b._y, 2) + pow(this._z - b._z, 2));
  }
}
```

#### Callable Objects

```dart
class WannabeFunction {
  String call(String a, String b, String c) => '$a $b $c!';
}

void main() {
  var wf = WannabeFunction();
  var out = wf('Hi', 'there,', 'gang');
  print(out);
}
```

#### Abstract Classes

```dart
abstract class Shape {
  double calculateArea();

  void describe() {
    print('This is a generic geometric shape.');
  }
}

class Circle extends Shape { // Can also use the implements keyword but that would require implementing every method in the abstract class
  final double radius;

  Circle(this.radius);

  // Must implement the abstract method from Shape
  @override
  double calculateArea() {
    return 3.14159 * radius * radius;
  }
}
```

#### Generics

```dart
class Container<T> {
  T item;

  Container(this.item);

  T getItem() {
    return item;
  }
}
```

#### Mixins

```dart
mixin Logger {
  void log(String message) {
    print('[LOG] ${DateTime.now()}: $message');
  }
}

// Can use methods from mixins in classes. Use the with keyword

class UserService with Logger {
  void registerUser(String username) {
    log('User registration started for: $username');
  }
}
```

* **Classes Doc Link:** [Classes](https://dart.dev/language/classes)
* **Mixin Doc Link:** [Mixins](https://dart.dev/language/mixins)
* **Article on Mixins** [More on Mixins](https://medium.com/flutter-community/dart-what-are-mixins-3a72344011f3)
* **More Methods**
  * `identical(p1, p2)`: Checks if two objects are the same. (variables point to the same object).
  * `object.runtimeType`: Gives the type of the object. (The name of the class from which the object was created).

## 6\. Challenges

1. Print the number of days in a month without using if statements.
2. Implement a linked stack in dart.
