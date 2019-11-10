import 'package:flutter/material.dart';

import 'Slide.dart';

class SlideItem extends StatelessWidget {
  final int index;
  final int last_index = 2;
  final double title_font = 32;
  SlideItem(this.index);

  _buildContent(context, index) {
    if (index != last_index) {
      return [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(slideList[index].imageUrl),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          slideList[index].title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: title_font,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          slideList[index].description,
          textAlign: TextAlign.center,
        )
      ];
    } else {
      // LAST SLIDE
      return [
        Text(
          slideList[index].title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: title_font,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(slideList[index].imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: FlatButton(
            child: Text(
              'Log In',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.all(15),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed('/home');
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account?',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            FlatButton(
              child: Text(
                'Sign up',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
            ),
          ],
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildContent(context, this.index),
    );
  }
}
