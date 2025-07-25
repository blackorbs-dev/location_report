import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:location_report/core/util/response.dart';
import 'package:location_report/features/shared/domain/models/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../error/error.dart';

/// Picks either an image or a video. If image, overlays coordinates text and returns it.
Future<Response<String?, DataError>> pickMediaWithOverlay({
  required bool isImage,
  required LocationModel location,
}) async {
  final picker = ImagePicker();
  final XFile? file = isImage
      ? await picker.pickImage(source: ImageSource.camera)
      : await picker.pickVideo(source: ImageSource.camera);

  if (file == null) return Response.error(DataError.unknown());

  if (!isImage) return Response.success(file.path); // Return raw video without overlay

  try {
    // Read image bytes
    final bytes = await file.readAsBytes();
    final originalImage = img.decodeImage(bytes);

    if (originalImage == null) throw Exception("Invalid image format");

    // Draw coordinate text on image
    final text = 'Latitude: ${location.lat.toStringAsFixed(6)}, Longitude: ${location.long.toStringAsFixed(6)}';

    img.drawString(
      originalImage,
      text,
      font: img.arial24,
      x: 10,
      y: 10,
      color: img.ColorRgb8(255, 0, 0), // red text
    );

    // Encode modified image
    final modifiedBytes = Uint8List.fromList(img.encodeJpg(originalImage));

    // Save to temp dir
    final dir = await getTemporaryDirectory();
    final outPath = p.join(dir.path, 'overlay_${DateTime.now().millisecondsSinceEpoch}.jpg');
    final newFile = await File(outPath).writeAsBytes(modifiedBytes);

    return Response.success(newFile.path);
  } catch (e) {
    return Response.error(DataError.message('Error occurred while processing image, please try again'));
  }
}
