import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class CameraUploadScreen extends StatefulWidget {
  @override
  _CameraUploadScreenState createState() => _CameraUploadScreenState();
}

class _CameraUploadScreenState extends State<CameraUploadScreen> {
  late CameraController _cameraController;
  late Future<void> _cameraInitializeFuture;
  List<XFile> _capturedImages = [];

  final HttpUploadService _httpUploadService = HttpUploadService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _twitterController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _linkedInController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back,
    );

    _cameraController = CameraController(
      backCamera,
      ResolutionPreset.medium,
    );

    _cameraInitializeFuture = _cameraController.initialize();

    if (!mounted) return;

    setState(() {});
  }

  Future<void> takePicture() async {
    try {
      final XFile capturedImage = await _cameraController.takePicture();
      setState(() {
        _capturedImages.add(capturedImage);
      });
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> uploadPhotos() async {
    if (_capturedImages.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please capture at least one photo.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      return;
    }

    // Prepare the raw data for the API
    final Map<String, dynamic> rawData = {
      "name": _nameController.text,
      "userName": _userNameController.text,
      "email": _emailController.text,
      "gender": _genderController.text,
      "bio": _bioController.text,
      "dob": _dobController.text,
      "facebook": _facebookController.text,
      "twitter": _twitterController.text,
      "instagram": _instagramController.text,
      "linkedIn": _linkedInController.text,
      "location": _locationController.text,
    };

    try {
      final String response = await _httpUploadService.updateProfileWithPhotos(
        rawData,
        _capturedImages.map((image) => image.path).toList(),
      );

      // Handle the API response as needed
      print('API Response: $response');
    } catch (error) {
      // Handle errors
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Upload'),
      ),
      body: FutureBuilder(
        future: _cameraInitializeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CameraPreview(_cameraController),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: takePicture,
                      child: Text('Take Picture'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(labelText: 'Name'),
                        ),
                        TextField(
                          controller: _userNameController,
                          decoration: InputDecoration(labelText: 'Username'),
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        TextField(
                          controller: _genderController,
                          decoration: InputDecoration(labelText: 'Gender'),
                        ),
                        TextField(
                          controller: _bioController,
                          decoration: InputDecoration(labelText: 'Bio'),
                        ),
                        TextField(
                          controller: _dobController,
                          decoration: InputDecoration(labelText: 'Date of Birth'),
                        ),
                        TextField(
                          controller: _facebookController,
                          decoration: InputDecoration(labelText: 'Facebook URL'),
                        ),
                        TextField(
                          controller: _twitterController,
                          decoration: InputDecoration(labelText: 'Twitter URL'),
                        ),
                        TextField(
                          controller: _instagramController,
                          decoration: InputDecoration(labelText: 'Instagram URL'),
                        ),
                        TextField(
                          controller: _linkedInController,
                          decoration: InputDecoration(labelText: 'LinkedIn URL'),
                        ),
                        TextField(
                          controller: _locationController,
                          decoration: InputDecoration(labelText: 'Location URL'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: uploadPhotos,
                      child: Text('Upload Photos'),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class HttpUploadService {
  Future<String> updateProfileWithPhotos(
      Map<String, dynamic> rawData,
      List<String> imagePaths,
      ) async {
    // Create a multipart request
    Uri uri = Uri.parse(
        'http://ec2-16-171-182-109.eu-north-1.compute.amazonaws.com:1909/api/v1/user/updateProfile');
    var request = http.MultipartRequest('POST', uri);

    // Add images to the request
    for (var path in imagePaths) {
      request.files.add(await http.MultipartFile.fromPath('photos', path));
    }

    // Add raw data as fields in the request
    rawData.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // Add your authentication token to the 'Authorization' header
    request.headers['Authorization'] =
    'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0ZjFiZGNmMmEwNGFiYzQwMGZmYWY1ZiIsImVtYWlsIjoia2hhcWFuYWhtZGFkMTIyNUBnbWFpbC5jb20iLCJ1c2VyVHlwZSI6IlVzZXIiLCJpYXQiOjE2OTM4Mjc1ODQsImV4cCI6MTcyNTM2MzU4NH0.HIkjbpBUFkWV3NBNAZDucbVFgp_1oPtmHp-ryoPd-CU';

    try {
      // Send the request
      var response = await request.send();

      // Read the response and convert it to a string
      var responseBytes = await response.stream.toBytes();
      var responseString = utf8.decode(responseBytes);

      // Print and return the response
      print('API Response: $responseString');
      return responseString;
    } catch (error) {
      throw Exception('Failed to update user profile: $error');
    }
  }


}
