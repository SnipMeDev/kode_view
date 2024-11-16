import 'package:flutter/material.dart';

class TextSelectionOptions {
  final bool? copy;
  final bool? selectAll;
  final bool? share;

  TextSelectionOptions({this.copy, this.selectAll, this.share});

  Widget toolbarOptions(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return AdaptiveTextSelectionToolbar.editable(
      clipboardStatus: ClipboardStatus.pasteable,
      onCopy: _getAction(
        copy,
        () => editableTextState.copySelection(SelectionChangedCause.tap),
      ),
      onCut: null,
      onPaste: null,
      onSelectAll: _getAction(
        selectAll,
        () => editableTextState.selectAll(SelectionChangedCause.tap),
      ),
      onLookUp: null,
      onSearchWeb: null,
      onShare: _getAction(
        share,
        () => editableTextState.shareSelection(SelectionChangedCause.tap),
      ),
      onLiveTextInput: null,
      anchors: const TextSelectionToolbarAnchors(primaryAnchor: Offset(0, 20)),
    );
  }

  // Helper method to return an action or null based on the condition
  VoidCallback? _getAction(bool? condition, VoidCallback action) {
    return condition == true ? action : null;
  }
}
