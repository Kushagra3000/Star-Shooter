class Drop {

  public 
  int x=int (random(width-100));
  int y=int (random(-200 , 100 ));
  int yspeed=int ( random(1,3) ) ; //objects ki speed bada di.

  void fall() {
    y=y+yspeed;

    if (y>height) {
      y=int ( random(-200, 100) );
    }
  }

  void show() {
    stroke(118, 43, 226);
    triangle(x , y , x , y + 60 , x - 20  , y  ) ;
    triangle(x + 60 , y , x + 60 , y + 60 , x + 80 , y ) ;  
    triangle(x , y + 60 , x + 60 , y + 60 , x + 30 , y + 90 ) ;
    rect(x, y, 60, 60);
  }
}
