# okito
## The simplest state management solution ever, at least I think so. It depends on nothing, works really fast with minimum code usage.
[![pub points](https://badges.bar/okito/pub%20points)](https://pub.dev/packages/okito/score)
[![likes](https://badges.bar/okito/likes)](https://pub.dev/packages/okito/score)
[![popularity](https://badges.bar/okito/popularity)](https://pub.dev/packages/okito/score)
[![pub version](https://img.shields.io/pub/v/okito)](https://pub.dev/packages/okito)
[![GitHub last commit](https://img.shields.io/github/last-commit/ragokan/okito)](https://github.com/ragokan/okito)
### With okito, you don't need to wrap your material app for state management, you don't need any complex libraries and most importantly your don't need context to have a state or update state. For the state management purposes, it is as small as it can be. The aim is reducing the size and dependency usage as much as possible. Basically the state management has only what it needs, nothing more, nothing less!

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
- [Utilities + Routing](#utilities)
- [Local Storage](#local-storage)
- [Extensions](#extensions)
- [Tips](#tips)
    - [Cleaner Widgets](#cleaner-widgets)
    - [Update State](#update-state)
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
-
*All of the properities has same usages with its long usage*

*For example: Okito.pushNamed('/secondPage') = Navigator.of(context).pushNamed('secondPage')*
```dart
Okito.width;
Okito.height;
Okito.aspectRatio;
Okito.devicePixelRatio;
Okito.isLandscape;
Okito.isPortrait;
Okito.theme;

Okito.showSnackBar();
Okito.showToast(); // Snackbar without widget, usefull for simple usage.
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

# Local Storage
### *OkitoStorage* is a way to save variables to the local storage.
### It works like SharedPereferences but it is synchronous or GetStorage.
#### *OkitoStorage* is blazingly fast because in read operations, it uses memory to get data instead of reading from disk everytime!

```dart
// To use, you should init the storage, it is not required for web but required for all other platforms.

void main() async{
  // Only init is asynchronous, you can also call without await but it is not recommended.
  await OkitoStorage.init();


  // Usage
  final box = OkitoStorage; // For easier reference.

  box.write('count', 0);

  final int count = box.read<int>('count');
  // Simple as this!

  print('Count is $count');
  // Rest of your code will be here.
}
```
Other Usages
```dart
  box.watchKey('count', () => 
    print('This function will be called whenever the count changes.');
  );

  box.watchAll(() => 
    print('This function will be called whenever the storage changes.');
  );

  box.removeKey('count'); // Removes the key
  
  box.readAllKeys(); // returns all keys in storage

  box.readAllValues(); // returns all values in storage

  box.readAll(); // returns all of the storage

  box.clearStorage(); // removes everything from the storage but storage will still exists.

  box.deleteStorage(); // removes the storage from file system completely, after this operation, OkitoStorage won't be able to write or read.
```

### Watch OkitoStorage With OkitoBuilder
```dart
// Check the example/flutter_okito_storage/lib/main.dart for more examples!

// It will run whenever key 'count' changes.
OkitoBuilder(
      controller: yourController,
      watchStorageKeys: ['count'],
      builder: () => Text('${box.read('count')}'),
    );
```

#### Benefits Of OkitoStorage
- Really fast
- You can watch the changes from anywhere, even in your builders.
- It is synchronous, so you don't have to use 'await' keyword.
- You can storage Strings, ints, Maps and even Lists.
- Works on any device that flutter supports!

#### OkitoStorage is reliable but be careful when using it as database, because it is not created to be database. For complex works, you can try Hive!

# Extensions
```dart
context.width;
context.height;
context.aspectRatio;
context.devicePixelRatio;
context.isLandscape;
context.isPortrait;
context.theme;
context.arguments;
context.routeName;
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

# Examples
- [Counter Example](https://github.com/ragokan/okito/blob/master/example/flutter_counter/lib/main.dart)
- [To Do Example](https://github.com/ragokan/to_do)


# How to contribute okito
- okito needs tests.
- okito needs more examples.
- okito needs a better readme file :D
- okito needs reputition, likes and users!
- okito needs test with Apple products, I tested on linux, android, web and Windows