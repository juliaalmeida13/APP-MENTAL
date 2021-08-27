class Intervencao {
  String? nome;
  String? grupo;
  String? arquivo;

  Intervencao({
    this.nome,
    this.grupo,
    this.arquivo,
  });

  Intervencao.fromJson(Map<String, dynamic> json) {
    nome = json["nome"]?.toString();
    grupo = json["grupo"]?.toString();
    arquivo = json["arquivo"]?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["nome"] = nome;
    data["grupo"] = grupo;
    data["arquivo"] = arquivo;
    return data;
  }
}
