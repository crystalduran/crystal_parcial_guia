class Evento {
  final int? id;
  DateTime createdAt;
  final String titulo;
  final String descripcion;
  final String? image64bit;

   Evento({
    this.id,
    required this.createdAt,
    required this.titulo,
    required this.descripcion,
    this.image64bit
  });

  factory Evento.fromJson(Map<String, dynamic> json) => Evento(
    id: json['id'],
    createdAt: DateTime.fromMicrosecondsSinceEpoch(json['createdAt']),
    titulo: json ['titulo'],
    descripcion: json ['descripcion'],
    image64bit: json['image64bit']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt.microsecondsSinceEpoch,
    'titulo': titulo,
    'descripcion': descripcion,
    'image64bit': image64bit
  };

}