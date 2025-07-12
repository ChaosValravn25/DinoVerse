import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About DinoVerse")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "DinoVerse",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Dinoverse is an application coded in Flutter in which you can access a library of various Dinosaurs and answer a light trivia about data about these same to demonstrate your knowledge, the application uses API to access updated and new data about dinosaurs, along with using technology of the devices to share your favorite discovered dinos or those that catch your attention with your friends."),
            SizedBox(height: 20),
            Text("Principal Developer: Ivonne Santander Soto"),
            Text("Collaborators: Pablo Gutiérrez"),
             ],
        ),
      ),
    );
  }
}
