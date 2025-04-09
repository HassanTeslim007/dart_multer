import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'file_saver.dart';

/// Middleware that extracts and stores files from multipart/form-data requests.
/// Adds them to `context.extra['uploadedFiles']` as Map`<String, File>`.
///
Middleware fileUploadMiddleware({
  required List<String> fields,
  bool keepFile = false,
  String? directory,
}) {
  return (handler) => (context) async {
    final request = context.request;

    // Only handle multipart/form-data POST/PUT
    if ((request.method == HttpMethod.post ||
            request.method == HttpMethod.put) &&
        request.headers['content-type']?.contains('multipart/form-data') ==
            true) {
      final formData = await request.formData();
      final files = <String, File>{};

      for (final field in fields) {
        final uploaded = formData.files[field];
        if (uploaded != null) {
          final file = await MultipartFileSaver.saveToFile(
            uploaded,
            keepFile: keepFile,
            directory: directory,
          );
          files[field] = file;
        }
      }

      final updatedContext = context.provide<Map<String, File>>(() => files);
      return handler(updatedContext);
    }

    return handler(context);
  };
}
