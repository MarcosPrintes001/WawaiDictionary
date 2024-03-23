import 'package:flutter/material.dart';
import 'package:waiwai_dictionary/components/appBar.dart';
import 'package:waiwai_dictionary/components/sideBarLogged.dart';
import 'package:waiwai_dictionary/components/sidebarNotLogged.dart';
import 'package:waiwai_dictionary/components/modal.dart';
import 'package:waiwai_dictionary/components/word.dart';
import 'package:waiwai_dictionary/models/wordModels.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiwai_dictionary/screens/word.dart';
import 'package:waiwai_dictionary/services/bd.dart';

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
  bool _isLoggedIn = false;
  late DatabaseHelper _databaseHelper;
  bool _isLoading = false;
  List<Word> _filteredWords = [];
  List<Word> _words = [];
  List<List<Meaning>> _meaningsList = [];

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    _checkLoginStatus();
    _loadWords();
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

  void _clearFilter() {
    setState(() {
      _filteredWords.clear();
    });
  }

  void _filterWords(String query) {
    setState(() {
      _filteredWords = _words
          .where(
              (word) => word.word.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _loadWords() async {
    setState(() {
      _isLoading = true; // Mostrar indicador de progresso
    });

    final meanings = await _databaseHelper.getMeanings();
    final wordIds =
        meanings.map<int>((meaning) => meaning['word_id'] as int).toSet();

    _words = await Future.wait(
        wordIds.map((wordId) => _databaseHelper.getWordById(wordId)));

    _words.sort((a, b) => a.word.toLowerCase().compareTo(b.word.toLowerCase()));

    _meaningsList = List.generate(_words.length, (index) {
      final wordId = _words[index].id;
      return meanings
          .where((meaning) => meaning['word_id'] == wordId)
          .map((meaning) => Meaning.fromJson(meaning))
          .toList();
    });

    setState(() {
      _isLoading = false;
    });
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('logado') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: MyAppBar(),
      drawer: _isLoggedIn ? const SideBarLogged() : const SideBarNotLogged(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _filteredWords.isNotEmpty
              ? _buildWordList(_filteredWords)
              : _words.isNotEmpty
                  ? _buildWordList(_words)
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/words_not_found.png'),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
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
                        ShowFilterModal(context, _filterWords);
                      },
                      child: const Icon(
                        Icons.filter_list,
                        color: Colors.black,
                      ),
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
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Colors.black,
                  ),
                ),
              ],
            )
          : FloatingActionButton(
              onPressed: () {
                ShowFilterModal(context, _filterWords);
              },
              child: const Icon(
                Icons.filter_list,
                color: Colors.black,
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      persistentFooterButtons: _filteredWords.isNotEmpty
          ? [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      _clearFilter();
                    },
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 2.0,
                    child: const Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ]
          : null,
    );
  }

  Widget _buildWordList(List<Word> words) {
    return NotificationListener<ScrollNotification>(
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
        itemCount: words.length,
        itemBuilder: (context, index) {
          final word = words[index];
          final meanings = _meaningsList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: WordComponent(
              word: word,
              meanings: meanings,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WordPage(meanings: meanings, words: word);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
