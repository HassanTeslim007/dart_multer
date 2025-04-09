import 'dart:io';
import 'package:test/test.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_multer/dart_multer.dart';

void main() {
  group('MultipartFileSaver', () {
    test('saves UploadedFile to a dart:io File', () async {
      final content = 'hello, world'.codeUnits;
      final uploadedFile = UploadedFile(
        'name',
        ContentType.text,
        Stream.fromIterable([content]),
      );

      final file = await MultipartFileSaver.saveToFile(
        uploadedFile,
        keepFile: true,
      );

      expect(file.existsSync(), isTrue);
      expect(file.readAsStringSync(), equals('hello, world'));

      // Clean up manually since we set keepFile: true
      await file.delete();
    });
  });
}
