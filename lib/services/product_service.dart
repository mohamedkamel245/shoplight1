
import 'package:shoplight/repository/repository.dart';

class ProductService{
  Repository _repository;
  ProductService(){
    _repository = Repository();
  }
  getHotProducts() async {
    return await _repository.httpGet('products.php');
  }

  getProductsByCategoryId(catId) async {
return _repository.httpGetById("productsCat.php", catId);
}
}
