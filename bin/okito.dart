import 'modules/communication.dart';

class OkitoController {}

ControllerCommunication communication =
    ControllerCommunication<OkitoController>();

class First extends OkitoController {}

class Second extends OkitoController {}

void main(List<String> args) {
  communication.watch<First>(print);

  communication.notify<First>('message');
  communication.notify<Second>(3);
}
