// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

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
    this.photoUrl,
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
    final photoUrl = this.widget.photoUrl;
    this._photo = photoUrl != null ? G.serviceAsset.asset(photoUrl) : null;
    if (this._photo == null) {
      () async {
        final uri = photoUrl != null ? Uri.tryParse(photoUrl) : null;
        final canLaunchUrl = (uri == null ? false : await url_launcher.canLaunchUrl(uri));
        if (canLaunchUrl) {
          await G.serviceAsset.preloadNetworkImages([ImageBuilder.fill(photoUrl!)]);
          final temp = G.serviceAsset.asset(photoUrl);
          if (temp is Widget) {
            this.setState(() {
              this._photo = MyAnimatedFade(
                duration: const Duration(milliseconds: 3000),
                layer1: this.widget.named,
                layer2: temp,
              );
            });
          }
          return;
        }
        this.setState(() {
          this._photo = this.widget.named;
        });
      }();
    }
    super.initState();
  }

  //
  //
  //

  @override
  Widget build(_) {
    final makeup = this.widget.named.makeup ?? makeupAvatarNamedDefault();
    return GestureDetector(
      onTap: this.widget.named.onTap,
      behavior: HitTestBehavior.opaque,
      child: MyCircle(
        diameter: makeup.diameter,
        child: this._photo is Widget ? this._photo! : this.widget.named,
      ),
    );
  }
}
