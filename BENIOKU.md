# okito

## Flutter kod kankan. Hepsi bir arada; state yönetimi, navigasyon yönetimi(dinamik yönlendirme), yerel depolama, dependency aşılama, yerelleştirme, en iyi kullanımlar ile hazırlanmış en iyi eklentilere de sahip bir kütüphane!

[![pub puanı](https://badges.bar/okito/pub%20points)](https://pub.dev/packages/okito/score)
[![beğeniler](https://badges.bar/okito/likes)](https://pub.dev/packages/okito/score)
[![popülerlik](https://badges.bar/okito/popularity)](https://pub.dev/packages/okito/score)
[![GitHub Repo yıldızları](https://img.shields.io/github/stars/ragokan/okito?label=github%20stars)](https://github.com/ragokan/okito)
[![pub versiyonu](https://img.shields.io/pub/v/okito)](https://pub.dev/packages/okito)
[![GitHub son commit](https://img.shields.io/github/last-commit/ragokan/okito)](https://github.com/ragokan/okito)

### [Buraya tıklayarak discord kanalımıza katılabilirsiniz, Türkçe kanalımız bulunmakta!](https://discord.gg/2pg7B73U8j)

&nbsp;

## _Alt kısım için not; birçok şeyi bilerek Türkçe'ye çevirmedim çünkü hem anlamı yok hem de mantığını kaybediyor._

&nbsp;

## Özellikler

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

## İçerikler

- [Taktikler](#tips)
  - [Daha Temiz Widgetler](#cleaner-widgets)
  - [State'i Güncelleme](#update-state)
  - [Uygulama Controller](#app-controller)
- [Tutoriallar](#tutorials)
- [Örnekler](#examples)
- [Okitoya katkı sağlama](#how-to-contribute-okito)

&nbsp;

# State Management

#### Controlleri Oluştur

Q: Çalışması için ne yapmalıyım?
A: Sadece normal bir sınıf oluştur, bu sınıf *OkitoController*i extendlesin, görüntüyü güncellemek için de _update()_ veya _setState((){})_ methodlarını kullanabilirsin.

Q: Peki bu metotlar görüntüyü nasıl güncelliyor?
A: Model, controller ve görüntü arasında 'MVC' yapısını uygulayan bir iletişim var. Siz bu metotları kullandığınız an görüntü(builder) direkt bundan haber alır ve güncellenir. Yani şema tam olarak;

Model -> Controller -> Model  
Görüntü(View) -> Controller -> Görüntü(View)  
Controller hepsinin temel kaynağı.

```dart
class SayaçController extends OkitoController {
  int sayı = 0;

  void arttır() => setState(() => sayı++);

  void azalt() {
    sayı--;
    update();
  }
}

SayaçController sayaçController = SayaçController();
```

Asenkron olarak güncellemeler için _setStateAsync_ fonksiyonunu da kullanabilirsiniz.

---

#### Controlleri Kullanma

```dart
// Bu kadar basit!
OkitoBuilder(
      controller: sayaçController,
      builder: () => Text('${sayaçController.sayı}'),
    );
```

---

#### Controller ile Görüntüyü Güncelleme

```dart
    main(){
        // Stateyi contexte ihtiyaç duymadan herhangi bir yerden değiştirebilirsin.
        sayaçController.arttır();
    }

    // Widget İçerisinde
    ElevatedButton(
                  onPressed: sayaçController.arttır,
                  child: const Text('Arttır'),
                )
    // Ya da
     ElevatedButton(
                  onPressed: () => sayaçController
                      .setState(() => sayaçController.sayı--),
                  child: const Text('Azalt'),
                )
```

---

#### Rockitos

Rockito, state managementi _dependency injection_ ile kullanmanın yoludur. Eğer onun ne olduğunu tam bilmiyorsanız bizim [Dependency Injection Rehberi](#dependency-injection)'mizi okumanızı öneririm..

```dart

Rockito<SayaçController>(
  (controller) => Text('${controller.sayı}')
);
// Çok basit, değil mi?
// _Rockito_ kullanmak için, ilk başta SayaçControlleri inject etmeliyiz.

Okito.inject(SayaçController);
```

```dart
// RockitoBuilder - Rockitonun daha fazla özellik ve buildere sahip hali.
  RockitoBuilder<SayaçController>(
    inject: SayaçController(), // İsteğe bağlı, isterseniz yukarıdaki gibi de *inject* edebilirsiniz.
    builder: (controller) => Text('${controller.sayı}'),
    // Burada diğer OkitoBuilder özelliklerini kullanabilirsin.
  );
```

---

#### Watch Controller

Watcher ile state değişimlerini widget dışında izleyebilirsiniz.

```dart
    OkitoWatcher(
    watch: sayaçController,
    onChange: (SayaçController controller) {
      print(controller.sayı);
    },
  );
  sayaçController.arttır();

  // OkitoWatcher bize izlemeyi durdurmamız için bir fonksiyon dönderir.

  final stopWatching = OkitoWatcher(/* kod buraya */);
  // *stopWatching* fonksiyonunu çağırdığımızda da izleme sona erer.
  stopWatching();
```

```dart
// Aynı işlemi Rockito ile de yapabilirsiniz.
RockitoWatcher<SayaçController>(
  (controller) => print(controller.sayı))
// Tabii başta *inject* etmeniz gerekiyor.
```

#### State Methods

State metotları Flutter *StatefulWidget*in özellikleri gibi çalışır.

```dart
class SayaçController extends OkitoController{
  int sayı = 0;

  /// OkitoBuilder yerleştiğinde çalışır.
  @override
  void initState() {
    sayı++;
  }
  /// OkitoBuilder yok olduğunda çalışır.
  @override
  void dispose() {
    sayı = 0;
  }
}
```

Ben kişisel olarak stateful widget kullanmak yerine metotları bu şekilde kullanırım.  
Example:

```dart
class EditProductController extends OkitoController {
  final priceFocusNode = FocusNode();

  void submitForm(){
    // Okito ile bildiğiniz gibi herhangi bir yerden contexte ihtiyaç duymadan push işlemi yapabilirsiniz.
    Okito.pushNamed('/productUpdatedSuccessfully/31')
  }

  @override
  void dispose() {
    // diğer focusNode [dispose] metotları.
    priceFocusNode.dispose();
  }
}
```

# İşlevler

### Contexte ihtiyaç duymadan navigasyon.

### İlk başta uygulamamıza Okito gücü sağlayalım.

```dart
// Sadece başına *Okito* yazmamız yeterli.

OkitoMaterialApp(/*  Buradaki kod [MaterialApp] kodu ile tamamen aynı */);

// Veya
OkitoCupertinoApp(/*  Buradaki kod [CupertinoApp] kodu ile tamamen aynı */);

// Veya
Material/CupertinoApp(
    navigatorKey: Okito.navigatorKey,
    navigatorObservers: [OkitoObserver()]);
```

## Sonrasında tüm Okito özelliklerine sahip olabilirsiniz.

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

  box.write('sayı', 0);

  final int sayı = box.read<int>('sayı');
  // Simple as this!

  print('Count is $sayı');
  // Rest of your code will be here.
}
```

Other Usages

```dart
  box.watchKey('sayı', () =>
    print('This function will be called whenever the sayı changes.');
  );

  box.watchAll(() =>
    print('This function will be called whenever the storage changes.');
  );

  box.removeKey('sayı'); // Removes the key

  box.readAllKeys(); // returns all keys in storage

  box.readAllValues(); // returns all values in storage

  box.readAll(); // returns all of the storage

  box.clearStorage(); // removes everything from the storage but storage will still exists.

  box.deleteStorage(); // removes the storage from file system completely, after this operation, OkitoStorage won't be able to write or read.
```

### Watch OkitoStorage With OkitoBuilder

```dart
// Check the example/flutter_okito_storage/lib/main.dart for more examples!

// It will run whenever key 'sayı' changes.
OkitoBuilder(
      controller: yourController,
      watchStorageKeys: ['sayı'],
      builder: () => Text('${box.read('sayı')}'),
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
class Sayaç(){
  sayı = 0;
}

// Inject it
Okito.inject(Sayaç());


// Use it anywhere!
Okito.use<Sayaç>();

// Asign it with type support!
final sayaç = Okito.use<Sayaç>();

// Update however you want
sayaç.sayı++;
// or
Okito.use<Sayaç>().sayı++;
```

Soo, lets say that your job is done with that class, why would we let it to use memory?

```dart
// Sayaç will be gone forever!
Okito.eject<Sayaç>();
```

#### For more details, check the tests or examples about it!

# Tips

#### Cleaner Widgets

```dart
// In your widgets folder or any other folder, declare builder.
OkitoBuilder SayaçBuilder({
  required Widget Function() builder,
}) =>
    OkitoBuilder(
      controller: sayaçController,
      builder: () => builder(),
    );

// Usage
SayaçBuilder(builder: () => Text('${sayaçController.sayı}'));
```

My Favorite Way

```dart
OkitoBuilder SayaçBuilder({
  required Widget Function(SayaçController state) builder,
}) =>
    OkitoBuilder(
      controller: sayaçController,
      builder: () => builder(sayaçController),
    );

// Usage
SayaçBuilder(builder: (state) => Text('${state.sayı}'));
```

---

#### Update State

```dart
class SayaçController extends OkitoController {
  int _sayı = 0;

  int get sayı => _sayı;

  set sayı(int sayı) {
    _sayı = sayı;
    // Now, whenever you change sayı like 'sayı++', it will update state.
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

- [Sayaç Example](https://github.com/ragokan/okito/blob/master/example/flutter_sayaç/lib/main.dart)
- [To Do Example](https://github.com/ragokan/to_do)

# How to contribute okito

- okito needs tests.
- okito needs more examples.
- okito needs a better readme file :D
- okito needs reputition, likes and users!
- okito needs test with Apple products, I tested on linux, android, web and Windows
