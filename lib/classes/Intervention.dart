class Intervention {
  String id = "";

  String nome = "";
  String grupo = "";
  String arquivo = "";
  String imagem = "";
  String tipo = "";
  String video = "";

  Intervention(
      {required this.id,
      required this.nome,
      required this.grupo,
      required this.arquivo,
      required this.imagem,
      required this.tipo,
      required this.video});

  Intervention.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    grupo = json['grupo'];
    arquivo = json['arquivo'];
    imagem = json['imagem'];
    tipo = json['tipo'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['grupo'] = this.grupo;
    data['arquivo'] = this.arquivo;
    data['imagem'] = this.imagem;
    data['tipo'] = this.tipo;
    data['video'] = this.video;

    return data;
  }
}
