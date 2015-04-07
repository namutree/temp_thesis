Table table;
PImage bImg;
PImage maskImage;

float latMax, latMin, lonMax, lonMin;
int count;
int filename;

void setup() {
  filename = 9;
  count=0;
  table = loadTable("../../data/usa_0"+str(filename)+".csv", "header");
  maskImage = loadImage("../../data/mask.jpg");

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

  float w = (lonMax - lonMin)*1110/5.5/5;
  float h = (latMax - latMin)*1110/4/5;

  size((int)w, (int)h);
  println("w:", w, ", h:", h);

  //  bImg = loadImage("../../data/usa_insta_map.jpg");
  //  bImg.resize(width, height);
  //  image(bImg, 0, 0);
}

void draw() {
  maskImage.resize(10, 10);
  if (count==0) {
    bImg = loadImage("../../data/usa_insta_map0"+str(filename-1)+".jpg");
    image(bImg, 0, 0);
    //background(255);
  }
  if (count>0) {
    bImg = loadImage("../../data/usa_insta_map0"+str(filename)+".jpg");
    image(bImg, 0, 0);
  }
  for (int i=count; i<count+200; i++) {
    if (i>table.getRowCount()-1) continue;
    PImage img;
    try {
      img = loadImage(table.getString(i, "url")); //url
      img.resize(5, 5);
    }
    catch(Exception e) {
      println(e); 
      img = loadImage("../../data/white_w_pic.jpg");
      img.resize(5, 5);
    }
    //  0   1   2   3   4            5
    //  id, lat,lon,url,created_time,tags

    float lat = table.getFloat(i, "lat"); //lat
    float lon = table.getFloat(i, "lon");  //lon
    lat = map(lat, latMin, latMax, height, 0);
    lon = map(lon, lonMin, lonMax, 0, width);

    pushMatrix();
    {
      translate(lon+random(-2, 2), lat+random(-2, 2));
      rotate(random(30));
      tint(255, 200);
      img.resize(10, 10);
      img.mask(maskImage);
      image(img, 0, 0);//, 25, 25);
    }
    popMatrix();
  }


  count+=200;

  println(count, "/", table.getRowCount());
  save("../../data/usa_insta_map0"+str(filename)+".jpg");
  if (count>=table.getRowCount()-1) {
    println("done"); 
    noLoop();
  }
}

