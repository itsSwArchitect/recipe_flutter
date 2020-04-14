import 'package:flutter/material.dart';
import 'package:recipe_flutter/Tiles/tiles.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_flutter/Services/recipe_model.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'dart:math';
import 'package:recipe_flutter/Services/admobads.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textEditingController = new TextEditingController();

  //Ads
  Ads ads = Ads();
  //
  bool isShow = false;
  final String applicationKeys = '340a5d376e9d804135d99e284ea109a4';
  final applicationId = 'dc3a4c01';

  List<RecipeModel> recipes = new List<RecipeModel>();

  getRecipe(String query) async {
    print("$query Quary");
    isShow = false;
    recipes.clear();
    String url =
        "https://api.edamam.com/search?q=$query&app_id=dc3a4c01&app_key=340a5d376e9d804135d99e284ea109a4";

    var response = await http.get(url);

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    jsonData['hits'].forEach((elements) {
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(elements['recipe']);
      recipes.add(recipeModel);
    });

    print(recipes[0].lable);
    isShow = true;
    setState(() {});
  }

  //BackButton
  Future<bool> _backButton() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Are you sure?'),
            content: Text(
              'Exit the application???',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  void initState() {
    List<String> categ = [
      'Appetizers',
      'Beverages',
      'Soups',
      'Salads',
      'Vegetables',
      'Breads',
      'Rolls',
      'Desserts',
      'Miscellaneous'
    ];

    Random random = new Random();
    int ranInt = random.nextInt(categ.length - 1);

    getRecipe(categ[ranInt]);

    //ads
    ads.initalizeAndBanner();

    super.initState();
  }

  @override
  void dispose() {
    print('Called on dispose');
    ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: _backButton,
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).copyWith().size.width,
                height: MediaQuery.of(context).copyWith().size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0xffFF9999),
                  Color(0xffFF6666),
                ])),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Delicious ",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "Recipes",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Search Your favorite Food',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        'Enter the name of Food and We will show you how to cook',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: TextField(
                              controller: textEditingController,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              decoration: InputDecoration(
                                hintText: 'Enter Ingrident',
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 18),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                            )),
                            SizedBox(
                              width: 16,
                            ),
                            InkWell(
                              onTap: () {
                                ads.showInterstitialAd();
                                if (textEditingController.text.isNotEmpty) {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    getRecipe(textEditingController.text);
                                  });
                                } else {
                                  print('Text is Null');
                                }
                              },
                              child: Container(
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: GridView(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    mainAxisSpacing: 10.0,
                                    maxCrossAxisExtent: 200.0),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: ClampingScrollPhysics(),
                            children: List.generate(recipes.length, (index) {
                              return GridTile(
                                  child: RecipieTile(
                                title: recipes[index].lable,
                                imgUrl: recipes[index].image,
                                desc: recipes[index].source,
                                url: recipes[index].url,
                              ));
                            })),
                      ),
                      !isShow
                          ? JumpingText(
                              'Loading...',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          : Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
