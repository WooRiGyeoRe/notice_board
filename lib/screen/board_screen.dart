import 'package:flutter/material.dart';
import 'bottom_navi_bar.dart';

// 자유&질문 게시판
class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '게시판',
          style: TextStyle(
            fontFamily: "jeongianjeon-Regular",
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(Icons.mode_edit,
                color: Color.fromARGB(255, 255, 255, 255), size: 20),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.delete,
                color: Color.fromARGB(255, 255, 255, 255), size: 20),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 185, 215, 224),
        elevation: 3,
        shadowColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: const Column(
          // children: [LoginForm()],
          ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
