import 'package:flutter/material.dart';
import 'package:wallzo/view/screens/SearchScreen.dart';

class CategoryBlock extends StatelessWidget {
  final String query;
   CategoryBlock({super.key,required this.query});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal:10),
     
      width: 100,
      child: InkWell(
        
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => SearchPage(query: query),));
    
          
        },
        child: Container(
          
          
          decoration: BoxDecoration(
            
            color: Color.fromARGB(255, 154, 205, 244),
            borderRadius: BorderRadius.circular(7)
            
          ),
    
          child: Center(child: Text(query,style: TextStyle(
            fontSize: 14
          ),)),
        ),
      ),
    );

  }
}
