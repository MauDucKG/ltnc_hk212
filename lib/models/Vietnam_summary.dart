class VietnamSummaryModel{
  final int newConfirmed;
  final int totalConfirmed;
  final int newDeaths;
  final int totalDeaths;
  final int newRecovered;
  final int totalRecovered;
  final DateTime date;

  VietnamSummaryModel(this.newConfirmed, this.totalConfirmed, this.newDeaths, this.totalDeaths, this.newRecovered, this.totalRecovered, this.date);

  factory VietnamSummaryModel.fromJson(Map<String, dynamic> json){
    return VietnamSummaryModel(
      json["Vietnam"]["NewConfirmed"],
      json["Vietnam"]["TotalConfirmed"],
      json["Vietnam"]["NewDeaths"],
      json["Vietnam"]["TotalDeaths"],
      json["Vietnam"]["NewRecovered"],
      json["Vietnam"]["TotalRecovered"],
      DateTime.parse(json["Date"]),
    );
  }
}