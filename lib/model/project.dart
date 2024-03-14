class Project {
  String id;
  String projectName;
  String period;
  String description;
  String? duration;

  Project({
    required this.id,
    required this.projectName,
    required this.period,
    required this.description,
    this.duration
  });
}
