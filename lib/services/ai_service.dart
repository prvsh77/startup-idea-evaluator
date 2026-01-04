import 'dart:math';
import '../models/idea.dart';

class AIService {
  static final Random _random = Random();
  static final List<String> _funnyFeedbacks = [
    "This idea is so innovative, even my circuits are buzzing! ⚡",
    "Potential detected! But needs more pizza 🍕",
    "Disruptive! Might need a better name though...",
    "Brilliant! Would invest my virtual coins in this! 💰",
    "Interesting concept! Add some AI buzzwords for +10 points",
    "This could work! Market needs more 🦄",
    "VCs would fight over this! (In my simulated world)",
    "Needs more blockchain? Just kidding! Looks promising!",
    "Revolutionary! If executed right, you'll be the next big thing!",
    "I've simulated 1000 futures - this succeeds in 42% of them! 🚀"
  ];

  static final List<String> _categories = [
    "Tech", "Health", "Finance", "Education", "Entertainment",
    "Food", "Travel", "Social", "Productivity", "Sustainability"
  ];

  static int generateRating(String ideaText) {
    int baseScore = _random.nextInt(30) + 40;
    
    List<String> bonusKeywords = [
      "AI", "blockchain", "sustainable", "cloud", "platform",
      "marketplace", "app", "solution", "innovative", "disruptive"
    ];
    
    int keywordBonus = 0;
    for (String keyword in bonusKeywords) {
      if (ideaText.toLowerCase().contains(keyword.toLowerCase())) {
        keywordBonus += 5;
      }
    }
    
    int randomFactor = _random.nextInt(15);
    
    int totalScore = baseScore + keywordBonus + randomFactor;
    
    return totalScore > 100 ? 100 : totalScore;
  }

  static String getFeedback(String ideaText) {
    int index = _random.nextInt(_funnyFeedbacks.length);
    return _funnyFeedbacks[index];
  }

  static String getRandomCategory() {
    int index = _random.nextInt(_categories.length);
    return _categories[index];
  }

  static String getRatingDescription(int rating) {
    if (rating >= 90) return "Exceptional! 🏆";
    if (rating >= 80) return "Excellent! 🌟";
    if (rating >= 70) return "Great! 👍";
    if (rating >= 60) return "Good! 👌";
    if (rating >= 50) return "Promising! 💡";
    if (rating >= 40) return "Needs work 🤔";
    return "Back to drawing board 📝";
  }

  static Map<String, dynamic> evaluateIdea(Idea idea) {
    String combinedText = "${idea.name} ${idea.tagline} ${idea.description}";
    int rating = generateRating(combinedText);
    String feedback = getFeedback(combinedText);
    String category = getRandomCategory();
    String description = getRatingDescription(rating);

    return {
      'rating': rating,
      'feedback': feedback,
      'category': category,
      'description': description,
    };
  }
}
