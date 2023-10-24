import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(crousel());
}
final List<String> imageList = [
  'https://example.com/image1.jpg',
  'https://example.com/image2.jpg',
  'https://example.com/image3.jpg',
];
class crousel extends StatelessWidget {
  const crousel({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return ListView(
      children: [
    CarouselSlider(
    items: imageList.map((imageUrl) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: 1000,
      );
    }).toList(),
    options: CarouselOptions(
    height: 400,
    enlargeCenterPage: true,
    enableInfiniteScroll: true,
    autoPlay: true,
    ),
    ),
      ],
    );

  }
}



