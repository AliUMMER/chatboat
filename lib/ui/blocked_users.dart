import 'package:flutter/material.dart';

class BlockedUsers extends StatefulWidget {
  const BlockedUsers({super.key});

  @override
  State<BlockedUsers> createState() => _BlockedUsersState();
}

class _BlockedUsersState extends State<BlockedUsers> {
  final List<String> names = [
    'Devesh Ojha',
    'Fathima',
    'Sachin',
    'Mohit Tyagi',
    'Adnan',
  ];

  final List<String> profiles = [
    'assets/dp 1.png',
    'assets/dp 2.png',
    'assets/dp 3.png',
    'assets/dp 4.png',
    'assets/adnan.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          width: 467,
          height: 200,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          decoration: BoxDecoration(
            color: Color(0xff36B8B8),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(height: 38),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Blocked Contacts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: names.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(profiles[index]),
                ),
                title: Text(names[index]),
              );
            },
          ),
        ),
      ],
    ));
  }
}
