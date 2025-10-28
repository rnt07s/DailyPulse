import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/mood_entry.dart';

class MoodStorage {
  static const String _storageKey = 'mood_entries';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Save mood entry (local + Cloud Firestore)
  Future<void> saveMoodEntry(MoodEntry entry) async {
    // Save locally
    final prefs = await SharedPreferences.getInstance();
    final entries = await getAllMoodEntries();
    
    entries.add(entry);
    // Sort by date (newest first)
    entries.sort((a, b) => b.date.compareTo(a.date));
    
    final entriesJson = entries.map((e) => e.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(entriesJson));

    // Save to Cloud Firestore if user is authenticated
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore
            .collection('mood_entries')
            .doc(entry.id)
            .set({
              'emoji': entry.emoji,
              'note': entry.note,
              'date': Timestamp.fromDate(entry.date),
              'userId': user.uid,
              'createdAt': FieldValue.serverTimestamp(),
            });
      } catch (e) {
        // Silent fail if Firestore is not available
        print('Firestore sync failed: $e');
      }
    }
  }

  // Get all mood entries
  Future<List<MoodEntry>> getAllMoodEntries() async {
    // Try to get from Firestore first if user is authenticated
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final snapshot = await _firestore
            .collection('mood_entries')
            .where('userId', isEqualTo: user.uid)
            .orderBy('date', descending: true)
            .get();

        if (snapshot.docs.isNotEmpty) {
          final entries = snapshot.docs.map((doc) {
            final data = doc.data();
            return MoodEntry(
              id: doc.id,
              emoji: data['emoji'] ?? '😐',
              note: data['note'] ?? '',
              date: (data['date'] as Timestamp).toDate(),
            );
          }).toList();
          
          // Also sync to local storage
          final prefs = await SharedPreferences.getInstance();
          final entriesJson = entries.map((e) => e.toJson()).toList();
          await prefs.setString(_storageKey, jsonEncode(entriesJson));
          
          return entries;
        }
      } catch (e) {
        print('Firestore read failed: $e');
      }
    }

    // Fallback to local storage
    final prefs = await SharedPreferences.getInstance();
    final entriesString = prefs.getString(_storageKey);
    
    if (entriesString == null) {
      return [];
    }
    
    final List<dynamic> entriesJson = jsonDecode(entriesString);
    return entriesJson.map((json) => MoodEntry.fromJson(json)).toList();
  }

  // Delete mood entry
  Future<void> deleteMoodEntry(String id) async {
    // Delete from local storage
    final prefs = await SharedPreferences.getInstance();
    final entries = await getAllMoodEntries();
    
    entries.removeWhere((entry) => entry.id == id);
    
    final entriesJson = entries.map((e) => e.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(entriesJson));

    // Delete from Firestore if user is authenticated
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('mood_entries').doc(id).delete();
      } catch (e) {
        print('Firestore delete failed: $e');
      }
    }
  }

  // Clear all entries
  Future<void> clearAllEntries() async {
    // Clear local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);

    // Clear from Firestore if user is authenticated
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final snapshot = await _firestore
            .collection('mood_entries')
            .where('userId', isEqualTo: user.uid)
            .get();
        
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }
      } catch (e) {
        print('Firestore clear failed: $e');
      }
    }
  }
}

