import 'dart:io';

import 'package:blog_app/core/error/custom_exception.dart';
import 'package:image_picker/image_picker.dart';


Future<File?> pickImageFromMob () async{

  try{
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(xFile != null) {
      return File(xFile.path);
    } else {
      return null;
    }
  }
  catch (e) {
    throw CustomException("Image is not picked");
  }
}


