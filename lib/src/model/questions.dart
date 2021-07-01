class Ex4_Questions {
  Ex4_Questions({
    this.chapter_title,
    this.contents,
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
  String? contents;
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

  factory Ex4_Questions.fromJson(Map<String, dynamic> json) => Ex4_Questions(
    chapter_title : json["chapter_title"],
    contents : json["contents"],
    correct1 : json["correct1"],
    correct2 : json["correct2"],
    correct3 : json["correct3"],
    correct4 : json["correct4"],
    datetime : json["datetime"],
    displayName : json["displayName"],
    email : json["email"],
    ex1 : json["ex1"],
    ex2 : json["ex2"],
    ex3 : json["ex3"],
    ex4 : json["ex4"],
    id_child : json["id_child"],
    id_parent : json["id_parent"],
    idx : json["idx"],
    photoUrl : json["photoUrl"],
    question_type : json["question_type"],
    student_answer : json["student_answer"],
    teacher_answer : json["teacher_answer"],
    teacher_uid : json["teacher_uid"],
    update_time : json["update_time"],
  );

//  Map<String, dynamic> toJson() => {
//    "contents": title,
//    "correct1": correct1,
//    "correct2": correct2,
//    "favoriteCount": favoriteCount,
//    "commentCount": commentCount,
//  };
}