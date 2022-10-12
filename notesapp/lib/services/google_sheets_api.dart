import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "flutter-sticky-notes",
  "private_key_id": "5ec675f5e25d13adda1e5773dde94e9e7a35b8e8",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCScpvbCnKAbWFU\nsBUpJek5IkvtnhgS41JXCeAMH3A27z7hEVa7LvJZ62KduXWe60NGFZlrzyBh8PhR\nSropsbzDAZ6Iqa92zavXeL475wKg+hAnvpqbv+REzsmkyc5ntZHSyFelIDs53Nvd\neZpIKS77bs9jtk1n5yuDLtDCvPlFIHRQ245j6wiCu1tdLFIf1u88af+YF9uToM0f\nLvLYij7KJ7arJWzgndAteg2wj0a5lymD0KPgry9dju5MZPIO8peZXEZLlHTOYK/w\nCxzbImIV7X+7e1s7+2ZPXCQh2+ah7q4XMlwvwCfNtGLSigxZd/Nv+ndUsPqFI0gH\nM9FvdZWJAgMBAAECggEADAe3ayTWb1uc4lu1H0xWlmuNdHN3W4zaOZ1tbt2Bxrd8\nUTmPCAElJjMWhqmiooeFvxr834z0JmuIwIfMl2p6/MN0KhqTWAVw83o/GVVio0Xr\ngBJRqc/3gNoCWUO9LYqONDQiNAW768bLdmv7+yfL7NpnVbP28507NzNoMYkbynxu\nSDNgE5ETSpyMPW1CjeqkdmV2nOFJCtmGXZ8uI3fzvYqd3ENjHfqAnLmY5E93e/yQ\nYbcJst7zMH7zacPhYmMYWr3hJIsenuvkhhRNDJgTBSVU6UegpmcwSAu9z+gxMyDO\n3NrNZXe2KW0hTNvO9K9/+JvfoOrD0+ZGsWubhnFBwQKBgQDNLhQLBQ9CSufqhYdn\nE/5VJr4e2AfZaHk0foW6BvjrNarLcEODZqKCyGLcLzy2YYdyu495SpwmOUld16Vz\nMudIkMN9oRdHLx53Zph7w9oHCGWsA+nyhqRVsT/8e2sx17AZgd3uMfYwmMyHmzkA\nPJpNiChHrFHHtTNx3n1V2TxCwQKBgQC2uHhi0Xr4z15gNNnu4jSPgKj7mDmerByG\nNlJSJo5QmjgCZjhNF3L0pxyrC6aiCRBhSf205PegErNgjKcMAnwT56yNkCCBFEPD\nT8guLPRQjqh2aNm1aFsUh4uwH0TIAmiRo6cfMQPDsJjo7edUwo+9PH//8A+b9v1X\nvuJjKqwsyQKBgEa8dgh+jA4syNufgVjWGb69hpoXnE0lqXOhkvTZZoOgkutkHsJ0\nZd50uzBx0JqH8Sxq4UHNqRu8cEC8EbwvdnEcB2mOWfoekoBTjIpOsSHvkS3Gg6cr\nKAiq/QZMfl5Gn92LWjm+W8PRSeIOb45XVlMYd9qN2/vfyoadT9SC+jWBAoGBAIB8\nDwtNym8TQoXcJDM6lUMjcbAZRssws44cvJ5PxlsfVqs5PfXXu1oV+K6+LppaTU5c\nPS7qosXI4KHPxddIF//XNRsGchTSLyQ0AcuWiOXsqsE40X4it4kkFzHtiuwp5WYj\n8eyZBtCgaaXBRJ3xginLVSafpBpD/7mn3IFnDFMhAoGAfmfBcGSmCvR2Htb9sla9\n25x2kFy5A0Wxdy6uwbcc03kAnvYIqncUsWOEK/szS4MDx5yZ7yQ0gnwIdzKRblro\nQt+eReRXMpUQAcJ7C3+mWcUgBCi8+iy7zyBdDlsbCxRUuKOzMb0p7UfSBv+wkmUu\n/1AVwFvbBRan7zHQS5kZY7s=\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-sticky-notes@flutter-sticky-notes.iam.gserviceaccount.com",
  "client_id": "106380137435562572344",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-sticky-notes%40flutter-sticky-notes.iam.gserviceaccount.com"
}
''';

//* set up & connect the spreadsheet
  static const spreadsheetId = "1qCVFAZSCWtYaYcVg4AWa9vRkEMLlgjAsaRfuyBcdq3s";
  static final gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

//* variables
  static int numberOfNotes = 0;
  static List<String> currentNotes = [];
  static bool loading = true;

//* spreadsheet init
  Future init() async {
    final spreadsheet = await gsheets.spreadsheet(spreadsheetId);
    _worksheet = spreadsheet.worksheetByTitle("Notes");
    countRows();
  }

  // count a number of notes
  static Future countRows() async {
    while (
        (await _worksheet!.values.value(column: 1, row: numberOfNotes + 1)) !=
            "") {
      numberOfNotes++;
    }
    loadNotes();
  }

  // load existing notes from spreadsheet
  static Future loadNotes() async {
    if (_worksheet == null) return;

    for (int i = 0; i < numberOfNotes; i++) {
      final String newNote =
          await _worksheet!.values.value(column: 1, row: i + 1);
      if (currentNotes.length < numberOfNotes && newNote != "") {
        currentNotes.add(newNote);
      }
    }

    loading = false;
  }

  // insert a new note
  static Future insert(String note) async {
    if (_worksheet == null) return;
    numberOfNotes++;
    currentNotes.add(note);
    await _worksheet?.values.appendRow([note]);
  }
}
