class Ship extends Object 
{
  Ship() 
  {
    this.spawn();  //ship initially spawns
  }
 
  void show()  //ships appearance
  {
    noFill();
    stroke(#C10E0E);
    strokeWeight(2);
    rotate(r);
    beginShape();  //Begin drawing Ship
    vertex(0, 16);  //Lines to make 
    vertex(8, -16);
    vertex(-8, -16);
    vertex(0, 16); 
    endShape();  //End drawing ship
    rotate(-r);  
  }
   
  void spawn()  //ship spawns still in the middle of the screen
  {
    this.x = width/2;
    this.y = height/2;
    this.a = 0;
    this.v = 0;
    this.r = 0;
    this.w = 0;
    this.s = 12;
  }
   
  void accelerate() //gradually multiplies speed to simulate acceleration
  {
    float xt = cos(a)*v+cos(r+PI/2)*.2;
    float yt = sin(a)*v+sin(r+PI/2)*.2;
    v=sqrt(sq(yt)+sq(xt));
    a=atan2(yt, xt);
  }
 
  void shoot() //shooting fires a laser from the ship
  {
    if(zap.size() < 8)  //no more than 8 lasers at once
    {
      zap.add(new Laser(x, y, r+PI/2, r));  //laser comes from tip of ship
    }
  }
}
