class Channel {
  final int idChannel;
  final String nameResearcher;
  final int idResearcher;
  final int idUser;
  final int messageQuantity;

  const Channel(
      {required this.idChannel,
      required this.idResearcher,
      required this.nameResearcher,
      required this.idUser,
      required this.messageQuantity});
  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
        idChannel: json['idChannel'],
        idResearcher: json['idResearcher'],
        nameResearcher: json['nameResearcher'],
        idUser: json['idUser'],
        messageQuantity: json['messageQuantity']);
  }
}
