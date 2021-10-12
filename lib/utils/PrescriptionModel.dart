class PrescriptionModel{
  String date;
  String symptoms;
  String medicines;
  String diagnosis;

  PrescriptionModel({
    this.date,this.symptoms,this.medicines,this.diagnosis,
  });

  static PrescriptionModel fromJson(Map<String,dynamic> json){
    return PrescriptionModel(
      date: json['date'],
      symptoms: json['symptoms'],
      medicines: json['medicines'],
      diagnosis: json['diagnosis'],
    );
  }

  Map<String, dynamic> toJson() => {
    'date': date,
    'symptoms': symptoms,
    'medicines': medicines,
    'diagnosis': diagnosis,
  };
}