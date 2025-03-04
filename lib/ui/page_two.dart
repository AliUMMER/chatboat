import 'package:chatboat/ui/page_three.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
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
              Container(
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
          Text('If you are confused about',
              style: TextStyle(color: Color(0xff191919), fontSize: 40)),
          Text('what to do just open',
              style: TextStyle(color: Color(0xff191919), fontSize: 40)),
          Text('Chatboat app',
              style: TextStyle(color: Color(0xff191919), fontSize: 40)),
          SizedBox(
            height: 190,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PageThree()),
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
