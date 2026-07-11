import 'package:flutter/material.dart';

class PostItemBuilder extends StatelessWidget {
  const PostItemBuilder({super.key, required this.data});

  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey)
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // post header
          Row(
            children: [
              CircleAvatar(
                radius: 20,
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User Name'),
                    Text('2026-05-09 10:30am', style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.grey
                    ),),
                  ],
                ),
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))
            ],
          ),
          Divider(),

          // Body
          Text(data['title']),
          SizedBox(height: 10,),
          Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqf-LX3h-6FiPw4BtjuprZx3I-aYxTUQPdwE7zDL1fK6hSwyYwpaabPw89&s=10'),

          // Actions Row
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.favorite)),
            IconButton(onPressed: (){}, icon: Icon(Icons.comment)),
            IconButton(onPressed: (){}, icon: Icon(Icons.share)),
          ],)
        ],
      ),
    );
  }
}
