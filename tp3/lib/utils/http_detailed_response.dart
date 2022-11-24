class HttpDetailedReponse {
  int status;
  bool succes;

  HttpDetailedReponse({required this.status, required this.succes});

  bool isAuthorize(){
    return status != 401;
  }

}