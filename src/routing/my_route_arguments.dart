// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This code is copyrighted - See LICENCE.txt
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

class MyRouteArguments {
  //
  //
  //

  final bool shouldAnimate;

  //
  //
  //

  MyRouteArguments({this.shouldAnimate = false});

  //
  //
  //

  factory MyRouteArguments.fromArguments(Object? arguments) {
    if (arguments is MyRouteArguments) return arguments;
    return MyRouteArguments();
  }

  //
  //
  //

  Map<String, String> toQueryParameters() {
    return {
      "should_animate": shouldAnimate.toString(),
    };
  }
}
