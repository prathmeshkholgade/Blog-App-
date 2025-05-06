import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Roundbutton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isLoading;
  const Roundbutton({
    super.key,
    required this.title,
    required this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child:
              isLoading
                  ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  )
                  : Text(title, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
