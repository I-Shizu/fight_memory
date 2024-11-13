import 'dart:io';

//File型をString型に変換する関数
String? fileToString(File? file){
  return file?.path;
}
//String型をFile型に変換する関数
File? stringToFile(String? path){
  return path != null ? File(path) : null;
}