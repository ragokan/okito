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

_Tüm Okito kullanımları navigator kullanımı ile aynıdır, sadece daha az kod yazmanız gerekir :),_

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
Okito.showToast(); // Widget oluşturmaya ihtiyaç duymadan snackbar gösterir.
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

### Dinamik url için kullanım

```
/posts/:id
/posts/23
```

Bu ':id' dinamik bir değişken, değil mi?
_Okito_ ile bu değişkenlere rahatça erişebilirsiniz!

```dart
OkitoMaterialApp(
      routes: {
        '/': (ctx) => FirstPage(),
        '/second/:id': (ctx) => SecondPage(),
      }
);
```

Şimdi, ne zaman bunu yaparsenız;

```dart
ElevatedButton(
  onPressed: () => Okito.pushNamed(
    /// You can add any kind of arguments
    '/second/33?name=Rago&postId=123&isMaterial=true',
    arguments: 'This is an extra argument'),
    child: const Text('Go to second page'),
  )
```

Sizi 2. sayfaya [id] parametresi de [33] olarak gönderir.

Dahası, bu argümanlara kolaylıkla erişebilirsiniz;

```dart
print(Okito.arguments);
// sonuç
{'id' : '33', 'name' : 'Rago', 'postId' : 123, 'isMaterial' : true, 'arguments': 'This is an extra argument'};
// Evet, ekstra argüment de hemen buraya geliyor.
```

Canlı bir örnek için _example/flutter_dynamic_routing/lib/main.dart_ dosyasını ziyaret edin.

## Theme Management

```dart
// Başlangıç olarak bu bize uygulamanın ana controllerini veriyor.
Okito.app; /* or */ Okito.use<AppController>();

// Sonrasında da tüm kullanımlara erişebiliyorsunuz.

Okito.app.setThemeData();
Okito.app.setThemeMode();
Okito.app.setCupertinoThemeData();

Okito.app.locale;
Okito.app.setLocale();
```

# Local Storage

### _OkitoStorage_ ile yerel depolamaya veri kaydedebilirsiniz.

### Kullanımı ve işlemleri SharedPereferences gibi asenkron değil, GetStorage gibi senkrondur.

#### _OkitoStorage_ inanılmaz bir şekilde hızlıdır çünkü okuma işlemleri için hafızayı kullanır!

```dart
// Web dışı tüm platformlarda init etmek için 'await' kullanmanız gerekiyor, sonrasında tabii hiç gerekmiyor.

void main() async{
  // Sadece 'init' fonksyiyonu asenkron olarak çalışıyor.
  await OkitoStorage.init();


  // Kullanım
  final box = OkitoStorage; // Kolay referans için

  box.write('sayı', 0);

  final int sayı = box.read<int>('sayı');
  // Bu kadar basit!

  print('Count is $sayı');
}
```

Diğer Kullanımlar

```dart
  box.watchKey('sayı', () =>
    print('Bu fonksiyon sayı ne zaman değişirse çalışır.');
  );

  box.watchAll(() =>
    print('Bu fonksiyon storage ne zaman değişirse çalışır.');
  );

  box.removeKey('sayı'); // Anahtarı yok eder

  box.readAllKeys(); // Depolamadaki tüm anahtarları verir

  box.readAllValues(); // Depolamadaki tüm değerleri verir

  box.readAll(); // Depolamadaki tüm veriyi verir

  box.clearStorage(); // Depodaki tüm anahtar ve değerleri siler

  box.deleteStorage(); // Depoyu diskten tamamen yok eder.
```

### Watch OkitoStorage With OkitoBuilder

```dart

// Ne zaman sayı değişirse bu builder tekrardan çalışır
OkitoBuilder(
      controller: yourController,
      watchStorageKeys: ['sayı'],
      builder: () => Text('${box.read('sayı')}'),
    );
```

# Localization

#### Okito ile uygulamanızı lokalize edebilirsiniz.

```dart
// Kullanımı da çok basit
// Başta çevirilerinizi bu şekilde belirtiyorsunuz.
const translations = {
  'en': {
    'hello': 'Hello from Okito!',
  },
  'tr': {
    'hello': "Okito'dan selamlar!",
  },
};
```

```dart
// Sonrasında da uygulamaya veriyorsunuz
OkitoMaterialApp /* or OkitoCupertinoApp */(
  translations: translations,
  /* Hiçbir değişime uğramadan kodunuzun geri kalanı */);
```

```dart
// Kullanımı mı ? O çok daha basit
Text('hello'.loc); // Bu dil Türkçe iken "Okito'dan Selamlar" yazısı verecek.

// Hadi dili değiştirip tekrar deneyelim
Okito.app.setLocale(Locale('en','US'));
// Şu anda da 'Hello from Okito!' diyor, çünkü 'translations' verisinde o şekilde belirttik.
```

# Extensions

```dart
// Context Extensionları
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

### Dependency injection ile değişkenleri uygulamanın her yerinde kullanabilirsiniz ve _Okito_ ile bunu yapmak çok basit.

```dart
// Örnek değişken;
class Sayaç(){
  sayı = 0;
}

// Enjekte edelim
Okito.inject(Sayaç());


// Herhangi bir yerde kullanalım
Okito.use<Sayaç>();

// Tip desteği ile de kullanabilirsiniz
final sayaç = Okito.use<Sayaç>();

// İstediğiniz şekilde kullanın! Örneğin;
sayaç.sayı++;
// veya
Okito.use<Sayaç>().sayı++;
```

Son olarak, diyelim ki değişken ile işiniz bitti, neden hafızada yer kaplasın ki?

```dart
// Sayaç sonsuza dek gitmiş olacak!
Okito.eject<Sayaç>();
```

#### Daha fazla bilgi için testleri ve örnekleri kontrol edebilirsiniz!
