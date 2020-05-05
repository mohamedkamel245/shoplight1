

import 'package:shoplight/models/shipping.dart';
import 'package:shoplight/repository/repository.dart';

class ShippingService {
  Repository _repository;

  ShippingService(){
    _repository = Repository();
  }

  addShipping(Shipping shipping) async {
    return await _repository.httpPost('catr_item.php', shipping.toJson());
  }
}