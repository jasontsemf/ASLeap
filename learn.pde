char[] alphabets = "abcdefghijklmnopqrstuvwxyz".toCharArray();
char[] Alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray();

int[] correct = new int[26];

int currentChar = 27;
static final String tut = "Select the alphabets by pointing.";

void drawLearn(int aniCenterX, int aniCenterY) {
  rectMode(CENTER);
  noStroke();
  fill(247);
  rect(aniCenterX, aniCenterY, width, height);

  if (pointer.getX()<50 && pointer.getY()>0 && pointer.getY()<height) {
    currentChar = (int) pointer.getY()/(height/26);
    if (currentChar > 25) {
      currentChar = 25;
    }
    if (currentChar < 0) {
      currentChar = 0;
    }
    println(alphabets[currentChar]);
  }

  for (int i=0; i<alphabets.length; i++) {
    if (i == currentChar) {
      textFont(fb, 16);
    } else {
      textFont(f, 16);
    }
    if (correct[i] == 1) {
      fill(0, 153, 0);
    } else {
      fill(97);
    }
    textAlign(LEFT);
    text(alphabets[i], 10, (aniCenterY*2-10)*(i+1)/26);
  }


  //draw the tutorial
  if (currentChar == 27) {
    textFont(f, 23);
    fill(97);
    textAlign(LEFT);
    text(tut, width*5/6, aniCenterY, width/4, height/2);
  } else if (currentChar == 26) {
    textFont(f, 23);
    fill(97);
    textAlign(LEFT);
    text("Congrats, all character done!", width*5/6, aniCenterY, width/4, height/2);
  } else {
    //draw the corrsponding alphabet

    textFont(fb, 80);
    if (detectedLetter == Alphabets[currentChar]) {
      correct[currentChar] = 1;
      if (currentChar < 26) { 
        currentChar++;
      }
    }

    fill(97);
    textAlign(LEFT);
    text(Alphabets[currentChar], width*2/3, aniCenterY+height/4);


    //draw the sign
    textFont(signFont, 282);
    fill(97);
    textAlign(LEFT);
    text(Alphabets[currentChar], width*2/3, aniCenterY);
  }
}