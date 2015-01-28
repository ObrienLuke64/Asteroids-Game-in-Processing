//DT228-2 
//Programming Assignment 2
//By Luke O'Brien

float a;  //Variable for main menu scanner line
PImage marine;  //Loading a picture
PImage title;  //Loading a picture
PImage space;  //Loading a picture
PImage shipOn;  //Loading a picture

float transparency = 1;  //Used for image fade-in
PFont f;                //Declare font variable
boolean coin;  //Boolean to test if a coin has been instered
boolean help;  //Boolean for help menu
boolean mainMenu;  //Boolean for main menu
boolean gameStart;  //Boolean to start game

int score,  asteroidCount, level;  //Variables for current score, asteroids and ship level
ArrayList<Asteroid> rocks;  //Array of asteroids
ArrayList<Laser> zap;  //Array of laser projectile
Ship fist;  //(Fist is the ship's name)
boolean keyup = false;  //see if keys pressed
boolean keyright = false;  //see if keys pressed
boolean keyleft = false;  //see if keys pressed

//--------------------------------------------------------------------------------------

void setup()
{
  size(700, 700);    //Screen size
  noCursor();         //Remove mouse cursor from within the boundry of the project window
  f = createFont("Arial", 30, true);    //Creates font
  marine = loadImage("Idle.gif");       //Load picture
  title = loadImage("Title2.gif");      //Load picture
  space = loadImage("Space.gif");       //Load picture
  shipOn = loadImage("ShipOn.gif");     //Load picture

  a = 0;            //Scanner variable
  coin=true;        //Setting booleans
  help=false;       //Setting booleans
  mainMenu=true;    //Setting booleans
  gameStart=false;  //Setting booleans
  
  noFill();    //Disables geometry colour fill
  frameRate(50);  //Set framerate
  score = 0;  //Set score at beginning of game
  asteroidCount = 0;  //Set variable
  level = 1;          //Set variable
  rocks = new ArrayList<Asteroid>();  //Asteroids arraylist
  
 for (int i = 0; i < 1; i++)  //Loop to spawn asteroids in random places
 {
    rocks.add(new Asteroid(random(0, width), 0, random(-PI, PI), random(0.4, 0.8), random(-PI/100, PI/100), 32));
    rocks.add(new Asteroid(random(0, width), height, random(-PI, PI), random(0.4, 0.8), random(-PI/100, PI/100), 32));
    rocks.add(new Asteroid(0, random(0, height), random(-PI, PI), random(0.4, 0.8), random(-PI/100, PI/100), 32));
    rocks.add(new Asteroid(width, random(0, height), random(-PI, PI), random(0.4, 0.8), random(-PI/100, PI/100), 32));
  }
  zap = new ArrayList<Laser>();  //laser arraylist
  fist = new Ship();             //ship arraylist
}    

//--------------------------------------------------------------------------------------

void draw()
{
  if (mainMenu)
  {
    mainMenu();  //Calls mainmenu
  }
}

//--------------------------------------------------------------------------------------

void mainMenu()
{
  stroke(#2C9324);  //stroke colour
  background(50);  //background colour
  line(0, a, width, a); //For the repeating scanner line
  a = a + 5;          //For the repeating scanner line
  if (a > 700)          //For the repeating scanner line
  {                     
     a = 0;
  }                     
  
  if (millis() > 2000)  //Image fade in won't start for 1.5 seconds
  {
    if (transparency < 255)  //If the image isnt fully faded in
    { 
      transparency += 0.5;  //Fades in
    }
    tint(255, transparency);
    image(marine, -75, 200, 500, 500);
  }
  
  if (millis() > 2000)  //Image fade in won't start for 1.5 seconds
  {
    if (transparency < 255)  //If the image isnt fully faded in
    { 
      transparency += 0.5;  //Fades in
    }
    tint(255, transparency);
    image(title, 80, -50, 500, 250);
  }
    textFont(f, 50);      //Choose font
    
    if (coin)  //If coin not inserted
    {
       text("Insert Coin(s)", 350, 320);   //Display text
       if (keyPressed) 
       {
         coin=false;
       }
    }
    
    if (!coin)  //If coin inserted
    {
      text("Play [UP]", 350, 350);    //Display text
      text("Help [DOWN]", 350, 450);    //Display text
      text("Exit [ESC]", 350, 550);    //Display text
    }
    
  if (keyPressed)
  {
    if (key == CODED)
    {
      if (keyCode == UP) gameStart=true;  //start game if up is pressed
      if (keyCode == DOWN) help();        //show help screen when down is held
    }
  } 

    if (gameStart == true)
    {
      gameStart();
    }

}

//--------------------------------------------------------------------------------------

void help()
{
  clear();  //clear screen
  background(50);  //background colour
  textFont(f, 40);  //load font f
  image(shipOn, 100, 280, 500, 500);  //Picture
  text("Traverse the map and avoid making", 30, 50);     //display text
  text("impact with asteroids!", 150, 100);              //display text
  text("Asteroids will split into smaller", 80, 200);    //display text
  text("ones so watch out!", 180, 250);                  //display text
  text("Your ship will upgrade as you play!", 30, 350);  //display text
}

//--------------------------------------------------------------------------------------

void gameStart()
{
  clear();  //clear screen
   background(0);  //black background
   strokeWeight(1);  //line thinkness
   
  int grid = 70; //gap between grid lines
  
  for (int i = 0; i < width; i+=grid)   //drawing the grid
  {
    line (i, 0, i, height);  //drawing the grid
  }
  
  for (int i = 0; i < height; i+=grid)  //drawing the grid
  {
    line (0, i, width, i);  //drawing the grid
  }

  fist.display();
  fist.check();
   
  for (int i = 0; i < rocks.size(); i++) 
  {
    Asteroid rock = rocks.get(i);
    rock.display();
    rock.check();
     
    if(dist(rock.x, rock.y, fist.x, fist.y) < rock.s+fist.s)  //if ship collides with asteroid, you lose
    {
      textSize(64);
      fill(255);
      text("GAME OVER", width/5, height/4);
      textSize(32);
      text("Press 'R' to try again", width/5+50, height/3);
      noLoop();  //stops loop being called until game is reset
    }
     
    for (int j = 0; j < zap.size(); j++)  //detects if your laser hits an asteroid
    {
      Laser zip = zap.get(j);
      rock.collision(zip, i, j);
    }
  }
  
  for (int j = 0; j < zap.size(); j++)  //removes laser if it leaves screen
  {
    Laser zip = zap.get(j);
    zip.offScreen(j);
    zip.display();
    zip.check();
  }
   
  textSize(34);
  fill(#C10E0E);
  text("Score:" + score, 8, 32);  //Current score
  
  if (score>=10)  //score determines ship level
  {
    level=2;
  }
  
  if (score>=30)   //score determines ship level
  {
    level=3;
  }
  
  if (level==1)  //current Level of ship displayed on screen
  {
  text("Ship Lvl:" + level, 8, 690);
  }
  
  if (level==2)  //current Level of ship displayed on screen
  {
  text("Ship Lvl:" + level, 8, 690);
  }
  
  if (level==3)  //current Level of ship displayed on screen
  {
  text("Ship Lvl:" + level, 8, 690);
  }
   
  if (keyup == true) fist.accelerate();  //move forward when up pressed
  if (keyleft == true) fist.r -= 0.1;  //Turn left
  if (keyright == true) fist.r += 0.1;  //turn right
  fist.v*=0.95;  //Manages speed of ship. If its 1 or above the ship will slide forever
}
 
void keyPressed() //For in game controls
{
    if (key == CODED)
  {
    if (keyCode == UP) keyup = true;
    if (keyCode == LEFT) keyleft = true;
    if (keyCode == RIGHT) keyright = true;
  }
  if (key == ' ')  fist.shoot();  //Space triggers the ship to shoot
  if (key == 'r')  //r resets all gameplay variables and their positions
  {
    rocks.clear();  //Clear arraylist
    zap.clear();    //Clear arraylist
    fist.spawn();  //reset ship
    score = 0;    //reset score
    asteroidCount = 0;  //reset asteroids
    level=1;  //reset ship level
   for (int i = 0; i < 1; i++)   //reset asteroids and their positions
   {
      rocks.add(new Asteroid(random(0, width), 0, random(-PI, PI), random(0.4, 0.8), random(-PI/100, PI/100), 32));
      rocks.add(new Asteroid(random(0, width), height, random(-PI, PI), random(0.4, 0.8), random(-PI/100, PI/100), 32));
      rocks.add(new Asteroid(0, random(0, height), random(-PI, PI), random(0.4, 0.8), random(-PI/100, PI/100), 32));
      rocks.add(new Asteroid(width, random(0, height), random(-PI, PI), random(0.4, 0.8), random(-PI/100, PI/100), 32));
    }
    loop();  //Loops through draw, required to reset game 
  }
}
 
void keyReleased() //For in game movement
{
  if (key == CODED) 
  {
    if (keyCode == UP) keyup = false;
    if (keyCode == LEFT) keyleft = false;
    if (keyCode == RIGHT) keyright = false;
  }
}
