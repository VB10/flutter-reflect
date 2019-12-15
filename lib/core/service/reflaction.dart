import 'package:reflectable/reflectable.dart';

// Annotate with this class to enable reflection.
class Reflector extends Reflectable {
  const Reflector()
      : super(
          invokingCapability,
        );
}

// newInstanceCapability,
//         invokingCapability,
//         reflectedTypeCapability,
//         typingCapability,
//         declarationsCapability,

const reflector = const Reflector();
