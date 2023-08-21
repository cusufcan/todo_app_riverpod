class Todo {
  final String id;
  final String desc;
  final bool isCompleted;

  Todo({required this.id, required this.desc, this.isCompleted = false});

  @override
  String toString() {
    return '$id: $desc, $isCompleted';
  }
}
