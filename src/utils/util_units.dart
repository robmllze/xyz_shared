// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class Units {
  //
  //
  //

  late final double factor;

  //
  //
  //

  Units([this.factor = 1.0]) {
    this._recalculate();
  }

  //
  //
  //

  Units.determineFrom({
    required double scaleDivisor,
    required Size scaleSize,
  }) {
    this.factor =
        // Convert scale divisor to a scale factor...
        (1.0 / (scaleDivisor * 1000.0)) *
            // ...multiplied by the average of the screen width and height.
            0.5 *
            (scaleSize.width + scaleSize.height);
    this._recalculate();
  }

  //
  //
  //

  Units.scale(Units other, double scale) {
    this.factor = other.factor * scale;
    this._recalculate();
  }

  //
  //
  //

  late double _$1,
      _$2,
      _$4,
      _$8,
      _$12,
      _$16,
      _$20,
      _$24,
      _$28,
      _$32,
      _$36,
      _$40,
      _$44,
      _$48,
      _$52,
      _$56,
      _$60,
      _$64,
      _$68,
      _$72,
      _$76,
      _$80,
      _$84,
      _$88,
      _$92,
      _$96,
      _$100,
      _$104,
      _$108,
      _$112,
      _$116,
      _$120,
      _$124,
      _$128,
      _$132,
      _$136,
      _$140,
      _$144,
      _$148,
      _$152,
      _$156,
      _$160,
      _$164,
      _$168,
      _$172,
      _$176,
      _$180,
      _$184,
      _$188,
      _$192,
      _$196,
      _$200;

  //
  //
  //

  void _recalculate() {
    this._$1 = 1.0 * this.factor;
    this._$2 = 2.0 * this.factor;
    this._$4 = 4.0 * this.factor;
    this._$8 = 8.0 * this.factor;
    this._$12 = 12.0 * this.factor;
    this._$16 = 16.0 * this.factor;
    this._$20 = 20.0 * this.factor;
    this._$24 = 24.0 * this.factor;
    this._$28 = 28.0 * this.factor;
    this._$32 = 32.0 * this.factor;
    this._$36 = 36.0 * this.factor;
    this._$40 = 40.0 * this.factor;
    this._$44 = 44.0 * this.factor;
    this._$48 = 48.0 * this.factor;
    this._$52 = 52.0 * this.factor;
    this._$56 = 56.0 * this.factor;
    this._$60 = 60.0 * this.factor;
    this._$64 = 64.0 * this.factor;
    this._$68 = 68.0 * this.factor;
    this._$72 = 72.0 * this.factor;
    this._$76 = 76.0 * this.factor;
    this._$80 = 80.0 * this.factor;
    this._$84 = 84.0 * this.factor;
    this._$88 = 88.0 * this.factor;
    this._$92 = 92.0 * this.factor;
    this._$96 = 96.0 * this.factor;
    this._$100 = 100.0 * this.factor;
    this._$104 = 104.0 * this.factor;
    this._$108 = 108.0 * this.factor;
    this._$112 = 112.0 * this.factor;
    this._$116 = 116.0 * this.factor;
    this._$120 = 120.0 * this.factor;
    this._$124 = 124.0 * this.factor;
    this._$128 = 128.0 * this.factor;
    this._$132 = 132.0 * this.factor;
    this._$136 = 136.0 * this.factor;
    this._$140 = 140.0 * this.factor;
    this._$144 = 144.0 * this.factor;
    this._$148 = 148.0 * this.factor;
    this._$152 = 152.0 * this.factor;
    this._$156 = 156.0 * this.factor;
    this._$160 = 160.0 * this.factor;
    this._$164 = 164.0 * this.factor;
    this._$168 = 168.0 * this.factor;
    this._$172 = 172.0 * this.factor;
    this._$176 = 176.0 * this.factor;
    this._$180 = 180.0 * this.factor;
    this._$184 = 184.0 * this.factor;
    this._$188 = 188.0 * this.factor;
    this._$192 = 192.0 * this.factor;
    this._$196 = 196.0 * this.factor;
    this._$200 = 200.0 * this.factor;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension DoubleDotScaled on double {
  double get scaled {
    final unit = G.pUnits.value?.factor;
    return this * (unit ?? 1.0);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class Unit {
  final double _value;
  const Unit(this._value);
  static const zero = Unit(0.0);
  double get auto => DoubleDotScaled(this._value).scaled;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

double get $1 => G.units._$1;
double get $2 => G.units._$2;
double get $4 => G.units._$4;
double get $8 => G.units._$8;
double get $12 => G.units._$12;
double get $16 => G.units._$16;
double get $20 => G.units._$20;
double get $24 => G.units._$24;
double get $28 => G.units._$28;
double get $32 => G.units._$32;
double get $36 => G.units._$36;
double get $40 => G.units._$40;
double get $44 => G.units._$44;
double get $48 => G.units._$48;
double get $52 => G.units._$52;
double get $56 => G.units._$56;
double get $60 => G.units._$60;
double get $64 => G.units._$64;
double get $68 => G.units._$68;
double get $72 => G.units._$72;
double get $76 => G.units._$76;
double get $80 => G.units._$80;
double get $84 => G.units._$84;
double get $88 => G.units._$88;
double get $92 => G.units._$92;
double get $96 => G.units._$96;
double get $100 => G.units._$100;
double get $104 => G.units._$104;
double get $108 => G.units._$108;
double get $112 => G.units._$112;
double get $116 => G.units._$116;
double get $120 => G.units._$120;
double get $124 => G.units._$124;
double get $128 => G.units._$128;
double get $132 => G.units._$132;
double get $136 => G.units._$136;
double get $140 => G.units._$140;
double get $144 => G.units._$144;
double get $148 => G.units._$148;
double get $152 => G.units._$152;
double get $156 => G.units._$156;
double get $160 => G.units._$160;
double get $164 => G.units._$164;
double get $168 => G.units._$168;
double get $172 => G.units._$172;
double get $176 => G.units._$176;
double get $180 => G.units._$180;
double get $184 => G.units._$184;
double get $188 => G.units._$188;
double get $192 => G.units._$192;
double get $196 => G.units._$196;
double get $200 => G.units._$200;
