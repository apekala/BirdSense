import 'package:flutter/material.dart';

class Img extends StatefulWidget {
  const Img({ Key? key }) : super(key: key);

  @override
  _ImgState createState() => _ImgState();
}

class _ImgState extends State<Img> {
  @override
  Widget build(BuildContext context) {
    return const Image(
      image: NetworkImage("https://img.freepik.com/free-vector/natural-landscape-background-video-conferencing_23-2148653740.jpg?size=626&ext=jpg&ga=GA1.1.1880011253.1699401600&semt=ais"),
      fit: BoxFit.cover,
      
    );
  }
}