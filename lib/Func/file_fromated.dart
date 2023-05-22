import 'dart:convert';
import 'dart:io';

String? convertFileToBase64(File? file) {
  if (file == null) return null;
  return base64Encode(file.readAsBytesSync());
}