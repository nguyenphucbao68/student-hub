class TechStack {
  int? id;
  String? name;

  TechStack({this.name, this.id});

  TechStack parse(dynamic data) {
    return TechStack(
      id: data['id'],
      name: data['name'],
    );
  }

  TechStack? tryParse(dynamic data) {
    if (data == null) return null;
    return TechStack().parse(data);
  }
}
