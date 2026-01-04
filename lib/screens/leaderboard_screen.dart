import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/idea_provider.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Leaderboard'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Most Voted'),
              Tab(text: 'Top Rated'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildLeaderboard(true, context),
            _buildLeaderboard(false, context),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboard(bool byVotes, BuildContext context) {
    return Consumer<IdeaProvider>(
      builder: (context, provider, child) {
        final topIdeas = byVotes ? provider.topVotedIdeas : provider.topRatedIdeas;

        if (topIdeas.isEmpty) {
          return const Center(
            child: Text('No ideas yet! Submit some ideas to see the leaderboard.'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: topIdeas.length,
          itemBuilder: (context, index) {
            final idea = topIdeas[index];
            
            return Card(
              color: index < 3 ? Colors.blue[50] : null,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getMedalColor(index),
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(idea.name),
                subtitle: Text(idea.tagline),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      byVotes ? '${idea.votes} votes' : '${idea.rating} pts',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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

  Color _getMedalColor(int index) {
    switch (index) {
      case 0:
        return Colors.amber;
      case 1:
        return Colors.grey;
      case 2:
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }
}
