import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'build_glass_card.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  PlanScreenState createState() => PlanScreenState();
}

class PlanScreenState extends State<PlanScreen> {
  int selectedDay = DateTime.now().day;
  final List<String> daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  List<DateTime> dates = [];
  List<Map<String, dynamic>> exerciseCategories = []; // Stores fetched data
  String userName = "";

  @override
  void initState() {
    super.initState();
    _populateDates();
    _fetchExerciseCategories();
    _fetchUserName();
  }

  void _populateDates() {
    DateTime now = DateTime.now();
    int weekday = now.weekday; // 1 = Monday, 7 = Sunday
    DateTime startOfWeek = now.subtract(Duration(days: weekday - 1));
    dates = List.generate(7, (index) {
      return startOfWeek.add(Duration(days: index));
    });
  }
  Future<void> _fetchUserName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.email != null) {
        // Extract the name part from the email
        String email = user.email!;
        userName = email.split('@')[0];
        userName = userName[0].toUpperCase() + userName.substring(1); // Capitalize first letter
      } else {
        userName = "User"; // Default if user or email is null
      }
      setState(() {});
    } catch (e) {
      print("Error fetching user name: $e");
    }
  }

  Future<void> _fetchExerciseCategories() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('category')
          .get();
      final categories = snapshot.docs.map((doc) => {
        'title': doc['title'] ?? 'Exercise',
        'duration': doc['Duration'] ?? 'Duration not specified',
        'image': doc['Image'] ?? 'https://default-image-url.com'
      }).toList();

      setState(() {
        exerciseCategories = categories;
      });
    } catch (e) {
      print('Error fetching exercise categories: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Today's Plan", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circular Progress and Greeting
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: 0,
                      strokeWidth: 8,
                      color: Colors.deepPurple,
                      backgroundColor: Colors.white24,
                    ),
                    Text("0%", style: TextStyle(color: Colors.white)),
                  ],
                ),
                Text(
                  "Enjoy your day, $userName",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Icon(Icons.favorite, color: Colors.deepPurple),
              ],
            ),
            const SizedBox(height: 20),

            // Date Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(dates.length, (index) {
                return Column(
                  children: [
                    Text(
                      DateFormat('d').format(dates[index]),
                      style: TextStyle(
                        fontSize: 24,
                        color: selectedDay == dates[index].day ?
                        Colors.deepPurple : Colors.white70,
                        fontWeight: selectedDay == dates[index].day ?
                        FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    Text(
                      daysOfWeek[index],
                      style: const TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 20),

            // Activity Cards
            Expanded(
              child: exerciseCategories.isEmpty
                  ? const Center(
                  child: CircularProgressIndicator()) // Loading indicator
                  : ListView.builder(
                itemCount: exerciseCategories.length,
                itemBuilder: (context, index) {
                  final category = exerciseCategories[index];
                  return buildGlassCard(
                    context,
                    category['title'] ?? 'Exercise',
                    category['duration'] ?? 'Duration not specified',
                    category['image'] ?? 'https://imgcdn.stablediffusionweb.com/2024/5/12/57c56992-98ed-4f53-b6b7-ae4a82cb4525.jpg',
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFF1A1A2E),
        unselectedItemColor: const Color(0xFF5E5E65),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: "Today"),
          BottomNavigationBarItem(icon: Icon(Icons.self_improvement), label: "Therapy"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
