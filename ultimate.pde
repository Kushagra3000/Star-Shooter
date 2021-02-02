import processing.sound.* ;
SoundFile file;
SoundFile file_2;
String state ; 
Button single = new Button ( "Play Single Player", width + 600, height +300, 250, 150 ) ;
Button multi = new Button ( "Play Multiplayer", width + 600, height +500, 250, 150 ) ;
Button exit_game = new Button ( "Exit the Game", width + 600, height +700, 250, 150 ) ;
PImage img_1;
PImage img_2;
PImage img_3;
PImage img_4;
int score = 0 ;
boolean boxhide = false ;
Drop[] drops = new Drop[5];
int store_score = 0 ;
Timer countTimer = new Timer(1000);
int timeLeft;
int maxtime = 3100;
int score_final = 0 ;
int score_p1 = 0 ;
int score_p2 = 0 ;
int time = 1000 ; 
boolean textstate = false;
void setup()
{
  img_1 = loadImage("download.jpg");
  fullScreen();
  //size( 1400 ,1600);
  image(img_1, 0, 0, width, height ) ;
  file = new SoundFile(this, "missile.mp3");
  file_2 = new SoundFile(this, "start.mp3" ) ;
  state = "title";
  for ( int i = 0; i < drops.length; i++)
  {
    drops[i] = new Drop();
  }
  time = millis();
  Timer countTimer = new Timer(10000);
  timeLeft = maxtime ;
}

void draw()
{
  if ( state == "title" ) 
  {
    title();
  } else if ( state == "sgame")
  {
    sgame();
  } else if ( state == "mgame" )
  {
    mgame() ;
  } else if (state == "crazy")
  {
    player2();
  } 
}

void mousePressed()
{
  if (single.MouseIsOver() && state == "title")
  {
    state = "sgame";
    file_2.play();
    countTimer.start();
  } else if ( multi.MouseIsOver() && state == "title")
  {
    state = "mgame" ;
    file_2.play();
    countTimer.start();
  } else if (state == "sgame" )
  {
    stroke ( 250);
    line ( mouseX, mouseY, height, width ) ;
    boxhide = !( boxhide ) ;
  } else if ( state == "mgame") 
  {

    stroke(250);
    line ( mouseX, mouseY, height, width ) ;
    boxhide = !( boxhide ) ;
  } else if ( state == "crazy") 
  {
    stroke ( 250);
    line ( mouseX, mouseY, height, width ) ;
    boxhide = !( boxhide ) ;
  }
  if (textstate == true )
  {
    delay(1000);
  } else if (exit_game.MouseIsOver())
  {
    exit();
  }
}

void title()
{
  score = 0 ;
  boxhide = false;
  store_score = 0 ;
  timeLeft = maxtime ;

  image(img_1, 0, 0, width, height ) ;
  single.Draw();
  multi.Draw();
  exit_game.Draw();
}

void sgame()
{
  score_final = 0 ;
  //background(0) ;
  fill(0, 150 );
  rect(0, 0, width, height);
  //image(img_1, 0, 0, width, height ) ;
  fill(255);
  ellipse(random(width), random(height), 5, 5);
  textSize ( 50 ) ;
  text("Score :  " + score, 150, 100 );

  if (countTimer.complete() == true ) 
  {
    if (timeLeft > 1 ) {
      timeLeft -- ;
    } else {

      state = "exit_game" ;
      score_final = score ;
      timeLeft = maxtime ;
      exit_game();
    }
  }
  textAlign(LEFT);
  text("Time Left: " + int(timeLeft /100), width - 400, 100);
  for (int i=0; i<drops.length; i++) {
    drops[i].fall();
    drops[i].show();
  } 
  if ( boxhide )
  {
    for ( int i = 0; i < drops.length; i++ ) 
    {
      if ( ( drops [ i ].x  < mouseX )&& ( mouseX < drops[i].x + 60) && ( ( drops [ i ].y  < mouseY )&& ( mouseY < drops[i].y + 60))  ) 
      {
        drops[i].x = int (random(width-100));
        drops[i].y = int (random(-200, 100)); 
        drops[i].fall();
        rect ( mouseX, mouseY, 60, 60 ); 
        score = score  + 1; 
        file.play();
      }
    }
    boxhide = !(boxhide) ;
  }
  ellipse ( mouseX, mouseY, 30, 30 ) ;
}

void resetGame()
{
  timeLeft = maxtime;
}
void exit_game()
{
  fill(255);
  background( 255 );
  textSize( 100 );
  textAlign( CENTER );
  {
    fill(255);
    //delay(5000);
    message();
  }

  state = "title";
}
void message()
{

  if (millis() < time + 10000)
  {
    textstate = true ;
    textSize( 100 );
    textAlign( CENTER );
    text("the game is over. Your score is : " + score_final, width / 2, height / 2 ) ;
  }
}

void mgame()
{


  fill(0);  
  rect ( 0, 0, width, height ) ;
  textAlign ( CENTER ) ;
  fill( 255 ) ;
  textSize(50);
  text("The game is entering the multiplayer mode now.", width /2, height/2 );
  text("Its player 1s turn now.", width / 2, height / 2 + 60) ;
  fill(0, 150 );
  rect(0, 0, width, height);
  fill(255);
  ellipse(random(width), random(height), 5, 5);
  textSize ( 50 ) ;
  text("Score :  " + score_p1, 150, 100 );


  textAlign(LEFT);
  text("Time Left: " + int(timeLeft /100), width - 400, 100);
  for (int i=0; i<drops.length; i++) {
    drops[i].fall();
    drops[i].show();
  } 
  if ( boxhide )
  {
    for ( int i = 0; i < drops.length; i++ ) 
    {
      if ( ( drops [ i ].x  < mouseX )&& ( mouseX < drops[i].x + 60) && ( ( drops [ i ].y  < mouseY )&& ( mouseY < drops[i].y + 60))  ) 
      {
        drops[i].x = int (random(width-100));
        drops[i].y = int (random(-200, 100)); 
        drops[i].fall();
        rect ( mouseX, mouseY, 60, 60 ); 
        score_p1 = score_p1  + 1; 
        file.play();
      }
    }
    boxhide = !(boxhide) ;
  }
  ellipse ( mouseX, mouseY, 30, 30 ) ;
  if (countTimer.complete() == true ) 
  {
    if (timeLeft > 1 ) {
      timeLeft -- ;
    } else {
      fill( 0 ) ;
      rect ( 0, 0, width, height ) ;
      fill( 255 );
      delayer();
      timeLeft = maxtime ;
      state = "crazy" ;
    }
  }
}

void delayer()
{
  delay(5000);
}

/*void player2()
 {
 int score_p2 = 0 ;
 fill(0);
 rect( 0 ,0 , width , height);
 fill(255);
 textAlign(CENTER);
 score = 0 ;
 maxtime = 650 ;
 timeLeft = maxtime ;
 text("Your turn is over.\nIts player 2s turn now.", width / 2, height / 2 ) ;
 fill(0, 150 );
 rect(0, 0, width, height);
 //image(img_1, 0, 0, width, height ) ;
 fill(255);
 ellipse(random(width), random(height), 5, 5);
 
 for (int i=0; i<drops.length; i++) {
 drops[i].fall();
 drops[i].show();
 } 
 textSize ( 50 ) ;
 text("Score :  " + score, 150, 100 );
 textAlign(LEFT);
 text("Time Left: " + int(timeLeft /100), width - 400, 100);
 if ( boxhide )
 {
 for ( int i = 0; i < drops.length; i++ ) 
 {
 if ( ( drops [ i ].x  < mouseX )&& ( mouseX < drops[i].x + 60) && ( ( drops [ i ].y  < mouseY )&& ( mouseY < drops[i].y + 60))  ) 
 {
 drops[i].x = int (random(width-100));
 drops[i].y = int (random(-200, 100)); 
 drops[i].fall();
 rect ( mouseX, mouseY, 60, 60 ); 
 score = score  + 1; 
 file.play();
 }
 }
 boxhide = !(boxhide) ;
 }
 ellipse ( mouseX, mouseY, 30, 30 ) ;
 if (countTimer.complete() == true ) 
 {
 if (timeLeft > 1 ) {
 timeLeft -- ;
 } else {
 score_p2 = score ;
 fill( 0 ) ;
 rect ( 0 , 0 ,width , height ) ;
 fill( 255 );
 
 }
 }
 
 }
 */

void player2()
{


  fill(0, 150 );
  rect(0, 0, width, height);
  //image(img_1, 0, 0, width, height ) ;
  fill(255);
  textAlign(CENTER);


  text("Its player 2s turn now.", width / 2, height / 2 ) ;
  ellipse(random(width), random(height), 5, 5);
  textSize ( 50 ) ;
  text("Score :  " + score_p2, 150, 100 );
  if (score_p1>score_p2)
  {
    text("Player 1 is winning ", width/2, height -100);
  } else if ( score_p1 == score_p2)
  {
    text("It is a tie", width/2, height -100 ) ;
  } else if ( score_p1 < score_p2 )
  {
    text("player2 has won", width/2, height -100);
  }


  if (countTimer.complete() == true ) 
  {
    if (timeLeft > 1 ) {
      timeLeft -- ;
    } else {

      fill( 0 ) ;
      rect ( 0, 0, width, height ) ;
      fill( 255 );
      delayer();
      state = "title";
    }
  }
  textAlign(LEFT);
  text("Time Left: " + int(timeLeft /100), width - 400, 100);
  for (int i=0; i<drops.length; i++) {
    drops[i].fall();
    drops[i].show();
  } 
  if ( boxhide )
  {
    for ( int i = 0; i < drops.length; i++ ) 
    {
      if ( ( drops [ i ].x  < mouseX )&& ( mouseX < drops[i].x + 60) && ( ( drops [ i ].y  < mouseY )&& ( mouseY < drops[i].y + 60))  ) 
      {
        drops[i].x = int (random(width-100));
        drops[i].y = int (random(-200, 100)); 
        drops[i].fall();
        rect ( mouseX, mouseY, 60, 60 ); 
        score_p2 = score_p2  + 1; 
        file.play();
      }
    }
    boxhide = !(boxhide) ;
  }
  ellipse ( mouseX, mouseY, 30, 30 ) ;
}
