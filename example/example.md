# Usage

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

#### Watch Multiple Controllers?, Of course!
```dart
OkitoBuilder(
      controller: counterController,
      otherControllers: [ageController /* ,  ...otherControllers  */],
      builder: () => Text('${counterController.count}'),
    );
```

