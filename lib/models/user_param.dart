
class UserParam{
  String id;
  String name;
  String surname;
  String email;
  String password;
  String role;
  String nation;
  String city;
  String prefix;
  String phone;
  DateTime creationDate;
  String status;
  String hospital;
  String specialization;
  String token;

  UserParam(
      this.id,
      this.name,
      this.surname,
      this.email,
      this.password,
      this.role,
      this.nation,
      this.city,
      this.prefix,
      this.phone,
      this.creationDate,
      this.status,
      this.hospital,
      this.specialization,
      this.token);

  Map<String,dynamic> toJson(){
    return {
      "id":id,
      "name": name,
      "surname": surname,
      "password": password,
      "role": role,
      "nation": nation,
      "city": city,
      "prefix": prefix,
      "phone": phone,
      "creationDate": creationDate,
      "status": status,
      "hospital": hospital,
      "specialization": specialization,
      "token": token,

    };
  }

}