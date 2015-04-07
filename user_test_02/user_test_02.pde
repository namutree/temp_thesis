PImage bImg;
PImage layout;
PImage nextImg;
PImage backImg;
PImage refreshImg;
ArrayList<MRect> mrect = new ArrayList<MRect>();
boolean nemo1, nemo2;
boolean layoutOn;

void setup() {
  bImg = loadImage("../../data/white_w_pic_4_seoul.jpg");
  nextImg = loadImage("../../data/next.png");
  backImg = loadImage("../../data/back.png");
  refreshImg= loadImage("../../data/refresh.png");
  layout = loadImage("../../data/layout4.jpg");
  layout.resize(bImg.width, bImg.height);
  layoutOn= false;
  size(bImg.width, bImg.height, P3D);
  smooth(4);


  mrect.add(new MRect());
  mrect.add(new MRect());
  nemo1 = false;
  nemo2 = false;
}

void draw() {
  if (!layoutOn) {
    image(bImg, 0, 0);
    image(nextImg, width*8/9, 10);
    image(refreshImg,10,10);
    for (MRect m : mrect) {
      m.render();
    }
  }

  if (layoutOn) {
    image(layout, 0, 0);
    image(backImg, 10, 10);
  }
}


void mousePressed() {
  MRect mm0 = mrect.get(0);
  MRect mm1 = mrect.get(1);

  if (mm0.x1==0 && mm0.y1==0 && mm1.x1==0 && mm1.y1==0 ) {
    mm0.x1= mouseX;
    mm0.y1= mouseY;
    mm0.x2= mouseX;
    mm0.y2= mouseY;
    nemo1 = true;
  } else if (mm0.x1!=0 && mm0.y1!=0 && mm1.x1==0 && mm1.y1==0) {
    if (mouseX > mm0.x1 && mouseX <mm0.x2 && mouseY>mm0.y1 && mouseY<mm0.y2) {
      mm0.x1 =0;
      mm0.x2 =0;
      mm0.y1 =0;
      mm0.y2 =0;
    }
    mm1.x1= mouseX;
    mm1.y1= mouseY;
    mm1.x2= mouseX;
    mm1.y2= mouseY;
    nemo2 = true;
  } else if (mm0.x1!=0 && mm0.y1!=0 && mm1.x1!=0 && mm1.y1!=0) {
    mm1.x1= mouseX;
    mm1.y1= mouseY;
    mm1.x2= mouseX;
    mm1.y2= mouseY;
    nemo2=true;
  } else { 
    mm0.x1=0;
  }
}

void mouseDragged() {
  MRect mm0 = mrect.get(0);
  MRect mm1 = mrect.get(1);
  if (nemo1) {
    mm0.x2= mouseX;
    mm0.y2= mouseY;
  } else if (nemo2) {
    mm1.x2= mouseX;
    mm1.y2= mouseY;
  }
}

void mouseReleased() {
  MRect mm0 = mrect.get(0);
  MRect mm1 = mrect.get(1);

  if (nemo1) {  
    mm0.x2= mouseX;
    mm0.y2= mouseY;
    nemo1=false;
  } else if (nemo2) {  
    mm1.x2= mouseX;
    mm1.y2= mouseY;
    nemo2=false;
  }

  //next x,y position = (width*8/9, 10) size(100,30)
  if (mouseX>width*8/9 && mouseX<width*8/9+300 && mouseY>10 && mouseY<30+10) {
    layoutOn= true;
  }

  //back x,y position =(10,10) size(100,30)
  if (mouseX>10 && mouseX<110 && mouseY>10 && mouseY<30+10) {
    layoutOn= false;
    mm0.x1= 0;
    mm0.y1= 0;
    mm0.x2= 0;
    mm0.y2= 0;
    mm1.x1= 0;
    mm1.y1= 0;
    mm1.x2= 0;
    mm1.y2= 0;
  }
}

