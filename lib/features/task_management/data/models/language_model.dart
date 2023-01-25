class Language {
  Language(this.id, this.name, this.languageCode);

  final int id;
  final String name;
  final String languageCode;

  static List<Language> languageList() {
    return <Language>[
      Language(1, 'Deutsche', 'de'),
      Language(2, 'Türk', 'tr'),
      Language(3, 'English', 'en'),
    ];
  }
}
