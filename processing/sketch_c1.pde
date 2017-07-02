import processing.serial.*;
Serial port;
int max=4;

int a = 0;
int b = 0;
int c = 0;
int d = 0;
int v1=55;
int v2=55;
int v3=55;
int v4=55;

PFont font;
ArrayList myBall = new ArrayList();
int n =myBall.size();
int ind=0;
//over
ArrayList<PVector> circle = new ArrayList<PVector>();
ArrayList<PVector> square = new ArrayList<PVector>();
ArrayList<PVector> morph = new ArrayList<PVector>();
boolean state = false;

void setup() {
  port = new Serial(this, "COM3", 9600);
  port.clear();
  size(800, 800);
  font= createFont("黑体", 150);
  init();
  //over
  for (int angle = 0; angle < 360; angle += 9) {
    PVector v = PVector.fromAngle(radians(angle-135));
    v.mult(100);
    circle.add(v);
    morph.add(new PVector());
  }
  for (int x = -50; x < 50; x += 10) {
    square.add(new PVector(x, -50));
  }
  for (int y = -50; y < 50; y += 10) {
    square.add(new PVector(50, y));
  }
  for (int x = 50; x > -50; x -= 10) {
    square.add(new PVector(x, 50));
  }
  for (int y = 50; y > -50; y -= 10) {
    square.add(new PVector(-50, y));
  }
}

void init() {
  background(255);
  textAlign(LEFT);
  fill(0);
  textFont(font);
  textSize(35);
  text("阅览室 A5", 40, 60);
  text("最大人数 "+max, 40, 115);
  ind=0;
}


void draw() {
  background(255);
  noStroke();
  fill(255, 55, 55, 200);
  ellipse(400, 400, 90, 90);
  fill(v1, 55, 55, 150);
  ellipse(460, 45, 25, 25);
  fill(v2, 55, 55, 150);
  ellipse(550, 45, 25, 25);
  fill(v3, 55, 55, 150);
  ellipse(639, 45, 25, 25);
  fill(v4, 55, 55, 150);
  ellipse(728, 45, 25, 25);
  textAlign(LEFT);
  fill(0);
  textFont(font);
  textSize(35);
  text("阅览室 A5", 40, 60);
  text("最大人数 "+max, 40, 115);
  text("1    2    3    4 ", 420, 57);
  if (ind<max) {
    addBall();
  } 
  if (ind>=max) {
    over();
  }
}



void mousePressed() {
  float A=dist(mouseX, mouseY, 460, 45);
  if (A<10) {
    a++;
    if (a % 3==1) {
      addball();
      v1=250;
      port.write("a");
    }
    if (a%3==0) {
      remball();
      v1=55;
      port.write("b");
    }
  }  
  float B=dist(mouseX, mouseY, 550, 45);
  if (B<10) {
    b++;
    if (b% 3==1) {
      addball();
      v2=250;
      port.write("c");
    }
    if (b%3==0) {
      remball();
      v2=55;
      port.write("d");
    }
  }
  float C=dist(mouseX, mouseY, 639, 45);
  if (C<10) {
    c++;
    if (c% 3==1) {
      addball();
      v3=250;
      port.write("e");
    }
    if (c%3==0) {
      remball();
      v3=55;
      port.write("f");
    }
  }
  float D=dist(mouseX, mouseY, 728, 45);
  if (D<10) {
    d++;
    if (d% 3==1) {
      addball();
      v4=250;
      port.write("g");
    }
    if (d%3==0) {
      remball();
      v4=55;
      port.write("h");
    }
  }
}

void addball() {
  Ball myLittleBall= new Ball(random(10, 30), random(70, 370), random(2*PI), random(255), random(255), random(100, 200));
  if (ind<max) {
    myBall.add(myLittleBall);
    ind++;
  }
  if (ind>max) {
    ind =max;
  }
}

void remball() {
  for (int i=0; i< myBall.size(); i++) {    
    Ball myLoclBall = (Ball)myBall.get(i);
  }
  ind--;
  if (ind>=0) {
    myBall.remove(0);
  }
  if (ind<0) {
    init();
  }
}


void addBall() {
  for (int i=0; i< myBall.size(); i++) {    
    Ball myLoclBall = (Ball)myBall.get(i);
    myLoclBall.behavior();
    textAlign(CENTER, CENTER);
    textSize(150);
    text(ind, 400, 380);
  }
}

void over() {
  fill(0);//字
  noStroke();
  rect(0, 0, 800, 800);
  textAlign(CENTER, CENTER);
  fill(255);
  textFont(font);
  textSize(80);
  text("满", 400, 390);
  textAlign(CENTER, CENTER);
  fill(255);
  textFont(font);
  textSize(35);
  text("阅览室 A5", 130, 70);
  text("1    2    3    4 ", 570, 40);
  strokeWeight(2);
  noFill();
  stroke(255, 200);
  ellipse(460, 45, 25, 25);
  ellipse(550, 45, 25, 25);
  ellipse(639, 45, 25, 25);
  ellipse(728, 45, 25, 25);
  //yuan-fang
  float totalDistance = 0;
  for (int i = 0; i < circle.size(); i++) {
    PVector v1;
    if (state) {
      v1 = circle.get(i);
    } else {
      v1 = square.get(i);
    } 
    PVector v2 = morph.get(i);
    v2.lerp(v1, 0.1);
    totalDistance += PVector.dist(v1, v2);
  }  
  if (totalDistance < 0.1) {
    state = !state;
  }  
  translate(width/2, height/2);
  strokeWeight(4);
  beginShape();
  noFill();
  stroke(255);
  for (PVector v : morph) {
    vertex(v.x, v.y);
  }
  endShape(CLOSE);
}