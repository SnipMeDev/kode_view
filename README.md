# kode_view

Flutter syntax highlighting widgets based on [Highlights](https://github.com/SnipMeDev/Highlights) library. 

Images  

## Installation

```dart
flutter pub add kode_view
```

## Usage

### CodeTextView

```dart
import 'package:flutter/material.dart';
import 'package:kode_view/kode_view.dart';

@override
Widget build(BuildContext context) {
  final codeSnippet = "class HelloWorld {}";
  
  return MaterialApp(
    home: Scaffold(
      appBar: ...,
      body: CodeTextView(
        code: codeSnippet,
        language: "Java",
        theme: "darcula",
        options: ...,
      ),
    ),
  );
}
```

### CodeEditText

```dart
import 'package:flutter/material.dart';
import 'package:kode_view/kode_view.dart';

class _MyAppState extends State<MyApp> {
  final SyntaxHighlightingController controller =
  SyntaxHighlightingController(text: codeSnippet);

  @override
  Widget build(BuildContext context) {
    final codeSnippet = "class HelloWorld {}";

    return MaterialApp(
      home: Scaffold(
        appBar: ...,
        body: CodeEditText(
          code: codeSnippet,
          controller: controller,
          showCursor: true,
        ),
      ),
    );
  }
}

```

License 🖋️
=======

    Copyright 2024 Tomasz Kądziołka.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
