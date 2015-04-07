Table table;
StringList stateList;

void setup() {
  stateList = new StringList();
  table = loadTable("../../data/usa_10_total.csv", "header");


  for (TableRow i : table.rows ()) {
    //println("DD");
    String state = i.getString("state");
    //println(state);
    //for (int j =0; j<stateList.size (); j++) {
      if (stateList.hasValue(state) == false) stateList.append(state);
      else continue;
    //}
  }
  //stateList.append("state");
  println(stateList);
}

void draw() {
}

