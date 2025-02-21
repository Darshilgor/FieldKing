import 'dart:io';
import 'package:flutter/services.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleDriveService {
  static const String folderId = "1iOVhfnUWi30lTTVnivlIR5ZhWaZyr4kY";

  Future<drive.DriveApi> _getDriveApi() async {
    final serviceAccountJson =
        await rootBundle.loadString("assets/files/credential.json");
    final credentials =
        ServiceAccountCredentials.fromJson(json.decode(serviceAccountJson));

    final client = await clientViaServiceAccount(
        credentials, [drive.DriveApi.driveFileScope]);
    return drive.DriveApi(client);
  }

  Future<String?> uploadProfileImage(File file) async {
    final driveApi = await _getDriveApi();
    var fileStream = file.openRead();
    var media = drive.Media(fileStream, file.lengthSync());

    var driveFile = drive.File();
    driveFile.name = "profile_${DateTime.now().millisecondsSinceEpoch}.jpg";
    driveFile.parents = [folderId];

    final uploadedFile = await driveApi.files.create(
      driveFile,
      uploadMedia: media,
    );

    if (uploadedFile.id == null) {
      print("Upload failed.");
      return null;
    }

    await _setFilePublic(uploadedFile.id!, driveApi);
    String fileUrl = "https://drive.google.com/uc?id=${uploadedFile.id}";
    print("Uploaded Profile Image URL: $fileUrl");

    return fileUrl;
  }

  Future<void> _setFilePublic(String fileId, drive.DriveApi driveApi) async {
    var permission = drive.Permission()
      ..type = "anyone"
      ..role = "reader";
    await driveApi.permissions.create(permission, fileId);
  }
}
