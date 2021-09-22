class Category {
  String nome = "";
  String imagem = "";

  Category({required this.nome, required this.imagem});

  Category.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    imagem = json['imagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['imagem'] = this.imagem;
    return data;
  }
}
