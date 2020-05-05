class SliderModel {
  String slide_id;
  String slide_image;
 

  SliderModel(
      {this.slide_id,
      this.slide_image,
      });

 factory SliderModel.fromJson(Map<String, dynamic> json) {
   return SliderModel(slide_id: json['slide_id']  as String,
   slide_image: json['slide_image'] as String,
  );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slide_id'] = this.slide_id;
    data['slide_image'] = this.slide_image;
   
    return data;
  }
}
