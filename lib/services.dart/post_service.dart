import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:lulu/models/models.dart';
import 'package:http/http.dart' as http;

class PostService extends ChangeNotifier {

final String _baseUrl = 'flutter-varios-4837e-default-rtdb.firebaseio.com';

final List<Post> posts =[];


bool isLoading = true;
  bool isSaving = false;
Map<String, bool> postLikeStatus = {}; 

PostService(){
    loadPost();
    
}
updateAvailability(value){
  print(value);
 notifyListeners();
}

Future<List<Post>> loadPost() async{
  
    isLoading = true;
    notifyListeners();

       final url = Uri.https(_baseUrl , 'PUBLICACIONES.json');
       final resp = await http.get(url);
       final Map< String , dynamic> postMap = json.decode( resp.body);

      postMap.forEach((key, value) { 
         final tempPost = Post.fromMap(value);
         tempPost.id =key;
         posts.add(tempPost);
    });

    //print(this.post[0].publicacion);
      

      isLoading = false;
      notifyListeners();
      //print( this.products[0].name);
      return posts;
  }

Future<String> createPost(Post post) async {
  final url = Uri.https(_baseUrl, 'PUBLICACIONES.json');
  final resp = await http.post(url, body: post.toRawJson());

  if (resp.statusCode == 200) {
    final decodedData = json.decode(resp.body);
    
    if (decodedData != null && decodedData.containsKey('name')) {
     post.id = decodedData['name'];
      posts.add(post);

      notifyListeners();

      return post.id!;
    } else {
      // Manejar el caso en el que la respuesta no contiene la clave 'name'
      print('Error al decodificar la respuesta: $decodedData');
      return 'Error';
    }
  } else {
    // Manejar el caso en el que la petición no fue exitosa
    print('Error en la petición: ${resp.statusCode}');
    return 'Error';
  }
}
  Future hotReload(Post post) async{
       
       isSaving = true;
       notifyListeners();


       if( post.id == null){
        await createPost(post);

       }else{

        await deletePost(post);
       }

       isSaving= false;
       notifyListeners();

  }



 Future<void> toggleLike(String postId, bool currentLikeStatus) async {
  
       

    bool newLikeStatus = !currentLikeStatus; 
     final url = Uri.https(_baseUrl, 'PUBLICACIONES/${postId}.json');

    final resp= await http.patch(
      url,
      body: json.encode({'like': newLikeStatus}),
    );
    postLikeStatus[postId] = newLikeStatus;
   print('Estado del botón de "like" actualizado correctamente');
  
    
     
}


Future<String> deletePost(Post post) async {
  isSaving = true;
  final url = Uri.https(_baseUrl, 'PUBLICACIONES/${post.id}.json');
    final resp = await http.delete(url);
     
   
   
    //  final index = posts.indexWhere((element) => element.id == post.id );
    //  posts[index] = post;
    if (resp.statusCode == 200) {
      // El comentario se eliminó correctamente
      // Aquí puedes actualizar tu lista local de posts si es necesario
      print('Post eliminado correctamente');
    } else {
      // Manejar el caso en el que la petición no fue exitosa
      print('Error en la petición: ${resp.statusCode}');
      // Lanza una excepción o realiza alguna otra acción según lo necesites
      throw Exception('Error al eliminar el post');
    }
    
  return post.id!;
  
}


}


