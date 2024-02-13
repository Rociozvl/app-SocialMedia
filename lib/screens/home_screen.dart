

import 'package:flutter/material.dart';




import 'package:lulu/services.dart/services.dart';


import 'package:provider/provider.dart';

import '../models/post.dart';


 class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   final TextEditingController _textInputController = TextEditingController();
   bool currentLikeStatus = false;

    @override
   Widget build(BuildContext context) {
  

     return Scaffold(
      appBar: AppBar(
         title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
           children:[
            Text('Smoler')
                ] 
            ),
            actions: [
                  IconButton(icon: const Icon(Icons.exit_to_app_outlined) , onPressed: () {  
                  Navigator.pushReplacementNamed(context, 'login');
                 },
               )  ,
             ],
            ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
        children: [
        const SizedBox(height: 20),
        _buildPostList(context),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: _textInputController,
                    decoration: const InputDecoration(
                      hintText: 'Escribe algo...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
                IconButton(
          onPressed: () async {
            await _postToFirebase(context);
          },
          icon: Icon(Icons.send),
        )
            ],
          ),
        ),
        const SizedBox(height: 10),
      
      ],
    ),
  ),
);

   }

   Future<void> _postToFirebase(BuildContext context) async {
    
     String publicacion = _textInputController.text;

     if (publicacion.isNotEmpty) {

       PostService postService = Provider.of<PostService>(context, listen: false);

      Post post = Post(publicacion: publicacion);

       await postService.createPost(post);

       _textInputController.clear();
     }
   }

   Widget _buildPostList(BuildContext context) {

     PostService postService = Provider.of<PostService>(context);

       if (postService.isLoading) {
       return const CircularProgressIndicator();
       } else {
       return Expanded(
         child: Container(
          padding: const EdgeInsets.symmetric( horizontal: 10),
           child: ListView.builder(
            
             itemCount: postService.posts.length,
             itemBuilder: (context, index) {

              String? postId = postService.posts[index].id; 

               return Container(
                margin: EdgeInsets.only(bottom: 10.0), // Espacio entre los contenedores de los posts
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
                 child: ListTile(
                   title: Text(postService.posts[index].publicacion),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                           icon: Icon( 
                               postService.postLikeStatus[postId] ?? false ? Icons.favorite : Icons.favorite_border,
                               color: postService.postLikeStatus[postId] ?? false ? Colors.red : null, 
                            ),
                         
                             
                           onPressed: () {
                               String? postId = postService.posts[index].id;
                               postService.toggleLike(postId!, postService.postLikeStatus[postId] ?? false);
                               
                               setState(() {
                                     postService.postLikeStatus[postId] = !(postService.postLikeStatus[postId] ?? false);
                                });
},
),
                                        IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                        postService.hotReload(postService.posts[index]);
                                        setState(() {
                                          postService.posts.removeAt(index);
                                       });
      
                                  },
                                 ),
                      ],
                     ),
                   ),
                 
               );
             },
           ),
         ),
       );
     }
   }
 
}
    
     
