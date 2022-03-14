class APIResponse<T> {
  T data;
  bool error;
  String errorMessage;
  List<T> datas;

  APIResponse({this.data, this.error, this.errorMessage, this.datas});
}