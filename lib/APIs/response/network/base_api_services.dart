
abstract class BaseApiServices{


  Future<dynamic> getApi(String url);

  Future<dynamic> postApi(dynamic data ,String url);
}













//we create abstract class so we can extand this function of this class