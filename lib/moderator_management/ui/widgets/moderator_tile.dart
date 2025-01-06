import 'package:flutter/material.dart';
import 'package:oaap/access_management/data/user_model.dart';

class MyModeratorTile extends StatelessWidget {
  final User user;

  const MyModeratorTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        
          child:ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Email:'),
                      Text(user.email, style: const TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Role:'),
                      Text(user.role, style: const TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis,)
                    ],
                  ), 
                ],
              ),
            ),
        
      ),
    );
  }

}