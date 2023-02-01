class GetFavoritesModel
{
  bool? status;
  String? message;
  GetFavoritesModel.fromJson(Map<String,dynamic> json){
    status =json['status'];
    message =json['message'];
  }
}
