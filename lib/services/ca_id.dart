import 'package:shoplight/repository/repository.dart';

class CaidService{
  Repository _repository;
  CaidService(){
    _repository = Repository();
  }
  getCategory() async {
    return await _repository.httpgtr('');
  }
}