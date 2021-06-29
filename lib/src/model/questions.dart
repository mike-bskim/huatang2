
//    _question['title'] = items['contents'];
//    _question['correct1'] = item['correct1'];
//    _question['correct2'] = item['correct2'];
//    _question['correct3'] = item['correct3'];
//    _question['correct4'] = item['correct4'];
//    _question['ex1'] = item['ex1'];
//    _question['ex2'] = item['ex2'];
//    _question['ex3'] = item['ex3'];
//    _question['ex4'] = item['ex4'];

class Statistics {
  Statistics({
    this.title,
    this.correct1,
    this.correct2,
    this.favoriteCount,
    this.commentCount,
    this.subscriberCount,
  });

  String? title;
  String? correct1;
  String? correct2;
  String? favoriteCount;
  String? commentCount;
  String? subscriberCount;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    title: json["contents"],
    correct1: json["correct1"],
    correct2: json["correct2"],
    favoriteCount: json["favoriteCount"],
    commentCount: json["commentCount"],
    subscriberCount: json["subscriberCount"],
  );

  Map<String, dynamic> toJson() => {
    "contents": title,
    "correct1": correct1,
    "correct2": correct2,
    "favoriteCount": favoriteCount,
    "commentCount": commentCount,
  };
}