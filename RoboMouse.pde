 
class RoboMouse{
 
  Robot robot;
  int x, y;
  float speed;
 
  RoboMouse(float x, float y, float speed){
    try { 
      robot = new Robot();
    } 
    catch (AWTException e) {
      e.printStackTrace(); 
    }
  }
 
 /*
  void checkBoundaries(){
    if (x>width+localX){
      x = width+localX;
      //speed *= -1;
    }
    if (x<localX){
      x = localX;
      //speedX *= -1;
    }
    if (y>height-localY){
      y = height-localY;
      //speedY *= -1;
    }
    if (y<localY){
      y = localY;
      //speedY *= -1;
    }
  }
  */
 
  void move(int _x, int _y){
    x = _x;
    y = _y;
    robot.mouseMove((int)x,(int)y);
  }
}
