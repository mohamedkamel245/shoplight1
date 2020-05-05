import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:shoplight/models/sliderModel.dart';

Widget carouselSlider(List<SliderModel> magecarousel) {
  
    return SizedBox(
   height: 150.0,
 
        child: new Carousel(
          images: magecarousel.map(
                    (imageUrl) => Container(
                      child: Image.network(
                       imageUrl.slide_image,
                      //  "https://www.sh-oplight.com/admin_area/slides_images/"+
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                  .toList(),
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 3.0,
        dotColor: Colors.amber,
        indicatorBgPadding: 2.0,
        borderRadius: true,
      ),
);
}
