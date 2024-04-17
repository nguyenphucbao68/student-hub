class Language {
  int? studentId;
  String? languageName;
  String? level;

  Language({this.studentId, this.languageName, this.level});

  List<Language>? parseToList(dynamic item) {
    if (item == null) return null;
    return item
        .map<Language>((item) => Language(
            studentId: item['studentId'],
            languageName: item['languageName'],
            level: item['level']))
        .toList();
  }
}
