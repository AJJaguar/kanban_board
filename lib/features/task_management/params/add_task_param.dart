class AddTaskParam {
  AddTaskParam({required this.title, required this.description});
  final String title;
  final String description;

  Map<String, dynamic> toJson() => {
        'name': title,
        'description': description,
      };
}
