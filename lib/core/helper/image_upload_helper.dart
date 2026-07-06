import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

abstract class ImageUploadHelper {
  Future<String> uploadImage({required File file, required String path});
}

class ImageUploadHelperImp implements ImageUploadHelper {
  @override
  Future<String> uploadImage({required File file, required String path}) async {
    const String cloudName = "drrnlolvq";
    const String uploadPreset = "profile_preset";

    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..fields['public_id'] = path
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      return jsonMap['secure_url'];
    } else {
      throw Exception("Failed to upload image to Cloudinary");
    }
  }
}
