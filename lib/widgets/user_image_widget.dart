import 'package:flutter/material.dart';

class UserImageWidget extends StatefulWidget {
  const UserImageWidget({super.key});

  @override
  State<UserImageWidget> createState() => _UserImageWidgetState();
}

class _UserImageWidgetState extends State<UserImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              border: Border.all(width: 4, color: Colors.white),
              boxShadow: const [
                BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 10,
                  color: Colors.deepPurple,
                ),
              ],
              shape: BoxShape.circle,
              image: DecorationImage(
                image: Image.asset(
                  "images/user_account.png",
                  fit: BoxFit.cover,
                ).image
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 3,
                  color: Colors.white,
                ),
                color: Colors.deepPurple,
              ),
            child: IconButton(
              padding: const EdgeInsets.only(top: 0),
              icon: const Icon(Icons.edit),
              color: Colors.white,
              onPressed: () {},
            ),
            ),
          ),
        ],
      ),
    );
  }
}