import 'package:flutter/material.dart';

void ShowFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Opção para o usuário escrever
                const TextField(
                  decoration: InputDecoration(labelText: 'Aparaca....'),
                ),
                const SizedBox(height: 16),
                // Opção com AutoComplete
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    // Lógica para fornecer opções de AutoComplete
                    // Pode ser uma lista de strings ou qualquer outro tipo de dados
                    const List<String> options = [
                      'Animal',
                      'Frutas',
                      'Sentimento'
                    ];
                    return options
                        .where((String option) =>
                            option.contains(textEditingValue.text.toLowerCase()))
                        .toList();
                  },
                  onSelected: (String selectedOption) {
                    // Lógica ao selecionar uma opção do AutoComplete
          
                    // ignore: avoid_print
                    print('Selected: $selectedOption');
                  },
                ),
                const SizedBox(height: 20,),
                TextButton(onPressed: () {}, child: const Text("Filtrar"))
              ],
            ),
          ),
        );
      },
    );
  }