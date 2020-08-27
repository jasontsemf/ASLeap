char[] seq = "12345".toCharArray();
char[] Seq = "ABCDEFGHILO".toCharArray();
String[] correctAns = new String[5];
int tick;
int currentQ = 6;
static final String txt = "ready";

int time;
int wait = 5000;
boolean isStart = false;
boolean isFirst = true;
float score;

//ask to confirm
void drawQuiz(int aniCenterX, int aniCenterY){ 
  rectMode(CENTER);
  noStroke();
  fill(247);
  rect(aniCenterX, aniCenterY, width, height);
  
  //right space
    if (currentQ > 6) {
      currentQ = 6;
    }
    if (currentQ < 0) {
      currentQ = 0;
    }
    println(Seq[currentQ]);
    
  //side menu
  for (int i=0; i<seq.length; i++) {
    if (i == currentQ) {
      textFont(fb, 16);
    } else {
      textFont(f, 16);
    }
    if (correctAns[i] == "Correct") {
      fill(0, 153, 0);
    } else {
      fill(97);
    }
    textAlign(LEFT);
    text(seq[i], 5, (aniCenterY*2-10)*(i+1)/ 10);
  }

  //draw the quiz
  if (currentQ == 6) {
    //start
    textFont(f, 23);
    fill(97);
    textAlign(LEFT);
    text(txt, width*5/6, aniCenterY, width/4, height/2);
    
    //timer 
    if(isSliding == "stop"){
        time = millis();
        currentQ = 0;
        tick = 0;
    }
    
    //random seq
      for( int i=0 ; i<Seq.length-1 ; i++ )
    {
        Random r = new Random();  
        int j = r.nextInt(Seq.length-1);
        // Swap letters
        char temp = Seq[i]; 
        Seq[i] = Seq[j]; 
        Seq[j] = temp;
  } 
  } else if (currentQ == 5) {
    textFont(f, 23);
    fill(97);
    textAlign(LEFT);
    text("Congrats, all character done!", width*5/6, aniCenterY, width/4, height/2);
    drawQuizResult();
  } else {
    //draw the corrsponding alphabet
    textFont(fb, 80);
    if (detectedLetter == Seq[currentQ]) {
      correctAns[currentQ] = "Correct";
      tick++;
      if (currentQ < 5) {
        currentQ++;
        time = millis();
      }
    }
    if(millis() - time >= wait){
      println("tick");//if it is, do something
      time = millis();//also update the stored time
      correctAns[currentQ] = "Wrong ";
      currentQ++;
    }
    

    fill(97);
    textAlign(LEFT);
    text(Seq[currentQ], width*2/3, aniCenterY+height/4);


    ////draw the sign
    //textFont(signFont, 282);
    //fill(97);
    //textAlign(LEFT);
    //text(Seq[currentQ], width*2/3, aniCenterY);
  }
}

void drawQuizResult(){
  rectMode(CENTER);
  rect(width/2, height/2, 200, 300);
  textFont(f, 23);
  fill(255);
  textAlign(CENTER);
  for(int i = 0; i<seq.length; i++){
    text("Q"+(i+1)+" "+correctAns[i], width/2, height/2-35+25*i);
  }
  textFont(fb, 23);
  text("Result", width/2, height/2-90);
  text("Total Score = ", width/2, height/2+110);
  text(tick+" out of "+seq.length, width/2, height/2+130);
}