import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(userProvider.profileImageUrl),
          ),
          const SizedBox(width: 10),
          Text(
            userProvider.username,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

