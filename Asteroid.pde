class Asteroid extends Object 
{
  float[] vertx = new float[16];   //array of vertices, asteroids shape made from 16 lines
  float[] verty = new float[16];   //array of vertices, asteroids shape made from 16 lines
  
  Asteroid(float x, float y, float a, float v, float w, float s) //All from object class
  {
    this.x = x;
    this.y = y;
    this.a = a;
    this.v = v;
    this.r = 0;
    this.w = w;
    this.s = s;
    
    for (int i = 0; i < 16; i++)  //setting points
    {
      vertx[i] = sin(i*PI/8)*(s + random(-s/4, s/4));
      verty[i] = cos(i*PI/8)*(s + random(-s/4, s/4));
       
    }
  }
 
  void show()  //displays asteroids
  {
    noFill();
    stroke(255);
    strokeWeight(2);  //line thinkness
    rotate(r);  //Makes them spin
    beginShape();  //starts drawing shape using vertices
    for (int i = 0; i < 16; i++)  //loop for drawing lines
    {
      vertex(vertx[i], verty[i]);
    }
    vertex(vertx[0], verty[0]);
    endShape();  //ends drawing shape using vertices
    rotate(-r);  //Makes them spin
    
  }
 
  void collision(Object thing, int i, int j)  //has an asteroid hit a laser?
  {
    if (dist(this.x, this.y, thing.x, thing.y) < this.s+thing.s ||
        dist(this.x+width, height-this.y, thing.x, thing.y) < this.s+thing.s ||
        dist(this.x-width, height-this.y, thing.x, thing.y) < this.s+thing.s ||
        dist(width-this.x, this.y+height, thing.x, thing.y) < this.s+thing.s ||
        dist(width-this.x, this.y-height, thing.x, thing.y) < this.s+thing.s)
        {
      score++;  //you get a point
      zap.remove(j);  //laser goes away
      if (s>4)  //spawn a new asteroid
      {
        rocks.add(new Asteroid(x, y, a-PI/8, v*2, w*2, s/2));
        rocks.add(new Asteroid(x, y, a+PI/8, v*2, w*2, s/2));
      }
      asteroidCount++;
      if(asteroidCount == 4)  //spawn more asteroids
      {
        asteroidCount = 0;
        rocks.add(new Asteroid(fist.x+random(128, width-128), fist.y+random(128, height-128), random(-PI, PI), random(0.4, 0.8), random(-PI/100, PI/100), 32));
      }
      rocks.remove(i);  //remove an asteroid from the screen
    }
  }
}
