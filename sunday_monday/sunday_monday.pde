Table table;
int filename;
IntDict counter = new IntDict();
String whatDay;
float latMax, latMin, lonMax, lonMin;
PImage maskImage;

void setup() {
  //# USA
  //# 49.265911, -125.517483
  //# 26.743020, -64.872955
  //  #revised USA
  //# 49.265911, -125.517483
  //# 24.584452, -64.872955

  latMax= 49.265911;
  latMin= 24.584452;
  lonMax= -64.872955;
  lonMin= -125.517483;

  float w = (lonMax - lonMin)*1110/5.5/11;
  float h = (latMax - latMin)*1110/4/11;

  size((int)w, (int)h);
  println("w:", w, ", h:", h);

  whatDay="asdfqqq";
  //imageMode(CENTER);
  maskImage = loadImage("../../data/mask.jpg");
}

void draw() {
  background(255);
  tagsDay();
  save("../../data/"+whatDay+".jpg");
}

void tagsDay() {
  
  randomSeed(0);
  text(whatDay +"....", 10, 10);
  int cvsNo;
  cvsNo = 9;
  for (int i=0; i<=cvsNo; i++) {
    filename = i;
    if (i<10) table = loadTable("../../data/usa_0"+str(filename)+".csv", "header");
    else table = loadTable("../../data/usa_"+str(filename)+".csv", "header");

    //    0  2   3   4   5            6    7     8    9  10
    //    id,lat,lon,url,created_time,tags,state,city,sd,go
    int count;
    count =0;
    for (TableRow j : table.rows ()) {
      String tags = j.getString("tags");
      String[] words = tags.split("-");
      for (String w : words) {
        String lcw = w.toLowerCase();

        counter.increment(lcw);

        if (lcw.equals(whatDay) && j.getFloat("go")==1) {
          if(count%11==0 || count%12==0) println(i+" "+count+"/"+table.getRowCount());
          float lat = j.getFloat("lat");
          float lon = j.getFloat("lon");
          lat = map(lat, latMin, latMax, height, 0);
          lon = map(lon, lonMin, lonMax, 0, width);

          PImage img;
          try {
            img = loadImage(j.getString("url")); //url
            img.resize(3, 3);
          }
          catch(Exception e) {
            println(e); 
            img = loadImage("../../data/white_w_pic.jpg");
            img.resize(3, 3);
          }
          noStroke();
          pushMatrix();
          {
            translate(lon +random(-5,5), lat+random(-5,5));
            rotate(random(30));
            //rect(0, 0, 10, 10);
            tint(255, 190);
            img.resize(5, 5);
            maskImage.resize(5,5);
            img.mask(maskImage);
            image(img, 0, 0);//, 25, 25);
          }
          popMatrix();
          //println(lon, lat);
        }
        
      }
      count++;
    }
  }
  fill(0);
  text(whatDay +"done", 10, 20);
}

void keyPressed() {
  if (key == 'm') whatDay = "monday";
  if (key == 't') whatDay = "tuesday";
  if (key == 'w') whatDay = "wednesday";
  if (key == 'T') whatDay = "thursday";
  if (key == 'f') whatDay = "friday";
  if (key == 's') whatDay = "saturday";
  if (key == 'S') whatDay = "sunday";
}

