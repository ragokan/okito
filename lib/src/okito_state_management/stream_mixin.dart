import '../../okito.dart';

/// It is going to be called whenever we get new data from [Stream].
typedef OnData<T> = void Function(T data);

/// It is going to be called whenever we get new data from querys [Stream].
typedef OnFirestoreQueryData = void Function(List<Map<String, dynamic>> data);

/// It is going to be called whenever we get new data from documents [Stream].
typedef OnFirestoreDocumentData = void Function(Map<String, dynamic> data);

///
mixin OkitoStreamMixin {
  /// [update] method of [OkitoController].
  void update();

  /// [initStream] function is to init your streams. It will listen your
  /// [Stream] and whenever it gets a new data, the [onData] function
  /// will be called.
  ///
  /// Example;
  /// ```dart
  /// class CounterController extends OkitoController{
  ///   int count = 0;
  ///
  ///   @override  // Alternatively, you can use the constructor.
  ///   void onInject(){
  ///      initStream<int>(stream: yourIntStream, onData(data) {
  ///         count = data; // You don't need to do anything or update.
  ///     });
  ///   }
  /// }
  /// ```
  void initStream<T>({required Stream<T> stream, required OnData<T> onData}) {
    stream.listen((data) {
      if (data == null) return;
      onData(data);
      update();
    });
  }

  /// [initFirestoreQueryStream] function is to init your streams. It will
  /// listen your stream of  and whenever it gets a new data,
  ///  the [onData] function will be called.
  ///
  /// Example;
  /// ```dart
  /// class PeopleController extends OkitoController{
  ///   List<Person> people = [];
  ///
  ///   @override  // Alternatively, you can use the constructor.
  ///   void onInject(){
  ///      initFirestoreQueryStream(querySnapshot: querySnapshot, onData(data) {
  ///         // This data is a list of documents(it is a map) of your collection.
  ///         people = data;
  ///     });
  ///   }
  /// }
  /// ```
  void initFirestoreQueryStream(
      {required Stream querySnapshot, required OnFirestoreQueryData onData}) {
    querySnapshot.listen((data) {
      if (data == null) return;
      final _query = <Map<String, dynamic>>[];
      for (var i = 0; i < data.docs.length; i++) {
        _query.add({data.docs[0].id: data.docs[i].data()});
      }
      onData(_query);
      update();
    });
  }

  /// [initFirestoreDocumentStream] function is to init your streams. It will
  /// listen your stream of  and whenever it gets a new data,
  ///  the [onData] function will be called.
  ///
  /// Example;
  /// ```dart
  /// class PersonController extends OkitoController{
  ///   Person person = Person();
  ///
  ///   @override  // Alternatively, you can use the constructor.
  ///   void onInject(){
  ///      initFirestoreDocumentStream(
  ///         documentSnapshot: documentSnapshot,
  ///         onData(data) {
  ///           // This data is your document as map.
  ///           person = Person.fromMap(data);
  ///      });
  ///    }
  /// }
  /// ```
  void initFirestoreDocumentStream(
      {required Stream documentSnapshot,
      required OnFirestoreDocumentData onData}) {
    documentSnapshot.listen((data) {
      if (data == null) return;
      onData(data.data() ?? {});
      update();
    });
  }
}
