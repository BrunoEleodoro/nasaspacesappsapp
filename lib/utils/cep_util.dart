import 'api_helper.dart';

class CepObject {
  var cep;
  var logradouro;
  var complemento;
  var bairro;
  var localidade;
  var uf;
  var unidade;
  var ibge;
  var gia;
  CepObject(
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.unidade,
    this.ibge,
    this.gia,
  );
}

class CepUtil {
  static Future<CepObject> getInformationFromCep(cep) async {
    var res = await ApiHelper.getRequest(
        'https://viacep.com.br/ws/' + cep + '/json/');
    if (res['erro'] != null) {
      return new CepObject(
          'Não encontrado', 'Não encontrado', '', '', '', '', '', '', '');
    }
    return new CepObject(
        res['cep'],
        res['logradouro'],
        res['complemento'],
        res['bairro'],
        res['localidade'],
        res['uf'],
        res['unidade'],
        res['ibge'],
        res['gia']);
  }
}
