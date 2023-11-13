//  Copyright © 2021 Bottle Rocket Studios. All rights reserved.

// Modeled after iOS-UtiliKit ObfuscatedKey.
// https://github.com/BottleRocketStudios/iOS-UtiliKit

// ignore_for_file: prefer_interpolation_to_compose_strings

// One should never commit keys directly into one's source.
// This is an unsafe practice. When it is impossible to avoid doing so, the key
// should at least be obfuscated.
// By using the ObfuscatedKey struct, you can build a human-readable key that
// will not appear by running "strings" against your compiled code, and will
// not appear as a string within your source code.
class ObfuscatedKey {
  const ObfuscatedKey({this.value = ''});

  final String value;
}

extension Obfuscators on ObfuscatedKey {
  ObfuscatedKey get A => ObfuscatedKey(value: value + 'A');
  ObfuscatedKey get B => ObfuscatedKey(value: value + 'B');
  ObfuscatedKey get C => ObfuscatedKey(value: value + 'C');
  ObfuscatedKey get D => ObfuscatedKey(value: value + 'D');
  ObfuscatedKey get E => ObfuscatedKey(value: value + 'E');
  ObfuscatedKey get F => ObfuscatedKey(value: value + 'F');
  ObfuscatedKey get G => ObfuscatedKey(value: value + 'G');
  ObfuscatedKey get H => ObfuscatedKey(value: value + 'H');
  ObfuscatedKey get I => ObfuscatedKey(value: value + 'I');
  ObfuscatedKey get J => ObfuscatedKey(value: value + 'J');
  ObfuscatedKey get K => ObfuscatedKey(value: value + 'K');
  ObfuscatedKey get L => ObfuscatedKey(value: value + 'L');
  ObfuscatedKey get M => ObfuscatedKey(value: value + 'M');
  ObfuscatedKey get N => ObfuscatedKey(value: value + 'N');
  ObfuscatedKey get O => ObfuscatedKey(value: value + 'O');
  ObfuscatedKey get P => ObfuscatedKey(value: value + 'P');
  ObfuscatedKey get Q => ObfuscatedKey(value: value + 'Q');
  ObfuscatedKey get R => ObfuscatedKey(value: value + 'R');
  ObfuscatedKey get S => ObfuscatedKey(value: value + 'S');
  ObfuscatedKey get T => ObfuscatedKey(value: value + 'T');
  ObfuscatedKey get U => ObfuscatedKey(value: value + 'U');
  ObfuscatedKey get V => ObfuscatedKey(value: value + 'V');
  ObfuscatedKey get W => ObfuscatedKey(value: value + 'W');
  ObfuscatedKey get X => ObfuscatedKey(value: value + 'X');
  ObfuscatedKey get Y => ObfuscatedKey(value: value + 'Y');
  ObfuscatedKey get Z => ObfuscatedKey(value: value + 'Z');
  //
  ObfuscatedKey get a => ObfuscatedKey(value: value + 'a');
  ObfuscatedKey get b => ObfuscatedKey(value: value + 'b');
  ObfuscatedKey get c => ObfuscatedKey(value: value + 'c');
  ObfuscatedKey get d => ObfuscatedKey(value: value + 'd');
  ObfuscatedKey get e => ObfuscatedKey(value: value + 'e');
  ObfuscatedKey get f => ObfuscatedKey(value: value + 'f');
  ObfuscatedKey get g => ObfuscatedKey(value: value + 'g');
  ObfuscatedKey get h => ObfuscatedKey(value: value + 'h');
  ObfuscatedKey get i => ObfuscatedKey(value: value + 'i');
  ObfuscatedKey get j => ObfuscatedKey(value: value + 'j');
  ObfuscatedKey get k => ObfuscatedKey(value: value + 'k');
  ObfuscatedKey get l => ObfuscatedKey(value: value + 'l');
  ObfuscatedKey get m => ObfuscatedKey(value: value + 'm');
  ObfuscatedKey get n => ObfuscatedKey(value: value + 'n');
  ObfuscatedKey get o => ObfuscatedKey(value: value + 'o');
  ObfuscatedKey get p => ObfuscatedKey(value: value + 'p');
  ObfuscatedKey get q => ObfuscatedKey(value: value + 'q');
  ObfuscatedKey get r => ObfuscatedKey(value: value + 'r');
  ObfuscatedKey get s => ObfuscatedKey(value: value + 's');
  ObfuscatedKey get t => ObfuscatedKey(value: value + 't');
  ObfuscatedKey get u => ObfuscatedKey(value: value + 'u');
  ObfuscatedKey get v => ObfuscatedKey(value: value + 'v');
  ObfuscatedKey get w => ObfuscatedKey(value: value + 'w');
  ObfuscatedKey get x => ObfuscatedKey(value: value + 'x');
  ObfuscatedKey get y => ObfuscatedKey(value: value + 'y');
  ObfuscatedKey get z => ObfuscatedKey(value: value + 'z');
  //
  ObfuscatedKey get n0 => ObfuscatedKey(value: value + '0');
  ObfuscatedKey get n1 => ObfuscatedKey(value: value + '1');
  ObfuscatedKey get n2 => ObfuscatedKey(value: value + '2');
  ObfuscatedKey get n3 => ObfuscatedKey(value: value + '3');
  ObfuscatedKey get n4 => ObfuscatedKey(value: value + '4');
  ObfuscatedKey get n5 => ObfuscatedKey(value: value + '5');
  ObfuscatedKey get n6 => ObfuscatedKey(value: value + '6');
  ObfuscatedKey get n7 => ObfuscatedKey(value: value + '7');
  ObfuscatedKey get n8 => ObfuscatedKey(value: value + '8');
  ObfuscatedKey get n9 => ObfuscatedKey(value: value + '9');
  //
  ObfuscatedKey get dot => ObfuscatedKey(value: value + '.');
  ObfuscatedKey get dash => ObfuscatedKey(value: value + '-');
  ObfuscatedKey get underscore => ObfuscatedKey(value: value + '_');
  ObfuscatedKey get colon => ObfuscatedKey(value: value + ':');
  ObfuscatedKey get equals => ObfuscatedKey(value: value + '=');
}
