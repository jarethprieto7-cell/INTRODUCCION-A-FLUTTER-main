/* {
  "id": 1,
  "name": "John Doe",
  "score": 98
} */
class Student {
  int id;
  String name;
  int score;

  Student({required this.id, required this.name, required this.score});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      score: json['score']
    );
  }
}