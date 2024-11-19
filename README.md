# kode_view

Flutter syntax highlighting widgets based on [Highlights](https://github.com/SnipMeDev/Highlights) library. 

<img width="1358" alt="iShot_2024-11-18_21 55 36" src="https://github.com/user-attachments/assets/066a248b-facc-40d1-b518-03ff92c8c847">

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

## Features
- 17 supported languages (Kotlin, Dart, Swift, PHP, etc)
- Light / dark mode
- 6 built-in themes
- Phrase bolding (emphasis)
- Result caching and support for incremental changes

## Support

- Android ✅
- iOS ✅
- macOS 🔴 (Not yet)
- Linux 🔴 (Not yet)
- Windows 🔴 (Not yet)
- Web 🔴 (Not yet)

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
