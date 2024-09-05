import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:furniture_app/model/category_model.dart';
import 'package:furniture_app/screens/cart_screen.dart';
import 'package:video_player/video_player.dart';

class ProductScreen extends StatefulWidget {
  final CategoryModel model;

  ProductScreen(this.model);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List images = [], similarImages = [];
  List<int> colorList = [0xFF304B82, 0xFFBB4747, 0xFFF8C184, 0xFF5ABE65];
  int selectedColorIndex = 0,
      scrolledImageIndex = 0,
      selectedSimilarColorIndex = 0;

  int purchaseCount = 1;

  // video controller
  late VideoPlayerController _videoController;
  bool _isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(
        "assets/videos/demo_video.mp4") // Add your video asset path
      ..initialize().then((_) {
        setState(() {}); // Ensure the video is initialized before rendering
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  Widget getColors(int index) {
    return GestureDetector(
      onTap: () {
        selectedColorIndex = index;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(5),
        width: 31,
        height: 31,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedColorIndex == index
                ? Color(colorList[index])
                : Colors.white,
            width: 1,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(31),
        ),
        child: Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: Color(colorList[index]),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget getSimilarColorImage(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSimilarColorIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        margin: EdgeInsets.only(top: 2, bottom: 2, right: 20),
        width: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFFE7EEF8),
              blurRadius: 1,
              offset: Offset(2.6, 2.6),
            ),
          ],
          border: Border.all(
              width: 1.5,
              color: selectedSimilarColorIndex == index
                  ? Colors.indigo
                  : Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/${similarImages[index]}"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    images = widget.model.differentImageUrl.keys.toList();
    similarImages = widget.model.differentImageUrl[images[scrolledImageIndex]]!;
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              //Custom App Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFE7EEF8),
                            blurRadius: 4,
                            offset: Offset(0.6, 0.7),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Icon(Icons.keyboard_backspace),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartScreen(),
                              ));
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFE7EEF8),
                                blurRadius: 4,
                                offset: Offset(0.6, 0.7),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Icon(Icons.local_grocery_store),
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFE7EEF8),
                                blurRadius: 4,
                                offset: Offset(0.6, 0.7),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Icon(Icons.more_vert),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Image Show
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 28),
                    // images and colors
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Image SlideShow
                        Expanded(
                          flex: 12,
                          child: Stack(
                            children: [
                              Container(
                                height: 220,
                                padding: EdgeInsets.symmetric(vertical: 30),
                                decoration: BoxDecoration(
                                  color:
                                      Colors.white, // Set background to white
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFE7EEF8),
                                      blurRadius: 1,
                                      offset: Offset(4.6, 4.6),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      20), // Make the container curved
                                ),
                                child: PageView.builder(
                                  itemCount: images.length,
                                  controller:
                                      PageController(viewportFraction: 0.55),
                                  onPageChanged: (i) => setState(() {
                                    selectedSimilarColorIndex = 0;
                                    purchaseCount = 0;
                                    scrolledImageIndex = i;
                                  }),
                                  itemBuilder: (_, i) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Image.asset(
                                        "assets/images/${images[i]}.png",
                                        height: 90,
                                        width: 90,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned.directional(
                                end: 15,
                                top: 15,
                                textDirection: TextDirection.ltr,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFFE3EFFE),
                                          blurRadius: 1,
                                          offset: Offset(3.6, 1.6),
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(Icons.favorite_border),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        // Colors List
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 220,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFE7EEF8),
                                  blurRadius: 1,
                                  offset: Offset(2.6, 2.6),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(45),
                                bottomLeft: Radius.circular(45),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: colorList
                                    .asMap()
                                    .entries
                                    .map((MapEntry map) => getColors(map.key))
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28),
                    // video player code
                    _videoController.value.isInitialized
                        ? Column(
                            children: [
                              AspectRatio(
                                aspectRatio: _videoController.value.aspectRatio,
                                child: VideoPlayer(_videoController),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(_isVideoPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow),
                                    onPressed: () {
                                      setState(() {
                                        if (_isVideoPlaying) {
                                          _videoController.pause();
                                        } else {
                                          _videoController.play();
                                        }
                                        _isVideoPlaying = !_isVideoPlaying;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),

                    // similar images
                    SizedBox(height: 28),
                    Container(
                      height: 70,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: similarImages
                            .asMap()
                            .entries
                            .map(
                                (MapEntry map) => getSimilarColorImage(map.key))
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 28),
                    // (Product Details) Are Listed Here
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Product Details and Purchase Count
                        Expanded(
                          flex: 12,
                          child: Container(
                            height: 200,
                            padding: EdgeInsets.symmetric(vertical: 30),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFE7EEF8),
                                  blurRadius: 4,
                                  offset: Offset(4.6, 4.6),
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(90),
                                bottomLeft: Radius.circular(90),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.model.fullName,
                                  style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 7),
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 30,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4),
                                  onRatingUpdate: (rating) {},
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  widget.model.price,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        // Purchase Count
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFE7EEF8),
                                  blurRadius: 1,
                                  offset: Offset(2.6, 2.6),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(65),
                                topRight: Radius.circular(65),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (purchaseCount > 1) {
                                        purchaseCount -= 1;
                                      } else {
                                        purchaseCount = 1;
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      child: Icon(
                                        Icons.remove,
                                        size: 30,
                                        color: purchaseCount < 2
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    child: Center(
                                      child: Text(
                                        purchaseCount.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        purchaseCount += 1;
                                      });
                                    },
                                    child: Container(
                                      child: Icon(
                                        Icons.add,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              widget.model.description,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        height: 60,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(55),
                              bottomRight: Radius.circular(55),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFE7EEF8),
                                blurRadius: 1.0,
                                offset: Offset(2.6, 2.6),
                              ),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart, color: Colors.white),
                            Text(
                              "Add to Cart",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:furniture_app/model/category_model.dart';

class ProductScreen extends StatefulWidget {
  final CategoryModel model;

  ProductScreen(this.model);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List images = [], similarImages = [];
  List<int> colorList = [0xFF304B82, 0xFFBB4747, 0xFFF8C184, 0xFF5ABE65];
  int selectedColorIndex = 0,
      scrolledImageIndex = 0,
      selectedSimilarColorIndex = 0;

  int purchaseCount = 1;

  Widget getColors(int index) {
    return GestureDetector(
      onTap: () {
        selectedColorIndex = index;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(5),
        width: 31,
        height: 31,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedColorIndex == index
                ? Color(colorList[index])
                : Colors.white,
            width: 1,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(31),
        ),
        child: Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: Color(colorList[index]),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget getSimilarColorImage(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSimilarColorIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        margin: EdgeInsets.only(top: 2, bottom: 2, right: 20),
        width: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFFE7EEF8),
              blurRadius: 1,
              offset: Offset(2.6, 2.6),
            ),
          ],
          border: Border.all(
              width: 1.5,
              color: selectedSimilarColorIndex == index
                  ? Colors.indigo
                  : Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/${similarImages[index]}"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    images = widget.model.differentImageUrl.keys.toList();
    similarImages = widget.model.differentImageUrl[images[scrolledImageIndex]]!;
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              //Custom App Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFE7EEF8),
                            blurRadius: 4,
                            offset: Offset(0.6, 0.7),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Icon(Icons.keyboard_backspace),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFE7EEF8),
                                blurRadius: 4,
                                offset: Offset(0.6, 0.7),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Icon(Icons.local_grocery_store),
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFE7EEF8),
                                blurRadius: 4,
                                offset: Offset(0.6, 0.7),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Icon(Icons.more_vert),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Image Show
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 28),
                    // images and colors
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Image SlideShow
                        Expanded(
                          flex: 12,
                          child: Stack(
                            children: [
                              Container(
                                height: 220,
                                padding: EdgeInsets.symmetric(vertical: 30),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFE7EEF8),
                                      blurRadius: 1,
                                      offset: Offset(4.6, 4.6),
                                    ),
                                  ],
                                ),
                                child: PageView.builder(
                                  itemCount: images.length,
                                  controller:
                                      PageController(viewportFraction: 0.55),
                                  onPageChanged: (i) => setState(() {
                                    selectedSimilarColorIndex = 0;
                                    purchaseCount = 0;
                                    scrolledImageIndex = i;
                                  }),
                                  itemBuilder: (_, i) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Image.asset(
                                        "assets/images/${images[i]}.png",
                                        height: 90,
                                        width: 90,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned.directional(
                                end: 15,
                                top: 15,
                                textDirection: TextDirection.ltr,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFFE3EFFE),
                                          blurRadius: 1,
                                          offset: Offset(3.6, 1.6),
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(Icons.favorite_border),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        // Colors List
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 220,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFE7EEF8),
                                  blurRadius: 1,
                                  offset: Offset(2.6, 2.6),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(45),
                                bottomLeft: Radius.circular(45),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: colorList
                                    .asMap()
                                    .entries
                                    .map((MapEntry map) => getColors(map.key))
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // similar images
                    SizedBox(height: 28),
                    Container(
                      height: 70,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: similarImages
                            .asMap()
                            .entries
                            .map(
                                (MapEntry map) => getSimilarColorImage(map.key))
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 28),
                    // (Product Details) Are Listed Here
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 12,
                          child: Container(
                            height: 200,
                            padding: EdgeInsets.symmetric(vertical: 30),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFE7EEF8),
                                  blurRadius: 4,
                                  offset: Offset(4.6, 4.6),
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(90),
                                bottomLeft: Radius.circular(90),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.model.fullName,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 7),
                                RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 30,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    onRatingUpdate: (rating) {},
                                    itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/