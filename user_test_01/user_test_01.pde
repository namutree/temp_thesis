Table table;
PImage bImg;

float latMax, latMin, lonMax, lonMin;
int count;

void setup() {
  count=0;
  latMax =  -10000;
  lonMax =  -10000;
  latMin = 10000;
  lonMin = 10000;

  table = loadTable("../../data/geotest_chicago_usertest.csv", "header");



  //lat(wido) 1do is 111km   -90  ~ 90
  //lon(kyoungdo) is 0-111km -180 ~ 180
  for ( TableRow i : table.rows ()) {
    float lat = i.getFloat("lat"); 
    float lon = i.getFloat("lon"); 

    if (lat > latMax) latMax = lat;
    if (lat < latMin) latMin = lat;
    if (lon > lonMax) lonMax = lon;
    if (lon < lonMin) lonMin = lon;
  }


  println(latMax);
  println(latMin);
  println(lonMax);
  println(lonMin);

  //  latMax= 37.719514;
  //  latMin= 37.404911;
  //  lonMax= 127.199664;
  //  lonMin= 126.742358;
  
//  # ny
//# 40.903939, -73.694036
//# 40.481192, -74.280432
//  # chicago
//# 42.327053, -88.556130
//# 41.334519, -87.122414

  latMax= 42.327053;
  latMin= 41.334519;
  lonMax= -87.122414;
  lonMin= -88.556130;

  float w = (lonMax - lonMin)*1110*2;
  //  w = map(w, 0, 90, 0, abs(latMax+latMin)/2)*1110*2; 
  float h = (latMax - latMin)*1110*2;

  size((int)w, (int)h);
}

void draw() {
  bImg = loadImage("../../data/white_w_pic.jpg");
  bImg.resize(width, height);
  image(bImg, 0, 0);
  fill(255); 
  noStroke();
  PImage img, img1, img2;
  //  lat,lon,url,created_time
  //  37.398083333,126.739708333,http://scontent.cdninstagram.com/hphotos-xpf1/t51.2885-15/s150x150/e15/1515701_304578143079479_1750133629_n.jpg,2014-10-31-15-39-28
  //for(int i=0; i<table.getRowCount(); i++){
  //  for ( TableRow i : table.rows ()) {

  try {
    img = loadImage(table.getString(count, 2)); //url
    //      img1 = loadImage(table.getString(count+1,2));
    //      img2 = loadImage(table.getString(count+2,2));
    img.resize(10, 10);
  }
  catch(Exception e) {
    println(e); 
    img = loadImage("../../data/background_w_pic.jpg");
    //      img1 = loadImage("../../data/background.jpg");
    //      img2 = loadImage("../../data/background.jpg");
    img.resize(5, 5);
  }
  float lat = table.getFloat(count, 0); //lat
  float lon = table.getFloat(count, 1);  //lon


  lat = map(lat, latMin, latMax, height, 0);
  lon = map(lon, lonMin, lonMax, 0, width);
  //ellipse(lon, lat, 2, 2);
  pushMatrix();
  {
    translate(lon,lat);
    rotate(random(30));
    tint(255, 200);
    image(img, 0,0);
  }
  popMatrix();
  count+= (int)random(1, 30);
  if (count%15==0) println(count);
  save("../../data/white_w_pic.jpg");
  if (count>=table.getRowCount()) {
    println("done"); 
    noLoop();
  }
}

