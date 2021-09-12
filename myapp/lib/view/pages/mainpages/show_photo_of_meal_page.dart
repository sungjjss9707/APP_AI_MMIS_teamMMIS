import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShowPhotoOfMealPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Icon(Icons.whatshot),
                SizedBox(width: 2),
                Text(
                  "우리 부대 급식 자랑",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text("게시하기"),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return _buildGridViewItem(context, index);
              },
              itemCount: 13,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGridViewItem(BuildContext context, int index) {
    double _imageWidth = MediaQuery.of(context).size.width * 0.5 - 4;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "meal_photos/example_${index + 1}.jpg",
          fit: BoxFit.cover,
          width: _imageWidth,
          height: _imageWidth * 0.6,
        ),
        Text(
          "제8전투비행단",
          style: TextStyle(fontSize: 10),
        ),
        Text(
          "2021년 9월 8일 (석식)",
          style: TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}
