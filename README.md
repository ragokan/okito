# okito
## The simplest state management solution ever, at least I think so. It depends on nothing, works really fast with minimum code usage.
### With okito, you don't need to wrap your material app for state, you don't need any complex libraries and most importantly your don't need context to have a state or update state.

#### What will be included in future?
##### I liked some libraries that help you to do things without context like routing or snackbar etc. I will try to implement them, probably will be done before April ends. 

&nbsp;

## Guide
- [State Management](#state-management)
    - [Create Controller](#create-controller)
    - [Watch Controller](#watch-controller)
    - [Update Controller](#update-controller)
- [Tips](#tips)
    - [Cleaner Widgets](#cleaner-widgets)
    - [Update State](#update-state)
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

# How to contribute okito
- okito needs tests.
- okito needs a better readme file.
- okito needs more examples.
