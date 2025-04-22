import 'package:flutter/material.dart';

class UserProfilePicture extends StatelessWidget {
  final String? url;

  const UserProfilePicture({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: Image.network(
            url ??"https://firebasestorage.googleapis.com/v0/b/velaris-5a288.firebasestorage.app/o/profile_pictures%2Fdefault.png?alt=media&token=d6d2a455-c6f2-4870-80ec-ff4df67d1ddd",
            fit: BoxFit.cover),
      ),
    );
  }
}
