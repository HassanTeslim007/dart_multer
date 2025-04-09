import 'dart:math';

String generateUniqueFilename(String originalFilename) {
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final rand = _randomString(6);
  return '${timestamp}_$rand$originalFilename';
}

String _randomString(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final rand = Random.secure();
  return List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
}
