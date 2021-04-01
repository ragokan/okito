# okito
## The simplest state management solution ever, at least I think so. It depends on nothing, works really fast with minimum code usage.
[![pub points](https://badges.bar/okito/pub%20points)](https://pub.dev/packages/okito/score)
[![likes](https://badges.bar/okito/likes)](https://pub.dev/packages/okito/score)
[![popularity](https://badges.bar/okito/popularity)](https://pub.dev/packages/okito/score)
[![pub version](https://img.shields.io/pub/v/okito)](https://pub.dev/packages/okito)
[![GitHub last commit](https://img.shields.io/github/last-commit/ragokan/okito)](https://github.com/ragokan/okito)
### With okito, you don't need to wrap your material app for state, you don't need any complex libraries and most importantly your don't need context to have a state or update state. For the state management purposes, it is as small as it can be. The aim is reducing the size and dependency usage as much as possible. Basically the state management has only what it needs, nothing more, nothing less!

&nbsp;

## Content
```dart
import 'package:okito/okito.dart'; // You should add this import first.
```
- [State Management](#state-management)
    - [Create Controller](#create-controller)
    - [Use Controller](#use-controller)
    - [Update Controller](#update-controller)
    - [Watch Controller](#watch-controller)
- [Tips](#tips)
    - [Cleaner Widgets](#cleaner-widgets)
    - [Update State](#update-state)
- [Utilities + Routing](#utilities)
- [Extensions](#extensions)
- [Examples](#examples)
- [How to contribute okito](#how-to-contribute-okito)

&nbsp;
# State Management

#### Create Controller
```dart
class CounterController extends OkitoController {
  int count = 0;

  void increment() => setState(() => count++);

  void decrement() {
    count--;
    update();
  }
}

CounterController counterController = CounterController();
```

---
#### Use Controller
```dart
// That simple!
OkitoBuilder(
      controller: counterController,
      builder: () => Text('${counterController.count}'),
    );
```

---
#### Update Controller
```dart
    main(){
        // You can change state from anywhere without context!
        counterController.increment();
    }

    // In Flutter
    ElevatedButton(
                  onPressed: counterController.increment,
                  child: const Text('Increment'),
                )
    // Or
     ElevatedButton(
                  onPressed: () => counterController
                      .setState(() => counterController.count--),
                  child: const Text('Decrement'),
                )
```

---
#### Watch Controller
```dart
    OkitoWatcher(
    watch: counterController,
    onChange: (CounterController controller) {
      // You can also update the state there.
      // onChange gives to you is the instance of controller.
      print(controller.count);
    },
  );
  counterController.increment();

  // OkitoWatcher also returns a function that stops watching which
  // reduces the memory usage, you can use it when your usage ends.

  final stopWatching = OkitoWatcher(/* code here */);
  // do what you want to do while watching, then:
  stopWatching();
```

# Tips

#### Cleaner Widgets
```dart
// In your widgets folder or any other folder, declare builder.
OkitoBuilder CounterBuilder({
  required Widget Function() builder,
}) =>
    OkitoBuilder(
      controller: counterController,
      builder: () => builder(),
    );

// Usage
CounterBuilder(builder: () => Text('${counterController.count}'));
```

My Favorite Way
```dart
OkitoBuilder CounterBuilder({
  required Widget Function(CounterController state) builder,
}) =>
    OkitoBuilder(
      controller: counterController,
      builder: () => builder(counterController),
    );

// Usage
CounterBuilder(builder: (state) => Text('${state.count}'));
```


---
#### Update State
```dart
class CounterController extends OkitoController {
  int _count = 0;

  int get count => _count;

  set count(int count) {
    _count = count;
    // Now, whenever you change count like 'count++', it will update state.
    update();
  }
}
```

# Utilities
### Firstly, we should wrap our app with Okito or provide Okito
```dart
// Basically, you should add *Okito* to the beginning of your app or provide key/observers manually.

OkitoMaterialApp(/*  Everything is same with [MaterialApp] */);

// Or
OkitoCupertinoApp(/*  Everything is same with [CupertinoApp] */);

// Or
Material/CupertinoApp(
    navigatorKey: Okito.navigatorKey,
    navigatorObservers: [OkitoObserver()]);
```

Then you can use all of Okito Benefits!
```dart
Okito.width;
Okito.height;
Okito.aspectRatio;
Okito.devicePixelRatio;
Okito.isLandscape;
Okito.isPortrait;
Okito.theme;

Okito.showSnackBar();
Okito.showModal();
Okito.showDialog();

Okito.push();
Okito.pushReplacement();
Okito.pushNamed();
Okito.pushReplacementNamed();
Okito.pop();
Okito.arguments;
Okito.routeName;
```

# Extensions
```dart
context.width;
context.height;
context.aspectRatio;
context.devicePixelRatio;
context.isLandscape;
context.isPortrait;
context.theme;
```


# Examples
- [Counter Example](https://github.com/ragokan/okito/blob/master/example/flutter_counter/lib/main.dart)
- [To Do Example](https://github.com/ragokan/to_do)


# How to contribute okito
- okito needs tests.
- okito needs more examples.
