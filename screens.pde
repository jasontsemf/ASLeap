//draw function for learn mode and 
//quiz mode is in another tab

void drawTitleScreen() {
  rectMode(CENTER);
  noStroke();
  fill(255);
  rect(aniCenterX, aniCenterY, width, height);
  fill(211);
  rect(aniCenterX, aniCenterY, 808, 192);

  textFont(signFont, 66);
  fill(44);
  textAlign(CENTER);
  text("intro to ASL", aniCenterX, 304);

  textFont(f, 101);
  fill(92);
  textAlign(CENTER);
  text("Intro to ASL", aniCenterX, 248);
  
  textFont(f, 18);
  fill(150);
  textAlign(RIGHT);
  text("Swipe LEFT:\nStart", aniCenterX+392, aniCenterY);
  
  textFont(f, 18);
  fill(150);
  textAlign(CENTER);
  text("Swipe UP:About", aniCenterX+0, 390);
  
  textFont(f, 18);
  fill(150);
  textAlign(LEFT);
  text("Swipe RIGHT:\nExit", aniCenterX+-392, aniCenterY);
}

void drawInfo() {
  rectMode(CENTER);
  noStroke();
  fill(255);
  rect(aniCenterX, aniCenterY, width, height);

  textFont(f, 80);
  fill(92);
  textAlign(CENTER);
  text("About ASLeap 1.0", aniCenterX, aniCenterY-45);
  
  textFont(f, 12);
  fill(92);
  textAlign(CENTER);
  text("2016 ALL RIGHT RESERVED", aniCenterX, aniCenterY-25);
  
  textFont(f, 20);
  fill(92);
  textAlign(CENTER);
  text("DESIGNED AND DEVELOPED BY", aniCenterX, aniCenterY+45);

  textFont(f, 10);
  fill(92);
  textAlign(CENTER);
  text("LI LING HIN, CHAN KA MING, TSE MAN FUNG, LAM WAI CHUNG", aniCenterX, aniCenterY+55);

  textFont(f, 20);
  fill(92);
  textAlign(CENTER);
  text("CREATED WITH PROCESSING", aniCenterX, aniCenterY+85);
  
  textFont(f, 20);
  fill(92);
  textAlign(CENTER);
  text("CS3483 GROUP PROJECT", aniCenterX, aniCenterY+125);
  
  textFont(f, 10);
  fill(92);
  textAlign(CENTER);
  text("copying, reproduction, modification, distribution or transmission is prohibited", aniCenterX, aniCenterY+205);
}


void drawSetting() {
  rectMode(CENTER);
  noStroke();
  fill(255);
  rect(aniCenterX, aniCenterY, width, height);

  fill(92);
  textAlign(CENTER);
  text("Setting", aniCenterX, 239);
}

//choosing mode
void drawStart() {
  rectMode(CENTER);
  noStroke();
  fill(178);
  rect(aniCenterX, aniCenterY+33, width, height);

  fill(247);
  rect(aniCenterX, aniCenterY-224, width, height);

  textFont(f, 55);
  fill(76);
  textAlign(CENTER);
  text("Please choose ", aniCenterX, aniCenterY+17);

  textFont(f, 70);
  fill(155);
  textAlign(CENTER);
  text("Swipe DOWN:Learn A-Z", aniCenterX, aniCenterY-132);

  textFont(f, 70);
  fill(238);
  textAlign(CENTER);
  text("Swipe UP:Quiz", aniCenterX-6, aniCenterY+171);
  
  currentQ = 6;
}

//confirm to exit
void drawConfirm() {
  rectMode(CENTER);
  noStroke();
  fill(255);
  rect(aniCenterX, aniCenterY, width, height);

  textFont(f, 53);
  fill(92);
  textAlign(CENTER);
  text("Exit?", aniCenterX, aniCenterY-10);
  text("Confirm / Back", aniCenterX, aniCenterY+60);
}
void drawBye(){
  rectMode(CENTER);
  noStroke();
  fill(255);
  rect(width/2, height/2, width, height);
  
  textFont(f, 53);
  fill(92);
  textAlign(CENTER);
  text("Bye!", width/2, height/2);
}