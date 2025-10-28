import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import '../services/mood_storage.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final MoodStorage _storage = MoodStorage();
  List<MoodEntry> _entries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final entries = await _storage.getAllMoodEntries();
    
    setState(() {
      _entries = entries;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalEntries = _entries.length;
    final positiveDays = _entries.where((e) => e.isPositive).length;
    final negativeDays = _entries.where((e) => e.isNegative).length;
    final neutralDays = totalEntries - positiveDays - negativeDays;
    
    // Calculate most common mood
    final moodCount = <String, int>{};
    for (var entry in _entries) {
      moodCount[entry.emoji] = (moodCount[entry.emoji] ?? 0) + 1;
    }
    final sortedMoods = moodCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final mostCommonMood = sortedMoods.isNotEmpty ? sortedMoods[0].key : null;
    final mostCommonCount = sortedMoods.isNotEmpty ? sortedMoods[0].value : 0;

    // Calculate streak
    if (_entries.isEmpty) {
      // Show empty state
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mood Analytics',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.analytics_outlined,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No data yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Log some moods to see your insights!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mood Analytics',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Total entries card
                    _buildStatCard(
                      context,
                      icon: Icons.calendar_today,
                      title: 'Total Entries',
                      value: totalEntries.toString(),
                      color: Theme.of(context).primaryColor,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Mood distribution cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            context,
                            icon: Icons.sentiment_very_satisfied,
                            title: 'Positive Days',
                            value: positiveDays.toString(),
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            context,
                            icon: Icons.sentiment_satisfied,
                            title: 'Neutral Days',
                            value: neutralDays.toString(),
                            color: Colors.grey[600]!,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildStatCard(
                      context,
                      icon: Icons.sentiment_very_dissatisfied,
                      title: 'Negative Days',
                      value: negativeDays.toString(),
                      color: Colors.red,
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Most common mood
                    if (mostCommonMood != null)
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.emoji_emotions,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Most Common Mood',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                mostCommonMood,
                                style: const TextStyle(fontSize: 64),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Appears $mostCommonCount ${mostCommonCount == 1 ? 'time' : 'times'}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

