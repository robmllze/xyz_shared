// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@GenerateMakeups(
  parameters: {
    "color": "Color",
    "diameter": "double",
    "textStyle": "TextStyle",
  },
)
class MyAvatarNamed extends StatelessWidget {
  //
  //
  //

  final MakeupAvatarNamed? makeup;
  final String? name;
  final bool usePersonalColor;
  final void Function()? onTap;

  //
  //
  //

  const MyAvatarNamed({
    Key? key,
    this.makeup,
    this.name,
    this.usePersonalColor = true,
    this.onTap,
  }) : super(key: key);

  //
  //
  //

  @override
  Widget build(_) {
    final makeup = this.makeup ?? G.theme.avatarNamedDefault();
    return GestureDetector(
      onTap: this.onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        width: makeup.diameter,
        height: makeup.diameter,
        decoration: BoxDecoration(
          color: this.usePersonalColor ? generateAvatarColorFromName(name ?? "??") : makeup.color,
          shape: BoxShape.circle,
        ),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Text(
            _nameToNameCode(this.name),
            style: makeup.textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String _nameToNameCode(String? name) {
  final trimmed = name
      // Filter out all characters not letters or spaces.
      ?.replaceAll(RegExp("[^a-zA-Z ]"), "")
      // Replace all long spaces with single spaces.
      .replaceAll(RegExp(r" {2,}"), " ")
      // Trim left and right.
      .trim();

  // If null or empty.
  if (trimmed == null || trimmed.isEmpty) return "??";

  // Separate words.
  final words = trimmed.split(" ");

  // At this point we know there must be at least one word with one character.
  if (words.length == 1) {
    // If the word is only one character.
    if (words[0].length == 1) return words[0][0].toUpperCase();
    // If the word is more than one character.
    return "${words[0][0]}${words[0][1]}".toUpperCase();
  }

  // At this point we know there must be at least two words.
  return "${words[0][0]}${words[1][0]}".toUpperCase();
}
