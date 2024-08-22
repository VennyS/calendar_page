class Spots {
  final int maxSpots;
  final int currentSpots;
  final int confirmed;
  final int canceled;
  final int missed;
  final int notConfirmed;
  final int waitingList;

  Spots({
    required this.maxSpots,
    required this.currentSpots,
    required this.confirmed,
    required this.canceled,
    required this.missed,
    required this.notConfirmed,
    required this.waitingList,
  });

  factory Spots.fromJson(Map<String, dynamic> json) {
    return Spots(
      maxSpots: json['max_spots'],
      currentSpots: json['current_spots'],
      confirmed: json['Подтвердил'],
      canceled: json['Отменил'],
      missed: json['Пропуск'],
      notConfirmed: json['Не подтверждено'],
      waitingList: json['Лист ожидания'],
    );
  }
}
