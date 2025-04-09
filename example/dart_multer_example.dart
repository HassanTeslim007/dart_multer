import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_multer/dart_multer.dart';

Handler middleware(Handler handler) {
  //use Middleware
  return fileUploadMiddleware(fields: ['avatar'])(handler);
}


Future<Response> onRequest(RequestContext context) async {
  final uploadedFiles = context.read<Map<String, File>>();
  final avatar = uploadedFiles['avatar'];

  if (avatar == null) {
    return Response.json(statusCode: 400, body: {'error': 'Missing avatar file'});
  }

  // You now have a dart:io File
  final fileSize = await avatar.length();



  return Response.json(body: {
    'message': 'File received',
    'filename': avatar.path,
    'size': fileSize,
  });
}
