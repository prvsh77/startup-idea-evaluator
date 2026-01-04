import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'submission_screen.dart';
import '../providers/idea_provider.dart';

enum SortOption { date, rating, votes }

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  SortOption _sortOption = SortOption.date;

  @override
  Widget build(BuildContext context) {
    return Consumer<IdeaProvider>(
      builder: (context, provider, child) {
        List ideas;
        switch (_sortOption) {
          case SortOption.date:
            ideas = provider.getIdeasSortedByDate();
            break;
          case SortOption.rating:
            ideas = provider.getIdeasSortedByRating();
            break;
          case SortOption.votes:
            ideas = provider.getIdeasSortedByVotes();
            break;
        }

        if (provider.ideas.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lightbulb_outline, size: 64),
                const SizedBox(height: 16),
                const Text('No ideas yet!'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubmissionScreen(),
                      ),
                    );
                  },
                  child: const Text('Submit First Idea'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Sort by:'),
                  const SizedBox(width: 8),
                  DropdownButton<SortOption>(
                    value: _sortOption,
                    onChanged: (SortOption? newValue) {
                      setState(() {
                        _sortOption = newValue!;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: SortOption.date,
                        child: Text('Date'),
                      ),
                      DropdownMenuItem(
                        value: SortOption.rating,
                        child: Text('Rating'),
                      ),
                      DropdownMenuItem(
                        value: SortOption.votes,
                        child: Text('Votes'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: ideas.length,
                itemBuilder: (context, index) {
                  final idea = ideas[index];
                  
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                idea.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getRatingColor(idea.rating),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  '${idea.rating}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            idea.tagline,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 12),
                          Text(idea.description),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.voteIdea(idea.id);
                                },
                                icon: Icon(
                                  Icons.thumb_up,
                                  color: provider.hasVotedFor(idea.id)
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                              Text('${idea.votes} votes'),
                              const Spacer(),
                              Text(
                                '${idea.createdAt.day}/${idea.createdAt.month}/${idea.createdAt.year}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Color _getRatingColor(int rating) {
    if (rating >= 80) return Colors.green;
    if (rating >= 60) return Colors.blue;
    if (rating >= 40) return Colors.orange;
    return Colors.red;
  }
}
