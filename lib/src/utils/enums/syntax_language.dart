enum SyntaxLanguage {
  none('DEFAULT'),
  c('C'),
  cpp('CPP'),
  dart('DART'),
  java('JAVA'),
  kotlin('KOTLIN'),
  rust('RUST'),
  csharp('CSHARP'),
  coffeescript('COFFEESCRIPT'),
  javascript('JAVASCRIPT'),
  perl('PERL'),
  python('PYTHON'),
  ruby('RUBY'),
  shell('SHELL'),
  swift('SWIFT'),
  typescript('TYPESCRIPT'),
  go('GO'),
  php('PHP');

  final String name;
  const SyntaxLanguage(this.name);
}
