class BatchesModel {
  final String id;
  final String name;
  final List<String> students;
  final String monitor;

  BatchesModel({
    required this.id,
    required this.name,
    required this.students,
    required this.monitor,
  });

  factory BatchesModel.empty() {
    return BatchesModel(name: '', students: [], monitor: '', id: '');
  }
}
