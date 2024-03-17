import 'package:animate_do/animate_do.dart';
import 'package:e_commerce/data/app_data.dart';
import 'package:e_commerce/model/base_model.dart';
import 'package:e_commerce/model/categories_model.dart';
import 'package:e_commerce/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/utils/app_theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late PageController _controller;
  @override
  void initState(){
    super.initState();
    _controller = PageController(initialPage: 2,viewportFraction: 0.7);
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //top text here
                FadeInUp(
                  delay: Duration(milliseconds: 300),
                  child: SafeArea(
                    child:
                    RichText(
                        text: TextSpan(
                      text: "Find your ",
                       style: theme.headline1,
                          children: [

                            TextSpan(
                              text: "Style",
                              style: theme.headline1?.copyWith(
                                color: primaryColor,
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ),
                  ),
                ),
                //here
                RichText(
                    text: TextSpan(
                      text: "Be more beautiful with our ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                      ),
                      children: [
                        TextSpan(
                          text: "suggestions :) ",

                        )
                      ],
                    ),
                ),
                //categories
                FadeInUp(
                  delay: Duration(milliseconds: 450),
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: size.width,
                    height: size.height*0.15,
                    color: Colors.transparent,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: categories.length,
                        itemBuilder: (ctx,index){
                          CategoriesModel current = categories[index];
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(current.imageUrl),
                                ),
                                SizedBox(height: size.height*0.005,),
                                Text(
                                  current.title,
                                  style: theme.subtitle1,
                                ),
                              ],
                            ),

                          );
                        }
                    ),
                  ),
                ),
                //here is Body

                FadeInUp(
                  delay: Duration(milliseconds: 450),
                  child: Container(
                    margin: EdgeInsets.only(top:10),
                    width: size.width,
                    height: size.height*0.45,
                    color: Colors.transparent,
                    child: PageView.builder(
                      controller: _controller,
                      physics: const BouncingScrollPhysics(),
                        itemCount: mainList.length,
                        itemBuilder: (ctx,index){
                        //here
                        //  BaseModel data = mainList[index];
                        //
                          return GestureDetector(
                              onTap: (){},
                              child: view(index,theme,size));
                  
                        }
                    ),
                  ),
                ),
                //third contaner and text
                FadeInUp(
                  delay: const Duration(milliseconds: 650),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Most Popular", style: theme.headline3),
                        Text("See all", style: theme.headline4),
                      ],
                    ),
                  ),
                ),
                ////4th container
                Container(
                  width: size.width,
                  height: size.height *0.44,
                  color: Colors.yellow,
                  child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: mainList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (ctx,index){
                        return Column(
                          children: [

                          ],
                        );
                      }
                  ),
                )


              ],

            ),
          ),
        ),
      ),

    );
  }

  /// Page View(second container ) rotate
  Widget view(int index, TextTheme theme, Size size) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double value = 0.0;
          if (_controller.position.haveDimensions) {
            value = index.toDouble() - (_controller.page ?? 0);
            value = (value * 0.04).clamp(-1, 1);
          }
          return Transform.rotate(
            angle: 5 * value,
            child: _buildCard(size,mainList[index],theme),
          );
        });
  }


  Padding _buildCard(Size size, BaseModel data, TextTheme theme) {
    return Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Column(
                          children: [
                            Container(
                             // color: Colors.amber,
                              width: size.width*0.5,
                              height: size.height*0.35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: AssetImage(data.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                      color: Color.fromARGB(61, 0, 0, 0),
                                      ),
                                  ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                data.name,
                                style: theme.headline2,
                              ),
                            ),
                            RichText(
                                text: TextSpan(
                                    text: "€",
                                    style: theme.subtitle2?.copyWith(
                                      color: primaryColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: data.price.toString(),
                                        style: theme.subtitle2?.copyWith(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ],),
                            ),
                          ],
                        ),
                      );
  }
}
//18 mint after