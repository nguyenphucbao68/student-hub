class Experience {
  int? studentId;
  String? title;
  String? startMonth;
  String? endMonth;
  String? description;

  Experience(
      {this.studentId,
      this.title,
      this.startMonth,
      this.endMonth,
      this.description});

  List<Experience>? parseToList(dynamic item) {
    if (item == null) return null;
    return item
        .map<Experience>((item) => Experience(
            studentId: item['studentId'],
            title: item['title'],
            startMonth: item['startMonth'],
            endMonth: item['endMonth'],
            description: item['description']))
        .toList();
  }
}
