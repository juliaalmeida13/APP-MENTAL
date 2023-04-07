class Channel {
  final int idChannel;
  final String nameResearcher;
  final int idResearcher;
  final int idUser;

  const Channel(
      {required this.idChannel,
      required this.idResearcher,
      required this.nameResearcher,
      required this.idUser});
  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
        idChannel: json['idChannel'],
        idResearcher: json['idResearcher'],
        nameResearcher: json['nameResearcher'],
        idUser: json['idUser']);
  }
}
