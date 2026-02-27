import 'package:anime_tracker/features/authentication/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/spider.png', height: 40),
            const SizedBox(width: 8),
            const Text('ANIWEB'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
          )
        ],
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 150,
                color: Colors.blue,
              ),
            ],
          ),
          const Text(
            'Username',
            style: TextStyle(
                letterSpacing: 3,
                fontSize: 22,
                fontFamily: 'WorkSans',
                color: Colors.black),
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          const Text(
            'Liked:',
            style: TextStyle(
                letterSpacing: 3,
                fontSize: 16,
                fontFamily: 'WorkSans',
                color: Colors.black),
          ),
          const Padding(padding: EdgeInsets.only(top: 25)),
          Expanded(
              child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const ListTile(
                title: Text(
                  'Anime',
                  textAlign: TextAlign.center,
                ),
              );
            },
          )),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const AuthGate()),
                (route) => false,
              );
            },
            child: const Text('Выйти'),
          )
        ],
      ),
    );
  }
}
