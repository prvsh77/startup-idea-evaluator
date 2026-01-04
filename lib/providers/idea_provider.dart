import 'package:flutter/foundation.dart';
import '../models/idea.dart';
import '../services/ai_service.dart';

class IdeaProvider with ChangeNotifier {
  List<Idea> _ideas = [];
  List<String> _votedIds = [];

  List<Idea> get ideas => _ideas;
  
  List<Idea> get topRatedIdeas {
    List<Idea> sorted = List.from(_ideas);
    sorted.sort((a, b) => b.rating.compareTo(a.rating));
    return sorted.take(5).toList();
  }

  List<Idea> get topVotedIdeas {
    List<Idea> sorted = List.from(_ideas);
    sorted.sort((a, b) => b.votes.compareTo(a.votes));
    return sorted.take(5).toList();
  }

  Future<void> addIdea(String name, String tagline, String description) async {
    final evaluation = AIService.evaluateIdea(Idea(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      tagline: tagline,
      description: description,
      rating: 0,
      votes: 0,
      createdAt: DateTime.now(),
    ));

    final newIdea = Idea(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      tagline: tagline,
      description: description,
      rating: evaluation['rating'] as int,
      votes: 0,
      createdAt: DateTime.now(),
      category: evaluation['category'] as String?,
    );

    _ideas.insert(0, newIdea);
    notifyListeners();
  }

  void voteIdea(String ideaId) {
    if (_votedIds.contains(ideaId)) {
      return;
    }

    final index = _ideas.indexWhere((idea) => idea.id == ideaId);
    if (index != -1) {
      final idea = _ideas[index];
      final updatedIdea = idea.copyWith(votes: idea.votes + 1);
      _ideas[index] = updatedIdea;
      _votedIds.add(ideaId);
      notifyListeners();
    }
  }

  bool hasVotedFor(String ideaId) {
    return _votedIds.contains(ideaId);
  }

  void removeIdea(String ideaId) {
    _ideas.removeWhere((idea) => idea.id == ideaId);
    notifyListeners();
  }

  List<Idea> getIdeasSortedByRating() {
    List<Idea> sorted = List.from(_ideas);
    sorted.sort((a, b) => b.rating.compareTo(a.rating));
    return sorted;
  }

  List<Idea> getIdeasSortedByVotes() {
    List<Idea> sorted = List.from(_ideas);
    sorted.sort((a, b) => b.votes.compareTo(a.votes));
    return sorted;
  }

  List<Idea> getIdeasSortedByDate() {
    List<Idea> sorted = List.from(_ideas);
    sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted;
  }

  void clearAllData() {
    _ideas.clear();
    _votedIds.clear();
    notifyListeners();
  }
}
