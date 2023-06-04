enum TrendType {
  recommendation('Recommendation'),
  newRelease('New Release');

  const TrendType(this.description);
  final String description;

  String toJson() => name;
  static TrendType fromJson(String json) => values.byName(json);
}
