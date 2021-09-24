import 'package:gsheets/gsheets.dart';
import 'package:untitled1/sheetscolumn.dart';

class SheetsFlutter{
  static String _sheetId = "1nU51h6OjrjvclJ55XK5Zs4uMG6ZPGRB4OTDiXAmrHNI";
  static const _sheetCredentials = r'''
  {
  "type": "service_account",
  "project_id": "fir-flutter-960c6",
  "private_key_id": "58677fbe2b61fe7025228b5ff6ca05518ab0d597",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCfesztIVLsSF59\nfmSum3g3Zux77H2zDgXQg8giChpShG0INuQcBdUOavpLc5bDkclBcBZ6gIMBTmug\nwzl5f202MzlzLwWNqp73Nv3SAEzwfhAAFpqQVTxHumKa68F301a1HGZLThXG45k4\nXhmlEqlRd1IHMeyLf6eCZGbi2E3BJ4aqOsx07qhGpF+oEaCxDLXo0rriGLrGSSLs\nMXH24cl2qAfmjVC8txJeXcTAf/1vseE+y76IOAruIPv5PW1kOzA6o9dPPIr4z4TO\nFjuZYTCn4pY21c5TjjmY6n5YIpLEEadelOp8SyGS2f15bF/Z9ZIdexmplmAX6Q5P\nwHLwy9NDAgMBAAECggEABS/VxWqdi1DJPfSj6qfkz4x56YfmCLJOjxsSIcVJWOC0\nuR0r6xtndAoXrOeMAj1WGdo+6OoQGLVHu9lNn718vFQLLMtdN1/SvsCbnb5jwjif\nZZlWmpYjGUQfG+HKD48glVBgpVdbTvYtEA/DbsJ+Hkeus8w0YM8ckBma3Qri8IK+\n5EEOByEMI+xsAIl5dPVYGGvSsVUyQsdVs7nKtpGhMfw/WTSBgd7VVBb/5KS8MjXC\nnZ97PKwNnGbV6CqJ4Xj3A/AZEAuGxuMvEuMbqkfO13j2obofpsBxkjZ63MT9OEyO\nm4DU8zEoGH9bjPAfk2fSPiudPQg4RIpbujPnbhBWSQKBgQDdXuIv3KLI6UPEMbn1\nX0aDqprposMaM+5QHI5I4c6c2QaPvk69ISRpx2xsLxeyG8vZUQpAzOGcCT34zfyy\n0OUxK7srrlxxHZq5ZUcXgA6/5LP57PAP/YfmXJ5ZQT2xeEn75a7gK7s/qc4arSLG\nAYycMIVtrnnlcggTx2zbGs/J2QKBgQC4bWbev+vgsHs4FPEKsH/ejy1qLhztYXYW\n15/8LjICU1qRgTLH7XE+99OfWgY/ze29DvPkKVE8GImeV5PVqE/+G+0smiOPcpnd\nt3R08Rc3BObld/yEhXQ9qIEZ8y5ibrJc24K4diQ8RP21Pk37qnuebnK1z9Gtx9pX\nPq//IOWYewKBgBf/zmPD9r3zVA50GaX5Y0qo90x3AdHYaXCz99T87gphGO4CgsTM\nUAdLwHxmCpqbmtj/iS4HSDpDYj2UD15PeVmAVTViHNGClSCeUzu//VlecQiaYFhL\ncy1NQzmH8ilIUjUF7JSPCSjYvuhzdr6islzIgd6nOL3gQ/Ho/+stF/PZAoGBAKX7\n2HSrmHgtfYh42IO9XCgLBl2kyOYgLC7cu6E0Vk/fgwinlfN30M9SLoUhebRc+xWH\napuzT+hdUSZQPb4ycGQL8EaPJ2gIRVDVtps1DKa447Isbfk7PuXrTN31Do8Kf76w\n1RJ9SZlwokJHo9nXktCBKP5W3qif0PNqeO2ORvUXAoGAEoG3HTuAZmUaDIu0pu/r\nhuCTkLQxj4R0MEucpGZlmT4AV3bDA1iy2xKTJGQUsV91exEbRWKaZ2FacJzL2xLw\n7j5AaNzftqvN+DItrnQRPDLNKipDSCfP1KBcCL2sQelcZTVL0d6gKiOPospx00G8\nyiTq8rrlT/Gm/gPTDsJlcVo=\n-----END PRIVATE KEY-----\n",
  "client_email": "fluttersheets@fir-flutter-960c6.iam.gserviceaccount.com",
  "client_id": "115490624751305201701",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/fluttersheets%40fir-flutter-960c6.iam.gserviceaccount.com"
  }
''';
  static Worksheet? _userSheet;
  static final _gsheets = GSheets(_sheetCredentials);

  static Future init() async {
    try{
      final spreadsheet = await _gsheets.spreadsheet(_sheetId);

      _userSheet = await _getWorkSheet(spreadsheet, title: "Feed");
      final firstRow = SheetsColumn.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
    } catch(e) {
      print(e);
    }
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    } catch(e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }
}