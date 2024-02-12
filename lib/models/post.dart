import 'dart:convert';

class Post {
   Post({
    this.like,
    required this.publicacion
  
   });

    String publicacion;
    bool? like;
    String? id;

    factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

    String toRawJson() => json.encode(toMap());

    factory Post.fromMap(Map<String, dynamic> json) => Post(
        publicacion: json["PUBLICACION"] ?? "",
        like: json["like"],
    );

    Map<String, dynamic> toMap() => {
        "PUBLICACION": publicacion,
        "like": like,
    };
    Post copy ()=> Post(
      like: like, 
      publicacion: publicacion,
  
      );
}