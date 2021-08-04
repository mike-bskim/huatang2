import 'package:cloud_firestore/cloud_firestore.dart';

class Ex4_Questions {
  Ex4_Questions({
    this.chapter_title,
    this.question_title,
    this.correct1,
    this.correct2,
    this.correct3,
    this.correct4,
    this.datetime,
    this.displayName,
    this.email,
    this.ex1,
    this.ex2,
    this.ex3,
    this.ex4,
    this.id_child,
    this.id_parent,
    this.idx,
    this.photoUrl,
    this.question_type,
    this.student_answer,
    this.teacher_answer,
    this.teacher_uid,
    this.update_time,
  });

  String? chapter_title;
  String? question_title;
  bool? correct1;
  bool? correct2;
  bool? correct3;
  bool? correct4;
  String? datetime;
  String? displayName;
  String? email;
  String? ex1;
  String? ex2;
  String? ex3;
  String? ex4;
  String? id_child;
  String? id_parent;
  int? idx;
  String? photoUrl;
  String? question_type;
  int? student_answer;
  int? teacher_answer;
  String? teacher_uid;
  String? update_time;

  factory Ex4_Questions.fromDoc(QueryDocumentSnapshot data) {
    var info = data.data() as Map<String, dynamic>;
    return Ex4_Questions(
      chapter_title: info["chapter_title"],
      question_title: info["question_title"],
      correct1: info["correct1"],
      correct2: info["correct2"],
      correct3: info["correct3"],
      correct4: info["correct4"],
      datetime: info["datetime"],
      displayName: info["displayName"],
      email: info["email"],
      ex1: info["ex1"],
      ex2: info["ex2"],
      ex3: info["ex3"],
      ex4: info["ex4"],
      id_child: info["id_child"],
      id_parent: info["id_parent"],
      idx: info["idx"],
      photoUrl: info["photoUrl"],
      question_type: info["question_type"],
      student_answer: info["student_answer"],
      teacher_answer: info["teacher_answer"],
      teacher_uid: info["teacher_uid"],
      update_time: info["update_time"],
    );
  }

  Map<String, dynamic> CreateToMap() {
    return {
      'chapter_title': chapter_title,
      'question_title': question_title,
      'correct1': correct1,
      'correct2': correct2,
      'correct3': correct3,
      'correct4': correct4,
      'datetime': datetime,
      'displayName': displayName,
      'email': email,
      'ex1': ex1,
      'ex2': ex2,
      'ex3': ex3,
      'ex4': ex4,
      'id_child': id_child,
      'id_parent': id_parent,
      'idx': idx,
      'photoUrl': photoUrl,
      'question_type': question_type,
      'student_answer': student_answer,
      'teacher_answer': teacher_answer,
      'teacher_uid': teacher_uid,
      'update_time': update_time,
    };
  }


  Map<String, dynamic> UpdateToMap() {
    return {
      'question_title': question_title,
      'correct1': correct1,
      'correct2': correct2,
      'correct3': correct3,
      'correct4': correct4,
      'ex1': ex1,
      'ex2': ex2,
      'ex3': ex3,
      'ex4': ex4,
      'idx': idx,
      'teacher_answer': teacher_answer,
      'update_time': update_time,
    };
  }

}