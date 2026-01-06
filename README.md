🧪 Startup Idea Evaluator 🚀  
**AI + Voting Mobile App (Flutter)**

Overview
Startup Idea Evaluator is a Flutter-based mobile application that allows users to submit startup ideas, receive fun AI-generated feedback, vote on ideas, and view a live leaderboard.  
The app simulates an AI-powered evaluation workflow while focusing on clean UX, state management, persistence, and animations.

This project was built as part of a **Mobile App Internship Assignment** to demonstrate end-to-end mobile development skills.

✨ Features

Core Features
- 📥 Submit startup ideas (name, tagline, description)
- 🤖 Fake AI-generated rating (0–100)
- 🧠 AI-style reasoning text explaining the rating
- 👍 Vote on ideas (one interaction per swipe/tap)
- 🏆 Leaderboard showing top ideas
- 🔄 Sorting by votes and ranking

Advanced UX & Engineering
- 🌗 Dark mode with persisted preference
- 📱 Swipe-to-vote gestures (dismissible cards)
- 🎯 Hero animations (list → detail screen)
- 🎞 Animated leaderboard rank transitions
- 📦 Local JSON persistence (SharedPreferences)
- 📋 Share idea details via clipboard
- 🔔 Toast notifications
- 📳 Haptic feedback on actions

---

🧱 Tech Stack

- **Framework:** Flutter (Material 3)
- **State Management:** Provider
- **Persistence:** SharedPreferences (JSON serialization)
- **Animations:** Hero, AnimatedSwitcher, AnimatedList
- **UX Feedback:** FlutterToast, HapticFeedback
- **AI Layer:** Mock OpenAI-style REST service

---

🧠 AI Evaluation (Mocked)

The app uses a mock REST service that simulates an AI call:
- Adds network delay
- Returns a random rating
- Generates contextual reasoning text

This design allows seamless replacement with a real OpenAI API later without changing UI logic.

---

🧪 Testing

Basic unit tests are included to verify:
- Idea creation
- Voting logic
- JSON serialization & restoration

Tests are written using `flutter_test` to validate provider and model behavior.

---
💻 Source Code

**FlutLab Project:**  
👉 _[https://flutlab.io/sandbox/9429bf10-77e0-40b0-a182-adfca758e059]_

---

## ▶️ How to Run Locally

### Prerequisites
- Flutter SDK installed
- Android Studio / Emulator or physical device

### Steps
```bash
flutter pub get
flutter run
