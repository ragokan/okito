# okito
## The simplest state management solution ever, at least I think so. It depends on nothing, works really fast with minimum code usage.
### With okito, you don't need to wrap your material app for state, you don't need any complex libraries and most importantly your don't need context to have a state or update state.



## State Management Usage

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


#### Watch Controller
```dart
// That simple!
OkitoBuilder(
      controller: counterController,
      builder: () => Text('${counterController.count}'),
    );
```

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



#### How to contribute okito
- okito needs tests.
- okito needs a better readme file.
- okito needs more examples.