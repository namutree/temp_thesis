Table table;
Table mozaicTable;
float latMax, latMin, lonMax, lonMin;
int thres;
ArrayList<Quater> quater = new ArrayList<Quater>();
int qsize01, qsize02;

void setup() {
  table = loadTable("../../../data/ny/usa_ny_wo_tagNurl.csv", "header");
  mozaicTable = new Table();
  mozaicTable.addColumn("x");
  mozaicTable.addColumn("y");
  mozaicTable.addColumn("w");
  mozaicTable.addColumn("h");
  thres = 20;
  qsize01 = 0;
  qsize02 = -1;

  latMax= 40.903939;
  latMin= 40.481192;
  lonMax= -73.694036;
  lonMin= -74.280432;

  int w = (int)((lonMax - lonMin)*1110*3);
  int h = (int)((latMax - latMin)*1110*3);

  size((int)w, (int)h);
  int a = howmany(0, 0, width, height);
  quater.add(new Quater(0, 0, width, height, a));
}

void draw() {
  background(255);
  noFill();
  stroke(0);//,200);
  for (int i=0; i<quater.size (); i++) {
    Quater q = quater.get(i);
    
    //if it is too small do not divide.
    if ( q.w <= 1 || q.h <= 1) continue;
    
    // if it is bigger than threshold, then divide
    if (q.count>thres) {
      
      int c = howmany(q.q01.x, q.q01.y, q.w/2, q.h/2);  
      Quater q1 = new Quater(q.q01.x, q.q01.y, q.w/2, q.h/2, c);
      c = howmany(q.q02.x, q.q02.y, q.w/2, q.h/2); 
      Quater q2 = new Quater(q.q02.x, q.q02.y, q.w/2, q.h/2, c);
      c = howmany(q.q03.x, q.q03.y, q.w/2, q.h/2); 
      Quater q3 = new Quater(q.q03.x, q.q03.y, q.w/2, q.h/2, c);
      c = howmany(q.q04.x, q.q04.y, q.w/2, q.h/2); 
      Quater q4 = new Quater(q.q04.x, q.q04.y, q.w/2, q.h/2, c);
      
      quater.add(q1);
      quater.add(q2);
      quater.add(q3);
      quater.add(q4);
      quater.remove(i);
    }
    if (i%350 == 0) print(i+"/"+quater.size()+", ");
  }

//draw them
  for (int i=0; i<quater.size (); i++) {
    Quater q = quater.get(i);
    q.display();
  }
  println(quater.size());

//check if there is more to divide
  qsize02 = qsize01;
  qsize01 = quater.size();

// when it done, save and finish it.
  if (qsize02 == qsize01) {
    save("../../../data/ny/mozaic"+str(thres)+".jpg");
    
    for(int i=0 ; i<quater.size(); i++){
      Quater q = quater.get(i);
      TableRow newRow = mozaicTable.addRow();
      newRow.setFloat("x", q.x);
      newRow.setFloat("y", q.y);
      newRow.setFloat("w", q.w);
      newRow.setFloat("h", q.h);
    }
    saveTable(mozaicTable, "../../../data/ny/mozaicTable.csv");
 
    println("done");
    noLoop();
  }
}


//check how many pictures in the designated box
int howmany(float x, float y, float w, float h) {
  int count=0;
  for (TableRow t : table.rows ()) {
    float lat = t.getFloat("lat"); // y
    float lon = t.getFloat("lon"); //x
    lat = map(lat, latMin, latMax, height, 0); 
    lon = map(lon, lonMin, lonMax, 0, width);

    if (lon >= x && lon < x+w && lat >= y && lat < y+h) count++;
  }
  return count;
}

