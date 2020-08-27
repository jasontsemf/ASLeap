String swipeDirection = "";

void onFrame(final Controller controller)
{
  Frame frame = controller.frame();
  
  Pointable pointable = frame.pointables().frontmost();
  pPos = pointable.tipPosition();
  pointer.setLocation((int)(pPos.getX()*3)+width/2, (int)(pPos.getY()*(-3))+height*3/2);

  for (Gesture gesture : frame.gestures())
  {

    if (gesture.type() == Gesture.Type.TYPE_SWIPE && isSliding == "stop" && offset >= FRAME_OFFSET) {
      offset = 0;
      SwipeGesture swipeGesture = new SwipeGesture(gesture);

      Vector swipeVector  = swipeGesture.direction();
      
      Boolean isHorizontal = Math.abs(swipeVector.getX())>Math.abs(swipeVector.getY());
      if (isHorizontal) {
        if (swipeVector.getX() > 0 ) {
          //slideDirection = "right";
          
          left();
        } else {
          //slideDirection = "left";
          right();
        }
      } else { //vertical
        if (swipeVector.getY() > 0) {
          //slideDirection = "up";
          down();
          
        } else {
          //slideDirection = "down";
          up();
        }
      }
      println(swipeDirection + swipeGesture.state());
      
    }else if(gesture.type() == Gesture.Type.TYPE_SWIPE) {
      //for level selecting
    }
  }
  hand = null;
  for (Hand leapHand : frame.hands()){ hand = leapHand;}

}