import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

 @override
  Widget build(BuildContext context) {
    final color = Color.fromARGB(255, 251, 227, 235);

    return Center(
      child: Stack(
        children: [
          buildImage(color),
          Positioned(
            child: buildEditIcon(color, context),
            right: 4,
            top: 10,
          ),
        ],
      ),
    );
  }

  Widget buildImage(Color color) {
    final image = (imagePath != null && imagePath.isNotEmpty)
        ? (imagePath.contains('https://') ? NetworkImage(imagePath) : FileImage(File(imagePath)))
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

  Widget buildEditIcon(Color color, BuildContext context) => buildCircle(
        child: IconButton(
          icon: Icon(
            Icons.edit,
            color: color,
            size:20,
          ),
          onPressed: () {
            _pickImage(context);
          },
        ),
      );

  Widget buildCircle({
    required Widget child,
  }) =>
      ClipOval(
        child: Container(
          color: const Color.fromARGB(255, 231, 236, 236),
          child: child,
        ),
      );

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imagePath = pickedFile.path;
    }
  }
}