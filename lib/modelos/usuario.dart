
class Usuario{
  String ID_USER, ID_GOOGLE_USER, NOMBRE_USER, FOTO_URL, EMAIL_USER;

  Usuario({this.ID_USER, this.ID_GOOGLE_USER, this.NOMBRE_USER, this.FOTO_URL, this.EMAIL_USER});

  factory Usuario.fromMap(Map<String, dynamic> json) => new Usuario(
      ID_USER:            json["ID_USER"],
      ID_GOOGLE_USER:     json["ID_GOOGLE_USER"],
      NOMBRE_USER:        json["NOMBRE_USER"],
      FOTO_URL:           json["FOTO_URL"],
      EMAIL_USER:         json["EMAIL_USER"]
  );
}