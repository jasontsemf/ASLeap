Boolean isConnected = true;

void onInit(final Controller controller)
{
  println("Initated");
  controller.enableGesture(Gesture.Type.TYPE_SWIPE);
  controller.enableGesture(Gesture.Type.TYPE_SCREEN_TAP);
}

void onConnect(Controller controller)
{
  println("Connected");
}

void onDisconnect(Controller controller)
{
  println("Disconnected");
}

//A overlay
void drawWarning() {
  rectMode(CENTER);
  noStroke();
  fill(192, 100);
  rect(width/2, height/2, 429, 248, 7);
}