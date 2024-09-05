import 'package:flutter/material.dart';
import 'package:furniture_app/model/category_model.dart';

class ListItems extends StatefulWidget {
  final int index;

  ListItems(this.index);

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  int purchaseCount = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.indigo,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE7EEF8),
            blurRadius: 1,
            offset: Offset(2.6, 2.6),
          ),
        ],
        color: Colors.white,
        borderRadius: widget.index == 0 || widget.index % 3 == 0
            ? BorderRadius.only(
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              )
            : BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/${categoriesGrid[widget.index].imageUrl}',
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoriesGrid[widget.index].name,
                style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Text(
                categoriesGrid[widget.index].price,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    color: purchaseCount < 2 ? Colors.grey : Colors.black,
                  ),
                ),
              ),
              Container(
                width: 25,
                height: 25,
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
                    size: 25,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
