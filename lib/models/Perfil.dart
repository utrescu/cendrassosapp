class Perfil {
  final String grup;
  final String datanaixement;
  final String telefon;
  final String adreca;
  final Iterable<Responsable> responsables;

  Perfil(this.grup, this.datanaixement, this.telefon, this.adreca,
      this.responsables);

  factory Perfil.fromJson(dynamic json) {
    return Perfil(
      json['grup'] as String,
      json['datanaixement'] as String,
      json['telefon'] as String,
      json['adreca'] as String,
      List<Responsable>.from(json['responsables']).map((x) => x),
    );
  }
}

class Responsable {
  final String nom;
  final String mail;
  final String telefon;

  Responsable(this.nom, this.mail, this.telefon);

  factory Responsable.fromJson(dynamic json) {
    return Responsable(json['nom'], json['mail'], json['telefon']);
  }
}
