class Laser extends Object 
{
  Laser(float x, float y, float a, float r) //all from object
  {
    this.x = x;
    this.y = y;
    this.a = a;
    this.v = 12;
    this.r = r;
    this.w = 0;
    this.s = 4;
  }
 
  void show() 
  {
    noFill();
    
    if (score<10)   //score determines laser appearance
    {
      stroke(#1FB720);
      strokeWeight(4);
      rotate(r);   //To match ship direction
      beginShape();
      vertex(0, 8);
      vertex(0, 0);
      endShape();
      rotate(-r);  //To match ship direction
    }
    if (score>=10)   //score determines laser appearance
    {
      stroke(#142FC4);
      strokeWeight(8);
      rotate(r);   //To match ship direction
      beginShape();
      vertex(0, 16);
      vertex(0, 0);
      endShape();
      rotate(-r);  //To match ship direction
    }
    if (score>=30)   //score determines laser appearance
    {
      stroke(#C414B8);
      strokeWeight(8);
      rotate(r);   //To match ship direction
      beginShape();
      vertex(0, 50);
      vertex(0, 0);
      endShape();
      rotate(-r);  //To match ship direction
    }
  }
 
  void offScreen(int j) //remove laser if it hits end of screen
  {
    if (x > width-v || x < 0+v || y > height-v || y < 0+v) zap.remove(j);
  }
}
