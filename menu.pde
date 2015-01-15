float a;
PImage marine;
PImage title;
float transparency = 1;
PFont f;                //Declare font variable

void setup()
{
  size(500, 500);
  f = createFont("Arial", 30, true);  //Creates font
  marine = loadImage("Idle.gif");
  title = loadImage("Title2.gif");
  a = 0;
}

void draw()
{
  mainMenu();
}

void mainMenu()
{
  stroke(#2C9324);
  background(50);
  line(0, a, width, a); //For the repeating scanner line
  a = a + 2.5;          //For the repeating scanner line
  if (a > 500)          //For the repeating scanner line
  {                     
    //a = -200;           //Resets line above screen to create a delay
     a = 0;
  }                     
  
  if (millis() > 2000)  //Image fade in won't start for 1.5 seconds
  {
    if (transparency < 255)  //If the image isnt fully faded in
    { 
      transparency += 0.5;  //Fades in
    }
    tint(255, transparency);
    image(marine, -75, 150, 400, 400);
  }
  
  if (millis() > 2000)  //Image fade in won't start for 1.5 seconds
  {
    if (transparency < 255)  //If the image isnt fully faded in
    { 
      transparency += 0.5;  //Fades in
    }
    tint(255, transparency);
    image(title, -5, -50, 500, 250);
  }
    textFont(f, 30);      //Choose font
    text("Play [Start]", 300, 250);    //Display text
    text("Help [A]", 300, 350);    //Display text
    text("Exit [B]", 300, 450);    //Display text
    
  if (keyPressed)
  {
    if (key == 'a' || key == 'A') 
    {
      //gameStart = true;
    }
    if (key == 'b' || key == 'B') 
    {
      help();
    }
    if (key == 'x' || key == 'X') 
    {
      exit();
    }
  } 
    
}

void help()
{
  
}

