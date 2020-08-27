import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import com.leapmotion.leap.*; 
import com.leapmotion.leap.processing.LeapMotion; 
import java.util.Stack; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ASL extends PApplet {





PFont f, signFont;

LeapMotion leapMotion;


//variable for sliding animation
Stack screens = new Stack();
String thisScreen = "title";
String previousScreen;
String nextUp, nextDown, nextLeft, nextRight;
int aniCenterX, aniCenterY;
float speed =10;

final static int FRAME_OFFSET = 120; //two sec

public void setup() {

  leapMotion = new LeapMotion(this);

  
  f = createFont("OpenSans-Light.ttf", 16);
  signFont = createFont("GallaudetRegular.ttf", 32);

  nextUp = nextDown = nextLeft = nextRight = null;
  aniCenterX = width/2;
  aniCenterY = height/2;
}


String isSliding = "stop";
String slideDirection;
public void draw() {
  //slide in
  switch (isSliding) {
    case "in":
    switch (swipeDirection) {
      case "up":
      aniCenterY+=speed;
      //if(aniCenterY>=height/2){isSliding = false; println("Up Sliding ended.");}
      break;

      case "down":
      aniCenterY-=speed;
      //if(aniCenterY<=height/2){isSliding = false; println("Down Sliding ended.");}
      break;

      case "left":
      aniCenterX+=speed;
      //if(aniCenterX>=width/2){isSliding = false; println("Left Sliding ended.");}
      break;

      case "right":
      aniCenterX-=speed;
      //if(aniCenterX<=width/2){isSliding = false; println("Right Sliding ended.");}
      break;
    }
    if(aniCenterX==width/2&&aniCenterY==height/2){isSliding = "stop"; println("Sliding ended.");}
    break;
    case "out":

    break;
  }
  drawScreen();
}

//this function responsible for changing screen
public void drawScreen() {

  nextUp = nextDown = nextLeft = nextRight = null;

  switch (thisScreen) {
    case "title":
    nextUp = "exit";
    nextLeft = "setting";
    nextRight = "info";
    nextDown = "start";
    drawTitleScreen();
    break;

    case "setting":
    nextRight = "back";
    drawSetting();
    break;

    case "info":
    nextLeft = "back";
    drawInfo();
    break;

    case "start":
    nextUp = "back";
    nextLeft = "lvl";
    nextRight = "quiz";
    break;

    case "quiz":
    nextLeft = "back";
    break;

    case "quizResult":
    nextLeft = "back"; //this return to the start screen
    break;

    case "lvl":
    nextRight = "back";
    break;

    case "learn":
    nextUp = "back";
    break;

    case "exit":
    nextLeft = "confirmExit";
    nextRight = "back";
    break;

    case "confirmExit":
    exit();
    break;
  }
}

//alternative way to use the app
public void keyReleased() {
  if (key == CODED && isSliding == "stop") {
    if (keyCode == UP && nextUp != null) {
      up();
      } else if (keyCode == DOWN && nextDown != null) {
        down();
        } else if (keyCode == LEFT && nextLeft != null) {
          left();
          } else if (keyCode == RIGHT && nextRight != null) {
            right();
          }
        }
      }
public void up(){
  if(nextUp=="back"){
    thisScreen = (String) screens.pop();
  }else{
    screens.push(new String(thisScreen));
    thisScreen = nextUp;
    aniCenterY -= height;
    swipeDirection = "up";

    isSliding = "in";
  }
}

public void down(){
  if(nextDown=="back"){
    thisScreen = (String) screens.pop();
  }else{
    screens.push(new String(thisScreen));
    thisScreen = nextDown;
    aniCenterY += height;
    swipeDirection = "down";

    isSliding = "in";
  }
}

public void left(){
  if(nextLeft=="back"){
    thisScreen = (String) screens.pop();
  }else{
    screens.push(new String(thisScreen));
    thisScreen = nextLeft;
    aniCenterX -= width;
    swipeDirection = "left";

    isSliding = "in";
  }

}
public void right(){
  if(nextRight=="back"){
    thisScreen = (String) screens.pop();
  }else{
    screens.push(new String(thisScreen));
    thisScreen = nextRight;
    aniCenterX += width;
    swipeDirection = "right";

    isSliding = "in";
  }
}

String swipeDirection = "";

public void onFrame(final Controller controller)
{
  Frame frame = controller.frame();
  for (Gesture gesture : frame.gestures())
  {

    if (gesture.type() == Gesture.Type.TYPE_SWIPE) {
      SwipeGesture swipeGesture = new SwipeGesture(gesture);

      Vector swipeVector  = swipeGesture.direction();
      
      Boolean isHorizontal = Math.abs(swipeVector.getX())>Math.abs(swipeVector.getY());
      if (isHorizontal) {
        if (swipeVector.getX() > 0) {
          swipeDirection = "right";
        } else {
          swipeDirection = "left";
        }
      } else { //vertical
        if (swipeVector.getY() > 0) {
          swipeDirection = "up";
        } else {
          swipeDirection = "down";
        }
      }
      println(swipeDirection + swipeGesture.state());
      
    }else if(gesture.type() == Gesture.Type.TYPE_SWIPE) {
      //for level selecting
    }
  }

}
public void onInit(final Controller controller)
{
  println("Initated");
  controller.enableGesture(Gesture.Type.TYPE_SWIPE);
  controller.enableGesture(Gesture.Type.TYPE_SCREEN_TAP);
}

public void onConnect(Controller controller)
{
  println("Connected");
}

public void onDisconnect(Controller controller)
{
  println("Disconnected");
  drawWarning();
}

//A overlay
public void drawWarning() {
  rectMode(CENTER);
  noStroke();
  fill(192, 100);
  rect(width/2, height/2, 429, 248, 7);
}
 public void drawTitleScreen() {
  rectMode(CENTER);
  noStroke();
  fill(255);
  rect(aniCenterX,aniCenterY,width,height);
  fill(211);
  rect(aniCenterX,aniCenterY, 837, 192);

  textFont(signFont, 66);
  fill(43);
  textAlign(CENTER);
  text("intro to ASL", aniCenterX, 297);

  textFont(f, 101);
  fill(92);
  textAlign(CENTER);
  text("Intro to ASL", aniCenterX, 239);
}

public void drawInfo(){
  rectMode(CENTER);
  noStroke();
  fill(255);
  rect(aniCenterX,aniCenterY,width,height);

  textFont(f, 101);
  fill(92);
  textAlign(CENTER);
  text("Info", aniCenterX, 239);
}

public void drawSetting(){
  rectMode(CENTER);
  noStroke();
  fill(255);
  rect(aniCenterX,aniCenterY,width,height);

  fill(92);
  textAlign(CENTER);
  text("Setting", aniCenterX, 239);
}

public void drawStart(){
  rectMode(CENTER);
  noStroke();
  fill(255);
  rect(aniCenterX,aniCenterY,width,height);

  textFont(f, 101);
  fill(92);
  textAlign(CENTER);
  text("Please choose ", aniCenterX, 239);

}
  public void settings() {  size(1600, 900); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ASL" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
