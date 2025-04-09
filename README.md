# Dart Multer - A Dart Utility for File Uploads

`Dart Multer` is a backend-agnostic Dart utility inspired by the popular `Multer` npm package. It simplifies the handling of file uploads by converting `UploadedFile` objects into usable `dart:io File` objects. The utility temporarily saves these files to disk and supports middleware integration for frameworks like Dart Frog and Shelf.

## Features

- Converts `UploadedFile?` into a temporary `dart:io File`.
- Saves files to disk with customizable file names and directories.
- Integrates as middleware for Dart Frog and Shelf frameworks.
- Optional file cleanup after processing.
- Provides an easy API to handle file uploads in Dart-based backends.

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  dart_multer: ^0.1.0
```

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage
### Save File to Disk
Use DartMulter.saveToFile() to save an UploadedFile to disk.

```dart
import 'dart:io';
import 'package:dart_multer/dart_multer.dart';

Future<void> saveUploadedFile(UploadedFile uploadedFile) async {
  try {
    File file = await DartMulter.saveToFile(uploadedFile);
    print('File saved to: ${file.path}');
  } catch (e) {
    print('Error saving file: $e');
  }
}
```

### Middleware for Dart Frog
DartMulter.fileUploadMiddleware() can be used in Dart Frog to handle file uploads automatically.

```dart
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_multer/dart_multer.dart';

Handler middleware(Handler handler) {
  return handler
      .use(DartMulter.fileUploadMiddleware(fields: ['avatar', 'resume']))
      .handler;
}
```

### Customization Options
- keepFile: Set to true if you want the uploaded files to persist beyond the request.

- filename: Provide a custom filename for the uploaded file.

- directory: Specify a custom directory to save the file, otherwise it will be saved in the system’s temporary directory.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.