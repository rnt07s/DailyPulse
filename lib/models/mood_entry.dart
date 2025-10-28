class MoodEntry {
  final String id;
  final String emoji;
  final String note;
  final DateTime date;

  MoodEntry({
    required this.id,
    required this.emoji,
    required this.note,
    required this.date,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emoji': emoji,
      'note': note,
      'date': date.toIso8601String(),
    };
  }

  // Create from JSON
  factory MoodEntry.fromJson(Map<String, dynamic> json) {
    return MoodEntry(
      id: json['id'],
      emoji: json['emoji'],
      note: json['note'],
      date: DateTime.parse(json['date']),
    );
  }

  // Check if mood is positive
  bool get isPositive {
    const positiveEmojis = ['😊', '😄', '😁', '🙂', '😃', '💚', '😍', '🥰'];
    return positiveEmojis.contains(emoji);
  }

  // Check if mood is negative
  bool get isNegative {
    const negativeEmojis = ['😢', '😞', '😔', '😕', '😰', '😡', '😟'];
    return negativeEmojis.contains(emoji);
  }
}

