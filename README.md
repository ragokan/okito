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
    - [Watch Controller](#watch-controller)
    - [Update Controller](#update-controller)
- [Tips](#tips)
    - [Cleaner Widgets](#cleaner-widgets)
    - [Update State](#update-state)
- [Utilities](#utilities)
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
#### Watch Controller
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
#### This part contains the code I wrote to make my coding easier and it is open source, you can also use or contribute it!

```dart
// First Usage
Okito.of(context).width;
Okito.of(context).height;
Okito.of(context).aspectRatio;
Okito.of(context).devicePixelRatio;
Okito.of(context).isLandscape;
Okito.of(context).isPortrait;
Okito.of(context).theme;

Okito.of(context).showSnackBar();
Okito.of(context).showModal();
Okito.of(context).showDialog();

Okito.of(context).push();
Okito.of(context).pushReplacement();
Okito.of(context).pushNamed();
Okito.of(context).pushReplacementNamed();
Okito.of(context).pop();
Okito.of(context).arguments;
Okito.of(context).routeName;

// Second Usage
final okito = Okito(context:context);
okito.width;
okito.height;
okito.aspectRatio;
okito.devicePixelRatio;
okito.isLandscape;
okito.isPortrait;
okito.theme;

okito.showSnackBar();
okito.showModal();
okito.showDialog();

okito.push();
okito.pushReplacement();
okito.pushNamed();
okito.pushReplacementNamed();
okito.pop();
okito.arguments;
okito.routeName;

// Third Usage
import 'package:okito/okito.dart';  //or 
import 'package:okito/bin/extensions/okito_extensions.dart'; 
// These are extensions for the 'context', I didn't wanted to include in default import in case of your other packages' or your having a chance to use them.

context.width;
context.height;
context.aspectRatio;
context.devicePixelRatio;
context.isLandscape;
context.isPortrait;
context.theme;

context.showSnackBar();
context.showModal();
context.showDialog();

context.push();
context.pushReplacement();
context.pushNamed();
context.pushReplacementNamed();
context.pop();
context.arguments;
context.routeName;
```


# Examples
- [Counter Example](https://github.com/ragokan/okito/blob/master/example/flutter_counter/lib/main.dart)
- [To Do Example](https://github.com/ragokan/to_do)


# How to contribute okito
- okito needs tests.
- okito needs more examples.
