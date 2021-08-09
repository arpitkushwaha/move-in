import 'package:move_in/model/user.dart';
import 'package:move_in/utilities/db_manager.dart';

class LoginController{

  Future<Map> login(User user) async
  {

    List<Map> list = await checkLogin(user.number, user.password);
    if(list.isEmpty)
    {
      return null;
    }
    else
      return list[0];
  }

  Future<List<Map>> checkLogin(String number, String password) async {
    DbManager db = DbManager();
    List<Map> list = await db
        .getRecords("SELECT * FROM user WHERE number='$number' AND password='$password'");
    return list==null? []: list;
  }
}