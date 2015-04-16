Table table;
PImage img;
PImage maskImage;

float latMax, latMin, lonMax, lonMin;

void setup() {

  table = loadTable("../../../data/ny/hueTable_gonogo.csv", "header");
  img = new PImage();
  

  //# ny
  //# lat 40.903939, lon -73.694036 
  //# lat 40.481192, lon -74.280432

  latMax= 40.903939;
  latMin= 40.481192;
  lonMax= -73.694036;
  lonMin= -74.280432;

  float w = (lonMax - lonMin)*1110*3;
  float h = (latMax - latMin)*1110*3;

  size((int)w, (int)h);
  println("w:", w, ", h:", h);
}

void draw() {

  background(255);
  for (TableRow t : table.rows ()) {
    int go = t.getInt("go");
    if(go == 0) continue; //  0(nogo) 1(go)
    int id = t.getInt("id");
    float lat = t.getFloat("lat"); //y
    float lon = t.getFloat("lon"); //x
    lat = map(lat, latMin, latMax, height, 0);
    lon = map(lon, lonMin, lonMax, 0, width);
    
    img = loadImage("../../../data/ny/img/"+str(id)+".jpg");
    img.resize(3,3);

    noStroke();
    fill(255, 20);
    pushMatrix();
    {
      translate(lon+random(-2, 2), lat+random(-2, 2));
      rotate(random(30));
      //ellipse(0, 0, 5, 5);
      tint(255,100);
      img.resize(7,7);
      image(img, 0, 0);
    }
    popMatrix();
    if(id % 300 == 0) println(id+" / "+ table.getRowCount());
  }
  save("../../../data/ny/map_img_rotate_go.jpg");
  println("done"); 
  noLoop();
}

