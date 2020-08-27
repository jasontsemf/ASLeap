import com.leapmotion.leap.*;
import com.leapmotion.leap.processing.LeapMotion;
import java.util.Stack;
import java.awt.Point;
import java.util.Random;

PFont f, fb, signFont;

LeapMotion leapMotion;
Controller controller = new Controller();
Hand hand;


//variable for sliding animation
Stack screens = new Stack();
String thisScreen = "Title";
String previousScreen;
String nextUp, nextDown, nextLeft, nextRight;
int aniCenterX, aniCenterY;
float speedRate = 1.05;
float speed = 10;

final static int FRAME_OFFSET = 30; //half sec
int offset = 0;

void setup() {

  leapMotion = new LeapMotion(this);

  size(800, 450);
  f = createFont("OpenSans-Light.ttf", 16);
  fb = createFont("OpenSans-Semibold.ttf", 16);
  signFont = createFont("GallaudetRegular.ttf", 32);

  nextUp = nextDown = nextLeft = nextRight = null;
  aniCenterX = width/2;
  aniCenterY = height/2;
  
  setupIdentifier();

}


String isSliding = "stop";
String slideDirection;

void update() {


  switch (isSliding) {

  case "in":  //slide in
    speed *= speedRate;
    switch (slideDirection) {
    case "up":
      aniCenterY+=speed;
      if (aniCenterY>=height/2) {
        println("Up Sliding ended.");
        aniCenterY=height/2;
      }
      break;

    case "down":
      aniCenterY-=speed;
      if (aniCenterY<=height/2) {
        println("Down Sliding ended.");
        aniCenterY = height/2;
      }
      break;

    case "left":
      aniCenterX+=speed;
      if (aniCenterX>=width/2) {
        println("Left Sliding ended.");
        aniCenterX = width/2;
      }
      break;

    case "right":
      aniCenterX-=speed;
      if (aniCenterX<=width/2) {
        println("Right Sliding ended.");
        aniCenterX = width/2;
      }
      break;
    }
    if (aniCenterX==width/2&&aniCenterY==height/2) {
      isSliding = "stop"; 
      println("Sliding ended."); 
      offset = 0;
      speed =1;
    }
    break;
  case "out":
    //slide out
    speed *= speedRate;
    switch (slideDirection) {
    case "up":
      aniCenterY+=speed;
      if (aniCenterY>=height/2) {
        println("Up Sliding ended.");
        aniCenterY=height/2;
      }
      break;

    case "down":
      aniCenterY-=speed;
      if (aniCenterY<=height/2) {
        println("Down Sliding ended.");
        aniCenterY = height/2;
      }
      break;

    case "left":
      aniCenterX+=speed;
      if (aniCenterX>=width/2) {
        println("Left Sliding ended.");
        aniCenterX = width/2;
      }
      break;

    case "right":
      aniCenterX-=speed;
      if (aniCenterX<=width/2) {
        println("Right Sliding ended.");
        aniCenterX = width/2;
      }
      break;
    }
    if (aniCenterX==width/2&&aniCenterY==height/2) {
      isSliding = "stop"; 
      println("Sliding ended."); 
      offset = 0;
      speed =1;
    }
    break;
  case "stop":
    if (offset<FRAME_OFFSET) {
      offset++;
    }
    println(offset);
    break;
  }
  //pointer = new Point((int)(pPos.getX()*6)+width/2, (int)(pPos.getY()*(-6))+height*3/2);
}
Vector pPos;
Point pointer = new Point(-100, -100); //calibrated
void draw() {
  update(); //update the variable
  drawScreen(thisScreen);
  if(isSliding == "stop")
  drawNavigator();

  //fill(51, 50);
  //ellipse((float)pointer.getX(),(float)pointer.getY(), 55, 55);

  //if(!isConnected){
  //  drawWarning();
  //}
}

//this function responsible for building screen structure
void drawScreen(String screen) {

  nextUp = nextDown = nextLeft = nextRight = null;

  switch (screen) {
  case "Title":
    nextLeft = "Exit";
    nextRight = "Start";
    nextDown = "Info";
    drawTitleScreen();
    break;

  case "Info":
    nextUp = "Back";
    drawInfo();
    break;

  case "Start":
    nextLeft = "Back";
    nextUp = "Learn";
    nextDown = "Quiz";
    drawStart();
    break;

  case "Quiz":
    nextUp = "Back";
    getHandInfo(controller.frame());
    drawQuiz(aniCenterX, aniCenterY);
    if (hand != null && isSliding == "stop") {
      drawHand(hand);
    }
   
    break;
    
  case "QuizResult":
    nextRight = "Back"; //this return to the start screen

    drawQuizResult();
    break;

  case "A-Z": //A-Z select
    nextRight = "Back";

    break;

  case "Learn":
    getHandInfo(controller.frame());
    nextDown = "Back";
    //nextLeft = "A-Z";
    drawLearn(aniCenterX, aniCenterY);
    if (hand != null && isSliding == "stop") {
      drawHand(hand);
    }
    break;

  case "Exit":
    nextLeft = "Confirm";
    nextRight = "Back";
    drawConfirm();
    break;

  case "Confirm":
    drawBye();
    exit();
    break;
  }
}

//alternative way to use the app
void keyReleased() {
  if (key == CODED && isSliding == "stop") {
    if (keyCode == UP) {
      up();
    } else if (keyCode == DOWN) {
      down();
    } else if (keyCode == LEFT) {
      left();
    } else if (keyCode == RIGHT) {
      right();
    }
  }
}