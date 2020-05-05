
import 'package:shoplight/repository/repository.dart';

class SliderService{
  Repository _repository;
  SliderService(){
    _repository = Repository();
  }
  getSliders() async {
    return await _repository.httpGet('sliders.php');
  }
}