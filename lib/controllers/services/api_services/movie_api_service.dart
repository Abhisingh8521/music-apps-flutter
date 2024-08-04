import 'dart:convert';

import 'package:http/http.dart' as http;


import '../../../models/movies/movie_data_model.dart';

class MovieApi{

static const String _baseurl = 'https://moviesdatabase.p.rapidapi.com';

static Future<ApiMovieDataModel> getMovieByPage({String? limit,String? page,String? nextPage}) async{
 final uri =  Uri.parse("$_baseurl/${nextPage ?? 'titles/x/upcoming?limit=50&page=1'}");
 Map<String,String> headers = {
  "X-RapidAPI-Key":"047204f650msh9e8b6868f4795c9p1f9241jsne6527cf2ffff",
  "X-RapidAPI-Host":"moviesdatabase.p.rapidapi.com"

 };
 var response = await http.get(uri,headers: headers);
 if(response.statusCode == 200){
  ApiMovieDataModel apiMovieDataModel = ApiMovieDataModel.fromJson(jsonDecode(response.body));
  return apiMovieDataModel;
 }else{
  ApiMovieDataModel apiMovieDataModel = ApiMovieDataModel.fromJson(jsonDecode(response.body));
  return ApiMovieDataModel();
 }
}

}