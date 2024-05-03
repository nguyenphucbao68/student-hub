class Education {
  int? studentId;
  String? schoolName;
  int? startYear;
  int? endYear;

  Education({this.studentId, this.schoolName, this.startYear, this.endYear});

  List<Education>? parseToList(dynamic item) {
    if (item == null) return null;
    return item
        .map<Education>((item) => Education(
            studentId: item['studentId'],
            schoolName: item['schoolName'],
            startYear: item['startYear'],
            endYear: item['endYear']))
        .toList();
  }
}
