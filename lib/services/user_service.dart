
import 'package:shoplight/models/user.dart';
import 'package:shoplight/repository/repository.dart';

class UserService {
  Repository _repository;

  UserService(){
    _repository = Repository();
  }

  createUser(User user) async {
    return await _repository.httpPost('register.php', user.toJson());
  }

  login(User user) async {
    return await _repository.httpPost('login.php', user.toJson());
  }

}