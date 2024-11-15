import 'package:flutter/material.dart';
import 'package:kode_view/kode_view.dart';

const codeSnippet =
    "class HelloWorld {\n\tpublic static void main(String[] args) {\n\t\tSystem.out.println(\"Hello, World!\"); \n}}";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kode View example'),
        ),
        body: Center(
            child: Column(
          children: [
            const Text("CodeTextView"),
            const SizedBox(
              height: 12,
            ),
            CodeTextView(
              code: codeSnippet,
              language: SyntaxLanguage.java.name,
              theme: SyntaxTheme.darcula.name,
              options: TextSelectionOptions(
                  copy: true, selectAll: true, share: true),
            ),
          ],
        )),
      ),
    );
  }
}
