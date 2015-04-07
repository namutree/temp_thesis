Table table;
Table tagCount;
int filename;
IntDict counter = new IntDict();

void setup() {
  tagCount = new Table();
  tagCount.addColumn("tag");
  tagCount.addColumn("count");
  
  int cvsNo;
  cvsNo = 11;
  for (int i=0; i<=cvsNo; i++) {
    filename = i;
    if (i<10) table = loadTable("../../data/usa_0"+str(filename)+".csv", "header");
    else table = loadTable("../../data/usa_"+str(filename)+".csv", "header");

    //    0  2   3   4   5            6    7     8    9  10
    //    id,lat,lon,url,created_time,tags,state,city,sd,go
    for (TableRow j : table.rows ()) {
      String tags = j.getString("tags");
      String[] words = tags.split("-");
      for (String w : words) {
        String lcw = w.toLowerCase();

        counter.increment(lcw);

        //if (lcw.equals("nofilter")) println(j.getString("url"));
      }
    }
  }
  counter.sortValuesReverse();
  println(counter.size());
  for (int i=0; i<4000; i++) {
    String[] keys = counter.keyArray();
    String w = keys[i];
    int n = counter.get(keys[i]);
    TableRow newRow = tagCount.addRow();
    newRow.setString("tag", w);
    newRow.setInt("count",n);
    println(w, n);
  }
  saveTable(tagCount,"../../data/tagCount.csv");
}

void draw() {
}

