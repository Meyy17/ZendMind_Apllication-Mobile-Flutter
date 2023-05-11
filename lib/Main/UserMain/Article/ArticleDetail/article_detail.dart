import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({Key? key}) : super(key: key);

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              child:
                  Image.asset('Assets/Picture/Svg/ArticleDetailFill.png'),
            ),
            Container(
              width: double.infinity,
              height: 570,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24, left: 24),
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
              ),
              width: 50,
              height: 50,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 300, left: 24),
              child: Text(
                'Mental',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
              ),
              width: 150,
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(top: 350, left: 24),
              child: Text(
                'Taking care of your Mental Health is important.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 420, left: 24),
              child: Row(
                children: [
                  Text(
                    'Trending',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    '•',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    '6 Hours ago',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 470),
              child: Container(
                padding: EdgeInsets.only(top: 36, left: 40, right: 40),
                alignment: Alignment.topLeft,
                height: 330,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 25,
                          ),
                          SizedBox(width: 20,),
                          Text(
                              'Source Name',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                          SizedBox(width: 10,),
                          Icon(
                            Icons.verified,
                            size: 30,
                            color: Colors.blue,
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras condimentum diam a dui faucibus eleifend vitaenec purus. Mauris dolor nunc, malesuada ut tortor nec,vulputate tempus mauris. Vivamus lacinia nisi tortor,nec vulputate eros iaculis ut. Duis semper at nisi idfringilla. Ut pharetra tincidunt nisl varius hendrerit. Nullamquis sem nec dolor pellentesque maximus et sed purus. Integer fermentum porta odio sit amet aliquet. ',
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras condimentum diam a dui faucibus eleifend vitaenec purus. Mauris dolor nunc, malesuada ut tortor nec,vulputate tempus mauris. Vivamus lacinia nisi tortor,nec vulputate eros iaculis ut. Duis semper at nisi idfringilla. Ut pharetra tincidunt nisl varius hendrerit. Nullamquis sem nec dolor pellentesque maximus et sed purus. Integer fermentum porta odio sit amet aliquet. ',
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras condimentum diam a dui faucibus eleifend vitaenec purus. Mauris dolor nunc, malesuada ut tortor nec,vulputate tempus mauris. Vivamus lacinia nisi tortor,nec vulputate eros iaculis ut. Duis semper at nisi idfringilla. Ut pharetra tincidunt nisl varius hendrerit. Nullamquis sem nec dolor pellentesque maximus et sed purus. Integer fermentum porta odio sit amet aliquet. ',
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
          ],

        ),

      ]),
    );
  }
}