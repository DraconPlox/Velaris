import 'package:flutter/material.dart';

import '../views/profile/profile_controller.dart';

class UserProfilePicture extends StatelessWidget {
  const UserProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: ProfileController().getProfilePictureUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.deepPurple,
            child: CircularProgressIndicator(color: Colors.white),
          );
        } else if (!snapshot.hasData || snapshot.hasError) {
          return const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          );
        } else {
          return CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(snapshot.data!),
          );
        }
      },
    );
  }
}
