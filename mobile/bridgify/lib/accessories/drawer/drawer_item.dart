import 'package:bridgify/services/shared_service.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String path;
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (title == 'Log out') {
          SharedService.logout(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 40,
            ),
            GestureDetector(
              onTap: () {
                if (path != "") {
                  Navigator.pushNamed(context, path);
                }
              },
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
