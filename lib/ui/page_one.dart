import 'package:chatboat/ui/page_two.dart';
import 'package:chatboat/ui/register.dart';
import 'package:flutter/material.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffffff),
      body: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          Row(
            children: [
              SizedBox(
                width: 395,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: Container(
                  width: 70,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color(0xff36B8B8)),
                  child: Center(
                    child: Text(
                      'Skip',
                      style: TextStyle(color: Color(0xff191919), fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 60,
          ),
          Center(
            child: Container(
              width: 350,
              height: 350,
              child: Image(image: AssetImage('assets/image 19.png')),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Text('Welcome to chatboat,',
              style: TextStyle(color: Color(0xff191919), fontSize: 40)),
          Text('a great friend to chat',
              style: TextStyle(color: Color(0xff191919), fontSize: 40)),
          Text('with you',
              style: TextStyle(color: Color(0xff191919), fontSize: 40)),
          SizedBox(
            height: 190,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PageTwo()),
              );
            },
            child: Container(
              width: 350,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color(0xff36B8B8)),
              child: Center(
                child: Text('Next',
                    style: TextStyle(color: Color(0xffFFFFFF), fontSize: 28)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
