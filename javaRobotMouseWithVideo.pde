import processing.video.*; 
import java.awt.*;

Capture video; 

float targetRed,targetGreen, targetBlue;

RoboMouse robo; 
boolean trackingOn = false;


 
void setup(){
  size(640, 480);
  noStroke();
  robo = new RoboMouse(screen.width/2,
            screen.height/2, 1);

  video = new Capture(this, 640, 480, 12); //initiate the video, resolution and frame rate

  size(640, 480); //give you Processingwindow a size

}

void captureEvent(Capture camera) 
{ 
  camera.read(); //read in the video frame
  horizontalFlip();  // flip the current frame so it mirrors the 
  image(video, 0, 0); //paint the video to the screen
  
} 

void draw(){
  fill(200, 40);
 
  // Uncheck to keep mouse in sketch window
  // robo.checkBoundaries();
 
  fill(255);
 
  robo.x += 1;
  robo.y += 1;
  
    
 Point bestPoint = trackColor(); //track the target color

  //after all the pixels have been tested, draw the winner
  fill(255,0,0);
  ellipse(bestPoint.x, bestPoint.y, 30, 30);

  if (trackingOn) {
    int tx = (int)map(bestPoint.x, 0,width, 0, screen.width);
    int ty = (int)map(bestPoint.y, 0,height,0,screen.height);
   robo.move(tx,ty);
  }
}

Point trackColor() {
  float worldRecord = 1000.0; //intialize the worldrecord
  int xFound = 0; // initialize the location of the red tracking ball
  int yFound = 0;

  for(int row=0; row<video.height; row=row+1) { //for each row
    for(int col=0; col<video.width; col=col+1) { //for each column
      //get the color of this pixels
      //find pixel in linear array using formula: pos = row*rowWidth+column
      color pix = video.pixels[row*video.width+col]; 
      //find the difference
     int diff = (int) dist(targetRed,targetGreen,targetBlue, red(pix), green(pix), blue(pix));
 
      if (diff< worldRecord){ // if this is closest to our target color
        worldRecord = diff;
        yFound = row; //mark the spot for drawing it later
        xFound = col;
      }
    }
  } 
  
  Point tempPoint = new Point(xFound, yFound);
  return tempPoint; 
  
}

void mousePressed(){
  //allow the target color to be changed 
  color pix = video.pixels[mouseY*video.width+mouseX];
  targetRed = red(pix); //get the color of the pixel they clicked on
  targetGreen = green(pix);
  targetBlue = blue(pix);
  trackingOn = !trackingOn;
}

void horizontalFlip() {
  //create an array to hold the newly arranged pixels
  color[] newImage = new color[video.height*video.width];

  //loop through the pixels of the video
  for(int row=1; row<video.height-1; row=row+1) { //for each row
    for(int col=1; col<video.width-1; col=col+1) { //for each column 
    
      newImage[row*video.width+(width-col-1)] = video.pixels[row*video.width+col]; // the newImage array reorganizes the pixels so left is on the right and the right is on the left
    }
  }
  video.pixels = newImage; //set video to the newImage array. replaces the old image with the new flipped version
}

