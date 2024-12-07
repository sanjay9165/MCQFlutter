import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?>imagePicking(ImageSource imageSource)async{
  final pickedFile=await ImagePicker().pickImage(source: imageSource,imageQuality: 30);
  if(pickedFile!=null){
    return File(pickedFile.path);
  }
  return null;
}