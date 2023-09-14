import 'package:flutter/material.dart';


import 'filepivker.dart'; // Import the widget



class Callimagepicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Picker Example'),
        ),
        body: Center(
          child: ImagePickerBigWidget(
            heading: 'Select an Image',
            description: 'Choose an image for your profile.',
            onPressed: () {
              // Define the action you want to take when the button is pressed
              // This could involve showing a file picker, handling image selection, etc.
              // You can customize this behavior according to your needs.
            },
            platformFile: null, // Pass the PlatformFile if available, otherwise use null
            imgUrl: 'https://example.com/your-image.jpg', // Provide an image URL if available
          ),
        ),
      ),
    );
  }
}
