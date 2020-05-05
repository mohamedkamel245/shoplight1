
import 'package:shoplight/repository/repository.dart';

class CategoryService{
  Repository _repository;
  CategoryService(){
    _repository = Repository();
  }
  getCategory() async {
    return await _repository.httpGet('categories.php');
  }
}