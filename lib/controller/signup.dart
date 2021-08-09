import 'package:move_in/model/user.dart';
import 'package:move_in/utilities/db_manager.dart';

class Signup{

  Future<int> saveDataInDB(User user) async
  {
    DbManager db = DbManager();
    db.createTableIfNotExists("user", "CREATE TABLE user(id INTEGER PRIMARY KEY, "
        "email varchar, "
        "password varchar, "
        "number varchar "
        ")");

    List<Map> list = await getDataList("number",user.number);
    if(list.isEmpty)
    {
      db.insert("user", user.toJson());
      return 1;
    }
    else
      return 0;

  }

  Future<List<Map>> getDataList(String fieldName, String value) async {
    DbManager db = DbManager();
    List<Map> list = await db.getRecords("SELECT * FROM user WHERE $fieldName = '$value'");
    return list==null? []: list;
  }

}