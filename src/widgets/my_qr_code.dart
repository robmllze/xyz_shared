// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKinect
//
// Copyright Ⓒ 2023-2025, N Sanchez Medical Research Corporation
// See LICENSE.txt for more information
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyQrCode extends StatefulWidget {
  //
  //
  //

  final String email;
  final Uri url;

  //
  //
  //

  const MyQrCode({
    Key? key,
    required this.email,
    required this.url,
  }) : super(key: key);
  //
  //
  //

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends State<MyQrCode> {
  //
  //
  //

  final _globalKey = GlobalKey<_State>();

  //
  //
  //

  Future<Uint8List?> _bytes() async {
    final boundary = this._globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary?.toImage();
    final byteData = await image?.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  //
  //
  //

  Future<void> _download(String name) async {
    final pngBytes = await _bytes();
    if (pngBytes != null) {
      webDownloadBytes(pngBytes, name);
    }
  }

  //
  //
  //

  @override
  Widget build(_) {
    return Column(
      children: [
        RepaintBoundary(
          key: this._globalKey,
          child: GestureDetector(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(10.0.scaled),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    QrImage(
                      padding: EdgeInsets.zero,
                      data: this.widget.url.toString(),
                      version: QrVersions.auto,
                    ),
                    wHeight8(),
                    Text(
                      "${"name-app".tr()} / ${this.widget.email}",
                      style: G.theme.textStyles.p1,
                    ),
                  ],
                ),
              ),
            ),
            onTap: () async {
              try {
                await url_launcher.launchUrl(this.widget.url);
              } catch (_) {}
            },
          ),
        ),
        wHeight16(),
        MyButton(
          label: "DOWNLOAD QR CODE",
          makeup: G.theme.buttonPrimaryM,
          onTap: () => this._download("sticker.png"),
        ),
      ],
    );
  }
}
