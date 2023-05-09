// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyAvatar extends StatefulWidget {
  //
  //
  //

  final String? photoUrl;
  final MyAvatarNamed named;

  //
  //
  //

  const MyAvatar({
    Key? key,
    required this.photoUrl,
    required this.named,
  }) : super(key: key);

  //
  //
  //

  @override
  State<MyAvatar> createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends State<MyAvatar> {
  //
  //
  //

  late Widget? _photo;

  //
  //
  //

  @override
  void initState() {
    final url = this.widget.photoUrl;
    this._photo = url != null ? G.serviceAsset.asset(url) : null;
    if (this._photo == null && url != null) {
      G.serviceAsset.preloadNetworkImages([
        ImageBuilder.fill(url),
      ]).then((_) async {
        this.setState(() {
          this._photo = MyAnimatedFade(
            duration: const Duration(milliseconds: 3000),
            layer1: this.widget.named,
            layer2: MyCircle(
              diameter: this.widget.named.makeup?.diameter,
              child: G.serviceAsset.asset(url),
            ),
          );
        });
      });
    }
    super.initState();
  }

  //
  //
  //

  @override
  Widget build(_) {
    return this._photo != null
        ? GestureDetector(
            onTap: this.widget.named.onTap,
            behavior: HitTestBehavior.opaque,
            child: MyCircle(
              diameter: this.widget.named.makeup?.diameter,
              child: this._photo!,
            ),
          )
        : this.widget.named;
  }
}
