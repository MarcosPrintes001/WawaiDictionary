import 'package:flutter/material.dart';
void ShowFilterModal(BuildContext context) {
  TextEditingController searchController = TextEditingController();
  TextEditingController filterController = TextEditingController();

  showModalBottomSheet(
    isScrollControlled: true, // Define como true para permitir que o modal seja rolado quando o teclado estiver ativo
    context: context,
    builder: (BuildContext context) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20, // Adiciona espaço adicional para o teclado
                top: 16, // Padding no topo do modal
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
// Campo de busca por palavra
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Busque por Palavra',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
// Ícone de filtro com texto "Filtre por Categoria"
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.filter_list),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: filterController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Filtre por Categoria',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
// Botão "Buscar"
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Buscar',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
