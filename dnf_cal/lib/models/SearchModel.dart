import 'package:dnf_cal/models/SearchCharacterModel.dart';
import 'package:flutter/material.dart';

class SearchModel with ChangeNotifier {
  String _inputText = "";
  bool _isSubmitted = false;
  final _fieldText = TextEditingController();
  final List<String> _servers = [
    '전체', '안톤', '바칼', '카인', '카시야스', '디레지에', '힐더', '프레이', '시로코'
  ];
  String _selectedServer = "전체";
  List<SearchCharacterModel> _searchedCharacter = [];

  String get inputText => _inputText;
  bool get isSubmitted => _isSubmitted;
  TextEditingController get fieldText => _fieldText;
  List<String> get servers => _servers;
  String get selectedServer => _selectedServer;
  List<SearchCharacterModel> get searchedCharacter => _searchedCharacter;

  void setSearchedCharacter(List<SearchCharacterModel> characters) {
    _searchedCharacter = characters;
    for (SearchCharacterModel character in _searchedCharacter) {
      print("APIMODEL: ${character.characterName}, ${character.jobName}");
    }
    notifyListeners();
  }

  void setSubmitted(bool isSubmitted) {
    _isSubmitted = isSubmitted;
    notifyListeners();
  }

  void setInputText() {
    _inputText = "";
    notifyListeners();
  }

  void clearText() {
    _fieldText.clear();
  }

  void setServer(String serverName) {
    _selectedServer = serverName;
    notifyListeners();
  }

}