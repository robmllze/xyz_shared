// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Used to refresh the web app.
const XYZ_APP_URL = "https://xyz.app/";

/// Used to read and write local data relevant to your app's ID.
const XYZ_APP_ID = "xyz_app";

/// Used to read and write local data relevant to your app's version.
const XYZ_APP_VERSION = "0";

// Used to generate a deterministic password to encrypt and decrypt local data
// relevant to your app's version.
String xyzDeterministicPassword(int seed) {
  // The objective is to make it more challenging to reverse-engineer hard-coded
  // passwords. To accomplish this, the generateDeterministicPassword function
  // requires a list as input to create a password in a deterministic manner.
  // It is strongly advised to utilize a list of strings that already exist in
  // main.dart.js. By doing so, it would not be apparent which list was employed
  // to generate the password when examining main.dart.js. The list provided
  // below is a suitable illustration.
  const GARBAGE = [
    // This exact list alread appears main.dart.js. Do not add or remove elements.
    "pointerdown",
    "pointermove",
    "pointerleave",
    "pointerup",
    "pointercancel",
    "touchstart",
    "touchend",
    "touchmove",
    "touchcancel",
    "mousedown",
    "mousemove",
    "mouseleave",
    "mouseup",
    "keyup",
    "keydown"
  ];
  return generateDeterministicPassword(GARBAGE, seed);
}
