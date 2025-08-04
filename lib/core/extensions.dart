// -------- screen width extension for context -----//

import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double width() => MediaQuery.sizeOf(this).width;
  double height() => MediaQuery.sizeOf(this).height;
  double viewInsects() => MediaQuery.viewInsetsOf(this).bottom;
}

extension StringCleaner on String {
  String cleanGeminiJson() {
    return replaceAll(RegExp(r'```json|```'), '').trim();
  }
}
