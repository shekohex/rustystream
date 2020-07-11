import 'package:rustystream/events.dart';

Future main(List<String> arguments) async {
  final events = Events(n: 100);
  await events.stream.takeWhile((e) => e != null).forEach(print);
  events.dispose();
}
