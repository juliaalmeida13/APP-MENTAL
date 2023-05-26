class Score {
  final String score;
  final int domain;
  final String week;

  const Score({required this.score, required this.domain, required this.week});

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      score: json['score'],
      domain: json['domain'],
      week: json['week'],
    );
  }
}
