abstract class Object 
{
  float x, y, a, v, r, w, s;  //Positions, counters, distances used in ALL classes
 
  void check()
  {
    r += w;
    x += cos(a)*v;
    y += sin(a)*v;
     
    if (x<0) 
    {
      x += width;
      y = height-y;
    }
    if (x>width)
    {
      x -= width;
      y = height-y;
    }
    if (y<0)
    {
      y += height;
      x = width-x;
    }
    if (y>height)
    {
      y -= height;
      x = width-x;
    }
  }
 
  void show() 
  {
  }
 
  void display() 
  {
    translate(x, y);
    show();
    translate(-x, -y);
 
    if (x < 1.25*s)
    {
      translate(x+width, height-y);
      show();
      translate(-x-width, y-height);
    }
 
    if (x > width-1.25*s) 
    {
      translate(x-width, height-y);
      show();
      translate(-x+width, y-height);
    }
 
    if (y < 1.25*s)
    {
      translate(width-x, y+height);
      show();
      translate(x-width, -y-height);
    }
 
    if (y > height-1.25*s)
    {
      translate(width-x, y-height);
      show();
      translate(x-width, -y+height);
    }
  }
}
