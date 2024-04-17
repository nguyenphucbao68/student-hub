class SkillSet {
  int? id;
  String? name;

  SkillSet({this.name, this.id});

  List<SkillSet>? parseToList(dynamic item) {
    if (item == null) return null;
    return item
        .map<SkillSet>((item) => SkillSet(id: item['id'], name: item['name']))
        .toList();
  }
}
