import 'package:flutter/material.dart';

Widget customImage({required image}) {
  return Image.asset(
    image,
    fit: BoxFit.fill,
  );
}
