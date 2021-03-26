import 'modules/communication.dart';

class OkitoController {}

ControllerCommunication communication =
    ControllerCommunication<OkitoController>();

class First extends OkitoController {}

class Second extends OkitoController {}

void main(List<String> args) {
  communication.watch<Second, int>(print);

  communication.notify<First, String>('message');
  communication.notify<Second, int>(3);
}
