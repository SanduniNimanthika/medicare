class ProductPerscription {
  String fullname;
  String firstlineaddress;
  String telenumber;
  String email;
  String hometown;
  int days;

  String specialDescription;
  String images;
  String perscriptionkey;
  String status;
  String date;

  ProductPerscription(
      {this.fullname,
        this.perscriptionkey,
        this.telenumber,
        this.email,
        this.hometown,
        this.days,
        this.specialDescription,
        this.firstlineaddress,
        this.images,
      this.status,
      this.date});




  ProductPerscription.fromMap(Map<String, dynamic> data) {
    perscriptionkey = data['uid'];
    fullname= data['fullname'];
    telenumber=data['telenumber'];
    firstlineaddress=data['firstlineaddress'];
    hometown=data['hometown'];
    days=data['days'];
    specialDescription=data['specialDescription'];
    images=data['images'];
    status=data['status'];
    date=data['date'];
    email=data['email'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': perscriptionkey,
      'fullname':fullname,
      'telenumber': telenumber,
      'firstlineaddress': firstlineaddress,
      'hometown':hometown,
      'images': images,
      'days': days,
      'specialDescription':specialDescription,
      'status':status,
      'date':date,
      'email':email

    };
  }
}