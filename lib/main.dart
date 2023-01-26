import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
//for select image and store the path in a xFile list
  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    //check if its not empty
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());

    //and seting the state
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Multiple Images'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              //button for image selection
              ElevatedButton(
                onPressed: () {
                  selectImages();
                },
                child: const Text('Select Images'),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    //List view to rendar the image
                    child: ListView.builder(
                        itemCount: imageFileList!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            //ondouble tap for remove single image from the list
                            onDoubleTap: () {
                              setState(() {
                                imageFileList!.removeAt(index);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),

                              //finally shoing the image to the user
                              child: Image.file(
                                File(imageFileList![index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        })),
              ),
            ],
          ),
        ));
  }
}
