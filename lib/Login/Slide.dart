import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/screen1.jpg',
    title: 'Track Your Purchases',
    description: 'Scan your receipts to get your carbon footprint',
  ),
  Slide(
    imageUrl: 'assets/screen2.jpg',
    title: 'Measure Your Carbon Footprint',
    description: 'Our unique metric allows you to convert your purchases into easily measurable environmental impacts',
  ),
  Slide(
    imageUrl: 'assets/screen3.jpg',
    title: 'Ready To Save The World?',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
];