import 'package:shoplight/models/product.dart';
import 'package:shoplight/models/productModel.dart';
import 'package:shoplight/repository/repository.dart';

class CartService{
  Repository _repository;
  CartService(){
     _repository = Repository();
  }

  addToCart(ProductModel productModel) async{
    List<Map> items = await _repository.getLocalByCondition('carts', 'product_id' , productModel.product_id);
    if(items.length > 0){
      productModel.product_quantity = items.first['product_quantity'] + 1;
      return await _repository.updateLocal('carts', 'product_id', productModel.toMap());
    }
    productModel.product_quantity = 1;
    return await _repository.saveLocal('carts', productModel.toMap());
  }
  getCartItems() async {
    return await _repository.getAllLocal('carts');
  }
 deleteCartItemById(dynamic product_id) async {
    return await _repository.deleteLocalById('carts', product_id);
  }
  
}