import 'dart:io';
import 'package:flutter/material.dart';

class DisplayImage extends StatefulWidget {
  final String imagePath;
  final VoidCallback onPressed;

  DisplayImage({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  _DisplayImageState createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
 
  @override
  Widget build(BuildContext context) {
    final color = Color.fromARGB(255, 251, 227, 235);

    return Center(
      child: Stack(
        children: [
          buildImage(color),
         
        ],
      ),
    );
  }

  Widget buildImage(Color color) {
    final image = (widget.imagePath != null && widget.imagePath.isNotEmpty)
        ? (widget.imagePath.contains('https://') ? NetworkImage(widget.imagePath) : FileImage(File(widget.imagePath)))
        : AssetImage('assets/img/NoImg.jpg');
    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: image as ImageProvider,
        radius: 70,
      ),
    );
  }

}