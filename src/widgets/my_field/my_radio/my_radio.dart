import '/all.dart';

@GenerateMakeups(
  parameters: {
    "selectedColor": "Color",
    "errorColor": "Color",
    "unselectedBorderColor": "Color",
    "disabledSelectedColor": "Color",
    "disabledBorderColor": "Color",
    "borderThickness": "double",
    "borderRadius": "BorderRadius",
    "innerBorderRadius": "BorderRadius",
    "shape": "BoxShape",
    "size": "double",
    "isChildrenAfter": "bool",
    "isChildrenBefore": "bool",
    "spacer": "SizedBox",
    "innerPadding": "EdgeInsets",
    "selectedIcon": "Icon?",
  },
)
abstract class MyRadio {}
