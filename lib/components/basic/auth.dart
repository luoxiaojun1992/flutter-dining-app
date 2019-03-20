import 'package:dining/components/basic/sqlite.dart';

class Auth {
  static String apiToken;

  static getToken() async {
    if (apiToken == null) {
      List<Map<String, dynamic>> result =
          await Sqlite.query('SELECT * FROM credential WHERE id = ?', [1]);
      if (result != null && result.length > 0) {
        return result[0]['token'];
      }
    }

    return apiToken;
  }

  static setToken(String token) async {
    List<Map<String, dynamic>> result =
        await Sqlite.query('SELECT * FROM credential WHERE id = ?', [1]);
    if (result != null && result.length > 0) {
      Sqlite.update('UPDATE credential SET token = ? WHERE id = ?', [token, 1]);
    } else {
      Sqlite.insert('INSERT INTO credential(token) VALUES(?)', [token]);
    }

    apiToken = token;
  }
}
