class Pedidos {
  List<PedidosClientes> pedidosClientes;
  double total;

  Pedidos({this.pedidosClientes, this.total});

  Pedidos.fromJson(Map<String, dynamic> json) {
    if (json['pedidosClientes'] != null) {
      pedidosClientes = new List<PedidosClientes>();
      json['pedidosClientes'].forEach((v) {
        pedidosClientes.add(new PedidosClientes.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pedidosClientes != null) {
      data['pedidosClientes'] =
          this.pedidosClientes.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class PedidosClientes {
  int idPedido;
  String nome;
  String valorTotal;

  PedidosClientes({this.idPedido, this.nome, this.valorTotal});

  PedidosClientes.fromJson(Map<String, dynamic> json) {
    idPedido = json['id_pedido'];
    nome = json['nome'];
    valorTotal = json['valor_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pedido'] = this.idPedido;
    data['nome'] = this.nome;
    data['valor_total'] = this.valorTotal;
    return data;
  }
}
