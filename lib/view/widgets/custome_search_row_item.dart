import 'package:cheeta/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchRowItem extends StatelessWidget {
  final String topText, image, midText;

  CustomSearchRowItem({
    this.topText = "",
    this.image = "",
    this.midText = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(71, 13, 12, 12),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: image == ''
                                      ? AssetImage(
                                          'assets/images/default.jpg',
                                        )
                                      : NetworkImage(
                                          image,
                                        ) as ImageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              CustomText(
                                text: midText,
                                fontSize: 18,
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomText(
                                text: topText,
                                fontSize: 24,
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                height: 40,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
