class Prayer {
  final String namazName;
  final String namazTime;
  bool isCurrentNamaz;

  Prayer(
      {required this.namazName,
        required this.namazTime,
        required this.isCurrentNamaz});
}