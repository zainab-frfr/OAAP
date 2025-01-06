class Note {
  final String comment;
  final String username;
  final String date;

  const Note({
    required this.comment,
    required this.username,
    required this.date,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      comment: json['comment'],
      username: json['username'],
      date: json['date'], 
    );
  }
}
