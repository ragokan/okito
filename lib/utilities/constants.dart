/// It is the reqular null exception that I throw in routing if the
/// developer didn't use one of below examples.
const String nullException = '''
      If you want to use [context] in your app just like this, you have to
      use one of these; 
      1) [OkitoMaterialApp] instead of MaterialApp,
      2) [OkitoCupertinoApp] instead of CupertinoApp,
      3) Add these to your Material/Cupertino App;
        - navigatorKey: Okito.navigatorKey,
        - navigatorObservers: [OkitoObserver()].
        
      If you did and still got an error, please create a github issue.
    ''';

/// It is the exception that if the develop didn't provide a controller.
const String dynamicInjectedException = '''
      You should provide a controller that is already 'injected'
      to the storage. For example;
      Okito.inject(CounterController());

      Rockito<CounterCountroller>((controller) => /* Code Here */);
    ''';
