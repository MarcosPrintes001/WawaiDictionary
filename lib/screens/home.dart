import 'package:flutter/material.dart';
import 'package:waiwai_dictionary/components/appBar.dart';
import 'package:waiwai_dictionary/components/sidebar.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showArrowUpButton = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= 200) {
        setState(() {
          _showArrowUpButton = true;
        });
      } else {
        setState(() {
          _showArrowUpButton = false;
        });
      }
    });
  }

  // Método para exibir o modal de filtro
  void _showFilterModal(BuildContext context) {
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: MyAppBar(),
      drawer: const MySideBar(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification) {
            if (_scrollController.offset >= 200) {
              setState(() {
                _showArrowUpButton = true;
              });
            } else {
              setState(() {
                _showArrowUpButton = false;
              });
            }
          }
          return true;
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: 50,
          itemBuilder: (context, index) => ListTile(
            title: Text('Item $index'),
          ),
        ),
      ),
      floatingActionButton: _showArrowUpButton
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: AnimatedOpacity(
                    opacity: _showArrowUpButton ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: FloatingActionButton(
                      onPressed: () {
                        _showFilterModal(context);
                      },
                      child: const Icon(Icons.filter_list),
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Icon(Icons.arrow_upward),
                ),
              ],
            )
          : FloatingActionButton(
              onPressed: () {
                _showFilterModal(context);
              },
              child: const Icon(
                Icons.filter_list,
              ),
            ),
    );
  }
}
