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
  bool _isLoadingList = false;
  bool _isLoadingWordsPage = false;
  List<Word> _filteredWords = [];
  List<Word> _words = [];

  List<List<Meaning>> _meaningsList = [];

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    _checkLoginStatus();
    _loadWords();
    _laodfirst();
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

    _scrollController.addListener(() {
      var maxScrollExtends = _scrollController.position.maxScrollExtent;
      var scrolledPixels = _scrollController.position.pixels;

      if (scrolledPixels == maxScrollExtends) {
        _loadDataByPage();
      }
    });
  }

  void _laodfirst() {}

  Future<void> _loadDataByPage() async {
    setState(() {
      _isLoadingWordsPage = true;
    });
    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      _isLoadingWordsPage = true;
    });
  }

  void _clearFilter() {
    setState(() {
      _filteredWords.clear();
    });
  }

  Future<void> _filterWords(String query) async {
    var filteredWords = await _databaseHelper.getWordPage(q: query);
    setState(() {
      _filteredWords = filteredWords;
    });
  }

  void _loadWords() async {
    setState(() {
      _isLoadingList = true;
    });

    if (_meaningsList.isEmpty) {
      
      final meanings = await _databaseHelper.getMeanings();
      final wordIds =
          meanings.map<int>((meaning) => meaning['word_id'] as int).toSet();

      _words = await Future.wait(
          wordIds.map((wordId) => _databaseHelper.getWordById(wordId)));

      _words
          .sort((a, b) => a.word.toLowerCase().compareTo(b.word.toLowerCase()));

      _meaningsList = List.generate(_words.length, (index) {
        final wordId = _words[index].id;
        return meanings
            .where((meaning) => meaning['word_id'] == wordId)
            .map((meaning) => Meaning.fromJson(meaning))
            .toList();
      });
    }

    setState(() {
      _isLoadingList = false;
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
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: MyAppBar(),
      drawer: _isLoggedIn ? const SideBarLogged() : const SideBarNotLogged(),
      body: _isLoadingList
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Organizando as palavras...")
                ],
              ),
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
                    child: _filteredWords.isEmpty
                        ? FloatingActionButton(
                            onPressed: () {
                              ShowFilterModal(context, _filterWords);
                            },
                            child: const Icon(
                              Icons.filter_list,
                              color: Colors.black,
                            ),
                          )
                        : FloatingActionButton(
                            onPressed: () {
                              _clearFilter();
                            },
                            child: const Icon(
                              Icons.filter_list_off,
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
          : _filteredWords.isEmpty
              ? FloatingActionButton(
                  onPressed: () {
                    ShowFilterModal(context, _filterWords);
                  },
                  child: const Icon(
                    Icons.filter_list,
                    color: Colors.black,
                  ),
                )
              : FloatingActionButton(
                  onPressed: () {
                    _clearFilter();
                  },
                  child: const Icon(
                    Icons.filter_list_off,
                    color: Colors.black,
                  ),
                ),
    );
  }

  Widget _buildWordList(List words) {
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
          if (index == words.length && _isLoadingWordsPage) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

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
