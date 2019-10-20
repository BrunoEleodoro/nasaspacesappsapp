class UrlHelper {
  static var baseUrl =
      "https://serverless-master-ecoquest.brunoeleodoroecoquest.now.sh";

  static var login = baseUrl + "/user/authenticate";

  static var salvarCliente = baseUrl + "/clientes/salvarCliente";
  static var atualizarCliente = baseUrl + "/clientes/atualizarCliente";
  static var removerCliente = baseUrl + "/clientes/removerCliente";
  static var listarClientes = baseUrl + "/clientes/listarClientes";
  static var listarOrcamentoConfig =
      baseUrl + "/orcamentoConfig/listarOrcamentoConfig";
  static var atualizarOrcamentoConfig =
      baseUrl + "/orcamentoConfig/atualizarOrcamentoConfig";

  // static var criar_evento = baseUrl + "/evento/create";
  // static var atualizar_evento = baseUrl + "/evento/update";
  // static var remover_evento = baseUrl + "/evento/delete";
  // static var listar_eventos = baseUrl + "/evento/list";
}