import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:waiwai_dictionary/models/wordModels.dart';
import 'package:waiwai_dictionary/services/bd.dart';

String urlBase = 'http://192.168.1.110:3001/';

// Definindo um tipo de função de retorno de chamada para atualização de progresso
typedef ProgressCallback = void Function(double);

Future<void> fetchDataAndInsertIntoDatabase(
    {required ProgressCallback onProgress}) async {
  try {
    // Realiza a solicitação para a rota de palavras
    var wordsResponse = await http.get(Uri.parse('$urlBase/words/export/all'));
    var referencesResponse =
        await http.get(Uri.parse('$urlBase/references/export/all'));
    var meaningsResponse =
        await http.get(Uri.parse('$urlBase/meanings/export/all'));

    if (wordsResponse.statusCode == 200 &&
        referencesResponse.statusCode == 200 &&
        meaningsResponse.statusCode == 200) {
      // Converta os dados em listas de objetos
      List<dynamic> wordsData = jsonDecode(wordsResponse.body);
      List<dynamic> referencesData = jsonDecode(referencesResponse.body);
      List<dynamic> meaningsData = jsonDecode(meaningsResponse.body);

      // Calcula o total de operações necessárias para estimar o progresso
      int totalOperations =
          wordsData.length + referencesData.length + meaningsData.length;
      int completedOperations = 0;

      // Insira os dados nas tabelas correspondentes do banco de dados
      for (var data in wordsData) {
        if (data.containsKey('word')) {
          Word word = Word.fromJson(data);
          await DatabaseHelper().insertWord(word);
          completedOperations++;
          onProgress(completedOperations /
              totalOperations); // Chama a função de retorno de chamada com o progresso atual
        }
      }

      for (var data in referencesData) {
        if (data.containsKey('reference')) {
          Reference reference = Reference.fromJson(data);
          await DatabaseHelper().insertReference(reference);
          completedOperations++;
          onProgress(completedOperations /
              totalOperations); // Chama a função de retorno de chamada com o progresso atual
        }
      }

      for (var data in meaningsData) {
        if (data.containsKey('meaning')) {
          Meaning meaning = Meaning.fromJson(data);
          await DatabaseHelper().insertMeaning(meaning);
          completedOperations++;
          onProgress(completedOperations /
              totalOperations); // Chama a função de retorno de chamada com o progresso atual
        }
      }

      print('Dados inseridos no banco de dados com sucesso.');
    } else {
      print('Erro ao buscar dados da API.');
    }
  } catch (e) {
    print('Erro durante a solicitação e inserção de dados: $e');
  }
}
