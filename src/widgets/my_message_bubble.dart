// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyMessageBubble extends StatelessWidget {
  //
  //
  //

  final Color color;
  final String message;
  late final String? _mdMessage;
  final DateTime? dateSent;
  final DateTime? dateRead;
  final DateTime? dateDelivered;
  final bool softWrap;
  final TextStyle? textStyle;

  //
  //
  //

  late final _markdownStyleSheet = MarkdownStyleSheet(
    a: this.textStyle,
    p: this.textStyle,
    code: this.textStyle,
    // code: GoogleFonts.robotoMono(
    //   color: this.textStyle?.color,
    //   backgroundColor: Colors.black.withOpacity(0.25),
    //   fontSize: this.textStyle?.fontSize,
    // ),
    // h1: this.textStyle?.wUnderlined,
    // h2: this.textStyle?.wUnderlined,
    // h3: this.textStyle?.wUnderlined,
    // h4: this.textStyle?.wUnderlined,
    // h5: this.textStyle?.wUnderlined,
    // h6: this.textStyle?.wUnderlined,
    // em: this.textStyle?.wItalic,
    // strong: this.textStyle?.wBold,
    // del: this.textStyle?.wLineThough,
    // blockquote: this.textStyle?.wItalic,
    // img: this.textStyle?.wItalic,
    checkbox: this.textStyle,
    listBullet: this.textStyle,
    tableBody: this.textStyle,
    tableHead: this.textStyle,
  );

  //
  //
  //

  static String? mdMessageStrip(String message) {
    final matches = RegExp(r"^(<md>)(.+)(</md>)$").allMatches(message);
    if (matches.isNotEmpty) return matches.first.group(2);
    return null;
  }

  //
  //
  //

  MyMessageBubble({
    Key? key,
    required this.color,
    required this.message,
    this.dateSent,
    this.dateRead,
    this.dateDelivered,
    this.softWrap = true,
    this.textStyle,
  }) : super(key: key) {
    this._mdMessage = mdMessageStrip(this.message);
  }

  //
  //
  //

  @override
  Widget build(_) {
    if (message.isEmpty) return const SizedBox();
    return Container(
      constraints: BoxConstraints(minWidth: $48),
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.circular($8),
      ),
      child: Padding(
        padding: EdgeInsets.all($8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (this._mdMessage != null)
              MarkdownBody(
                data: this._mdMessage!,
                softLineBreak: true,
                shrinkWrap: true,
                styleSheet: this._markdownStyleSheet,
              )
            else
              Text(
                this.message,
                style: textStyle,
              ),
            SizedBox(height: $4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // if (dateSent != null)
                //   Text(
                //     DateFormat.jm(G.serviceLocale.code).format(dateSent!),
                //     style: textStyle?.copyWith(
                //       fontSize: $8,
                //       color: textStyle?.color!.withOpacity(0.75),
                //     ),
                //   ),
                if (dateRead != null) ...[
                  SizedBox(width: $2),
                  Icon(
                    Icons.done_all,
                    color: textStyle?.color ?? G.theme.palette.background,
                    size: $12,
                  ),
                ] else if (dateDelivered != null) ...[
                  SizedBox(width: $2),
                  Icon(
                    Icons.done,
                    color: textStyle?.color ?? G.theme.palette.background,
                    size: $12,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
