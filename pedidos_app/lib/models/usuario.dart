class Usuario {
  int idvendedor;
  String nome;
  String usuario;
  String senha;

  Usuario({this.nome, this.usuario, this.senha});

  Usuario.fromJson(Map<String, dynamic> json) {
    idvendedor = json['id_vendedor'];
    nome = json['nome'];
    usuario = json['usuario'];
    senha = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_vendedor'] = this.idvendedor;
    data['nome'] = this.nome;
    data['usuario'] = this.usuario;
    data['senha'] = this.senha;
    return data;
  }
}
