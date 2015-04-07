Table table;
StringList cityList;

void setup() {
  cityList = new StringList();
  table = loadTable("../../data/usa_10_total.csv", "header");


  for (TableRow i : table.rows ()) {
    //println("DD");
    String city = i.getString("city");
    //println(state);
    //for (int j =0; j<stateList.size (); j++) {
      if (cityList.hasValue(city) == false) cityList.append(city);
      else continue;
    //}
  }
  //stateList.append("state");
  for(int i =0 ; i<cityList.size() ; i++){
  print("\""+cityList.get(i)+"\",");
  }
}

void draw() {
}

