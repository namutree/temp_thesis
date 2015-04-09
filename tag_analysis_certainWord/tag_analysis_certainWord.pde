Table table;
Table tagCount;
int filename;
IntDict counter = new IntDict();
String hashtag;

void setup() {
  hashtag = "halloween";
  
  tagCount = new Table();
  tagCount.addColumn("tag");
  tagCount.addColumn("count");


  table = loadTable("../../data/usa_10_total.csv", "header");

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

  counter.sortValuesReverse();
  println(counter.size());
  for (int i=0; i<counter.size (); i++) {
    String[] keys = counter.keyArray();
    String w = keys[i];
    int n = counter.get(keys[i]);

    //where you can change the word!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    if (w.equals(hashtag)) println(w, n);
    /////////////////////////////////////////////////////////////////////////////
  }
  println("done");
}

void draw() {
}

