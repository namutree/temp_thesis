Table table;
int filename;
IntDict counter = new IntDict();
String hashTag;
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

  hashTag="newyork";
  //imageMode(CENTER);
  maskImage = loadImage("../../data/mask.jpg");
}

void draw() {
  background(255);
  tagsAnalysis();
  save("../../data/hashTag_"+hashTag+".jpg");
}

void tagsAnalysis() {

  randomSeed(0);
  fill(0);
  text(hashTag, width/2, 10);
  table = loadTable("../../data/usa_10_total.csv", "header");


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

      if (lcw.equals(hashTag) && j.getFloat("go")==1) {
        if (count%11==0 || count%12==0) println(count+"/"+table.getRowCount());
        float lat = j.getFloat("lat");
        float lon = j.getFloat("lon");
        lat = map(lat, latMin, latMax, height, 0);
        lon = map(lon, lonMin, lonMax, 0, width);

        PImage img;

        img = loadImage("../../data/img/"+str(j.getInt("no"))+".jpg"); //j.getString("url")); 
        img.resize(3, 3);
        
        noStroke();
        pushMatrix();
        {
          translate(lon +random(-5, 5), lat+random(-5, 5));
          rotate(random(30));
          tint(255, 190);
          img.resize(5, 5);
          maskImage.resize(5, 5);
          img.mask(maskImage);
          image(img, 0, 0);
        }
        popMatrix();
      }
    }
    count++;
  }

}

void keyPressed() {
  if (key == 'm') hashTag = "monday";
  if (key == 't') hashTag = "tuesday";
  if (key == 'w') hashTag = "wednesday";
  if (key == 'T') hashTag = "thursday";
  if (key == 'f') hashTag = "friday";
  if (key == 's') hashTag = "saturday";
  if (key == 'S') hashTag = "sunday";
}

