import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:dart_frog/dart_frog.dart'; // for UploadedFile
import '../utils/filename_generator.dart';

class MultipartFileSaver {
  static Future<File> saveToFile(
    UploadedFile uploadedFile, {
    bool keepFile = false,
    String? filename,
    String? directory,
  }) async {
    final dir = directory ?? Directory.systemTemp.path;
    final saveFilename = filename ?? generateUniqueFilename(uploadedFile.name);
    final filePath = p.join(dir, saveFilename);
    final file = File(filePath);

    await file.writeAsBytes(await uploadedFile.readAsBytes());

    if (!keepFile) {
       if (!keepFile) {
      // Register a cleanup hook
      _fileFinalizer.attach(file, file, detach: file);
    }
    }

    return file;
  }
}


final _fileFinalizer = Finalizer<File>((file) {
  if (file.existsSync()) {
    file.deleteSync();
  }
});