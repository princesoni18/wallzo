import 'package:flutter/material.dart';

import 'package:wallzo/view/screens/widgets/CustomAppBar.dart';

import 'package:wallzo/view/screens/widgets/wallpapers.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage ({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {


  @override
  
  void initState() {
    // TODO: implement initState
    
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const CustomAppBar(),
        centerTitle: true,
        
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
      
            
               
                  Stack(
                  
                  children: [ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network("https://images.pexels.com/photos/14894269/pexels-photo-14894269.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                    height: 150,
                    
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    
                    ),
                  ),
                 
                  
                  
                   const Center(
                    heightFactor: 3,
                     child: Column(children: [Text("category"),Text("mountains",style: TextStyle(
                   
                                     fontSize: 20
                   
                                     ),)],),
                   )],
                             ),
               
            
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Container(
                
                
                
                
                
                
                child: wallpapers()
                 ),
            ),
            
            
      
          ],
        ),
      ),
    );
  }
}