# okito

## Your best flutter coding friend. All in one; state management, navigation management(with dynamic routing), local storage, dependency injection, localization, cool extensions with best usages and with the support of best utilities!

[![pub points](https://badges.bar/okito/pub%20points)](https://pub.dev/packages/okito/score)
[![likes](https://badges.bar/okito/likes)](https://pub.dev/packages/okito/score)
[![popularity](https://badges.bar/okito/popularity)](https://pub.dev/packages/okito/score)
[![GitHub Repo stars](https://img.shields.io/github/stars/ragokan/okito?label=github%20stars)](https://github.com/ragokan/okito)
[![pub version](https://img.shields.io/pub/v/okito)](https://pub.dev/packages/okito)
[![GitHub last commit](https://img.shields.io/github/last-commit/ragokan/okito)](https://github.com/ragokan/okito)

### [Click here to join our discord community channel!](https://discord.gg/2pg7B73U8j)

&nbsp;

## Features

- [State Management](#state-management)
  - [Create Controller](#create-controller)
  - [Use Controller](#use-controller)
  - [Update Controller](#update-controller)
  - [Rockitos](#rockitos)
  - [Watch Controller](#watch-controller)
  - [State Methods](#state-methods)
- [Utilities + Navigation](#utilities)
  - [Routing Management 🚀](#routing-management)
  - [Theme Management](#theme-management)
- [Local Storage](#local-storage)
- [Localization](#localization)
- [Extensions](#extensions)
- [Dependency Injection](#dependency-injection)

## Contents

- [Tips](#tips)
  - [Cleaner Widgets](#cleaner-widgets)
  - [Update State](#update-state)
  - [App Controller](#app-controller)
- [Tutorials](#tutorials)
- [Examples](#examples)
- [How to contribute okito](#how-to-contribute-okito)

&nbsp;

# State Management

#### Create Controller

Q: What should I do to make it work?  
A: Just create a regular class and extend _OkitoController_, if you want to change the state, call update() or setState()

Q: How does these methods notify the state?  
A: They have a conversation between themselves, whenever you call these methods, the notifier checks all the builders, if they are watching, they will be re-built. So the scheme is;

Model -> Controller -> Model  
View -> Controller -> View  
The controller is the root of them.

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

You can also use _setStateAsync_ function to update data asynchronously.

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

#### Rockitos

Rockitos are our way to use state management with dependency injection!  
If you don't know what is dependency injection, read [Dependency Injection Guide](#dependency-injection) first.

```dart
// Rockito - My favorite vay to use Okito state.

Rockito<CounterController>(
  (controller) => Text('${controller.count}')
);
// Isn't it  simple ?
// To use _Rockito_, you should first inject the CounterController.

Okito.inject(CounterController);
```

```dart
// RockitoBuilder - Rockito but with more features and builder!
  RockitoBuilder<CounterController>(
    inject: CounterController(), // optionally, if you didn't inject it yet.
    builder: (controller) => Text('${controller.count}'),
    // You can use all of OkitoBuilder features here like otherControllers and etc.
  );
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

```dart
// You can also watch with Rockitos.
RockitoWatcher<CounterController>(
  (controller) => print(controller.count))
// You have to inject the controller first.
```

#### State Methods

State methods are methods like the _State_ class of Flutter.

```dart
class CounterController extends OkitoController{
  int count = 0;

  /// This will be called whenever your [OkitoBuilder] is mounted
  // to the widget tree.
  @override
  void initState() {
    count++;
  }
  /// This will be called whenever your [OkitoBuilder] is removed
  /// from the widget tree.
  @override
  void dispose() {
    count = 0;
  }
}
```

I personally use State Methods when I use controllers as StatefulWidget replacers.  
Example:

```dart
class EditProductController extends OkitoController {
  // other nodes here
  final priceFocusNode = FocusNode();

  void submitForm(){
    // I use my inputControllers here to get their values.
    // then I use my Okito routing without context!
    Okito.pushNamed('/productUpdatedSuccessfully/31')
  }

  @override
  void dispose() {
    // other nodes here to [dispose].
    priceFocusNode.dispose();
  }
}
```

# Utilities

### Navigation and using widgets without context.

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

## Then you can use all of Okito Benefits!

_All of the properities has same usages with its long usage_

_For example: Okito.pushNamed('/secondPage') = Navigator.of(context).pushNamed('secondPage')_

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

## Routing Management

### Lets say that you want dynamic urls like

```
/posts/:id
/posts/23
```

And this id is a dynamic variable, right?  
With _Okito_, you can do that easily!

```dart
// You don't need to add something like OkitoPage or etc.
// Okito lets you do your job without code changes.
OkitoMaterialApp(
      routes: {
        '/': (ctx) => FirstPage(),
        '/second/:id': (ctx) => SecondPage(),
      }
);
```

Now, whenever you try this:

```dart
ElevatedButton(
  onPressed: () => Okito.pushNamed(
    /// You can add any kind of arguments
    '/second/33?name=Rago&postId=123&isMaterial=true',
    arguments: 'This is an extra argument'),
    child: const Text('Go to second page'),
  )
```

It will push to second page with the argument [id] : [33]

Moreover, you will see your arguments like this:

```dart
print(Okito.arguments);
// result
{'id' : '33', 'name' : 'Rago', 'postId' : 123, 'isMaterial' : true, 'arguments': 'This is an extra argument'};
// Yes, you can even get extra arguments manually.
```

Check _example/flutter_dynamic_routing/lib/main.dart_ for a live example.

### Would you like to have more benefits? Of course!

## Theme Management

```dart
// Firstly, the bottom method gives you the app controller, you can update anything manually.
Okito.app; /* or */ Okito.use<AppController>();

// Then you have all of its usages.

Okito.app.setThemeData();
Okito.app.setThemeMode();
Okito.app.setCupertinoThemeData();

Okito.app.locale;
Okito.app.setLocale();
```

# Local Storage

### _OkitoStorage_ is a way to save variables to the local storage.

### It works like SharedPereferences but it is synchronous like GetStorage.

#### _OkitoStorage_ is blazingly fast because in read operations it uses memory to get data instead of reading from disk everytime!

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

# Localization

For global apps, it might be hard to find a new library for localization or creating your own, then you will probably have another problems
like updating the whole app after language change and etc. Why would you do that?

#### Okito provides localization solutions for your app.

```dart
// It is also so simple to have!
// Firstly create your translations like this:
const translations = {
  'en': {
    'hello': 'Hello from Okito!',
  },
  'tr': {
    'hello': "Okito'dan selamlar!",
  },
};
// You can have unlimited amount of locales and translations
// You can make it dynamic, seperate files and etc. It is just a dart map!
```

```dart
// After creating it, give it to the app.
OkitoMaterialApp /* or OkitoCupertinoApp */(
  translations: translations,
  /* Your code here without any change */);
```

```dart
// Using it? It is the simplest! Lets use it in a text widget.
Text('hello'.loc); // It will show 'Hello from Okito!'

// Lets change the language and see it again.
Okito.app.setLocale(Locale('tr','TR'));
// Now it says: 'Okito'dan selamlar!' as it is declared in translations.
```

```dart
// You can also set it like this;
Okito.localize('hello'); // returns the translation as String.
```

For better examples check example/flutter_localization/lib/main.dart

# Extensions

```dart
// Context Extensions
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

# Dependency Injection

### Dependency injection is your way to inject variables to the _Okito_ and use it anywhere in your app. With _Okito_, it is as simple as it can be!

```dart
// Example Variable
class Counter(){
  count = 0;
}

// Inject it
Okito.inject(Counter());


// Use it anywhere!
Okito.use<Counter>();

// Asign it with type support!
final counter = Okito.use<Counter>();

// Update however you want
counter.count++;
// or
Okito.use<Counter>().count++;
```

Soo, lets say that your job is done with that class, why would we let it to use memory?

```dart
// Counter will be gone forever!
Okito.eject<Counter>();
```

#### For more details, check the tests or examples about it!

## Injection With Keys

It is useful when you want to storage with a String key instead of type which gives you advantage of multiple injects with same type.

```dart
// Example Variable
class Counter(){
  count = 0;
}

// Inject it
Okito.injectWithKey('firstCounter',Counter());
Okito.injectWithKey('secondCounter',Counter());


// Use it anywhere with type support!
final firstCounter = Okito.useWithKey<Counter>('firstCounter');
final secondCounter = Okito.useWithKey<Counter>('secondCounter');

// Update however you want
firstCounter.count++;
secondCounter.count++;
```

Soo, lets say that your job is done with that class, why would we let it to use memory?

```dart
// Second counter will be gone forever!
Okito.ejectWithKey('secondCounter');
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

#### App Controller

It is the controller of app, you can wrap your widgets that you want to change on big updates like theme changes if the data
you wrote is not coming from a controller.

```dart
Rockito<AppController>(
  (app) => // yourWidget
)

```

# Tutorials

- [To Do App by Randall Morgan](https://www.youtube.com/watch?v=acsYwjldZG0&ab_channel=Monotoba)
- [Written To Do App by Randall Morgan](https://www.coderancher.us/2021/04/10/dart-flutter-state-management-with-okito/)

# Examples

- [Counter Example](https://github.com/ragokan/okito/blob/master/example/flutter_counter/lib/main.dart)
- [To Do Example](https://github.com/ragokan/to_do)

# How to contribute okito

- okito needs tests.
- okito needs more examples.
- okito needs a better readme file :D
- okito needs reputition, likes and users!
- okito needs test with Apple products, I tested on linux, android, web and Windows
