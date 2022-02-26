class CountrySummaryModel{
  final String slug;
  final int confirmed;
  final int newconfirmed;
  final int newdeaths;
  final int deaths;
  final DateTime date;

  CountrySummaryModel(this.slug, this.confirmed, this.newconfirmed, this.newdeaths, this.deaths, this.date);

  factory CountrySummaryModel.fromJson(Map<String, dynamic> json, String Country){

    int dem = 0;
    for(int i = 0 ; i < 194 ; i++)
    {
      if(json["Countries"][i]["Slug"] == Country)
      {
        dem = i;
        break;
      }
    }

    return CountrySummaryModel(
      json["Countries"][dem]["Country"],
      json["Countries"][dem]["TotalConfirmed"],
      json["Countries"][dem]["NewConfirmed"],
      json["Countries"][dem]["NewDeaths"],
      json["Countries"][dem]["TotalDeaths"],
      DateTime.parse(json["Date"]),
    );
  }
}