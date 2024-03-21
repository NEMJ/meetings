class CheckboxModel {
  CheckboxModel({
    required this.id,
    required this.title,
    this.value = false,
  });

  final String id;
  final String title;
  bool value;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title
    };
  }
}