void up() {
  if (nextUp != null) {
    if (nextUp=="Back") {
      thisScreen = (String) screens.pop();
    } else {
      screens.push(new String(thisScreen));
      thisScreen = nextUp;
      aniCenterY -= height;
      slideDirection = "up";

      isSliding = "in";
    }
  }
}

void down() {
  if (nextDown != null) {
    if (nextDown=="Back") {
      thisScreen = (String) screens.pop();
    } else {
      screens.push(new String(thisScreen));
      thisScreen = nextDown;
      aniCenterY += height;
      slideDirection = "down";

      isSliding = "in";
    }
  }
}

void left() {
  if (nextLeft != null) {
    if (nextLeft=="Back") {
      thisScreen = (String) screens.pop();
    } else {
      screens.push(new String(thisScreen));
      thisScreen = nextLeft;
      aniCenterX -= width;
      slideDirection = "left";

      isSliding = "in";
    }
  }
}
void right() {
  if (nextRight != null) {
    if (nextRight=="Back") {
      thisScreen = (String) screens.pop();
    } else {
      screens.push(new String(thisScreen));
      thisScreen = nextRight;
      aniCenterX += width;
      slideDirection = "right";

      isSliding = "in";
    }
  }
}

void drawNavigator() {

  fill(155,200);
  if (nextUp!=null) {


    int x = 737;
    int y = 369;
    int w = 7;
    int h = 10;
    triangle(x+w, y+h, x-w, y+h, x, y);
  }

  if (nextDown!=null) {


    int x = 737;
    int y = 430;
    int w = 7;
    int h = -10;
    triangle(x+w, y+h, x-w, y+h, x, y);
  }

  if (nextLeft!=null) {


    int x = 707;
    int y = 399;
    int w = 7;
    int h = 10;
    triangle(x+h, y+w, x, y, x+h, y-w);
  }
  if (nextRight!=null) {

    int x = 766;
    int y = 399;
    int w = 7;
    int h = -10;
    triangle(x+h, y+w, x, y, x+h, y-w);
  }
}