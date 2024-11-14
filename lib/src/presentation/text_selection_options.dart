import 'package:flutter/material.dart';

class TextSelectionOptions {
  ToolbarOptions toolbarOptions;
  bool showCursor;

  TextSelectionOptions({
    required this.toolbarOptions,
    required this.showCursor,
  });

  TextSelectionOptions.copyable()
      : toolbarOptions = const ToolbarOptions(
          copy: true,
          cut: true,
          selectAll: true,
        ),
        showCursor = true;
}
