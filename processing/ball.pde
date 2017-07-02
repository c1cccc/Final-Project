class Ball {

  float r;
  float d;
  float c;
  float cc;
  float a;
  float t;

  Ball(float r_, float d_, float a_, float c_, float cc_, float t_) {
    r=r_;
    d=d_;
    a=a_;
    c=c_;
    cc=cc_;
    t=t_;
  }


  void behavior() {
    pushMatrix();
    fill(c, cc, 255, t);  
    noStroke();
    a=a+150/d/d;
    ellipse(400+d* cos(a), 400+d*sin(a), 2*r, 2*r);
    noFill();
    stroke(c, cc, 255, 55);
    strokeWeight(2);
    ellipse(400, 400, 2*d, 2*d);
    popMatrix();
  }
}