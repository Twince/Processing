// ball's position and movement
float x, y;
int xDir, yDir, diam;
color ballColor;

// pad's initial position and size
float padX, padY, mouseEvent;
int padWidth, padThick;
color padColor;
float easyInOut = 0.04;

// bricks
int bRowNo = 4, bColNo=10;
int bWidth, bHeight;
int [][] bricks = new int[bRowNo][bColNo]; // 2 dimensional array

// score
int score;
boolean flag = true;

void setup(){
  noCursor();
  
  // canvas initialization
  size(1680, 910);
  bWidth = width/bColNo;
  bHeight = 60;

  // parameter setting for a new game
  int i, j;
  
  // ball and pad's position initialization
  x = width / 2;
  y = height / 2;
  xDir = 4;
  yDir = 6;
  diam = 30;
  ballColor = #FAA275;
  
  // pad
  padX = width / 2;
  padY = height - 40;
  padWidth = 400;
  padColor = #985277;
  padThick = 40;

  // score
  score = 0;

  // brick initialization at the top
  for(i=0; i<bRowNo; i++){
    for(j=0; j<bColNo; j++){
        bricks[i][j] = int(random(3)) + 1;
    }
  }
}

void draw(){
  
  int i, j;
  int colorOpacity = 20;
  
  float easyInOut = 0.2;
  background(#eeeeee);
  
  // score 
  PFont title, scoreText;
  title = createFont("Staatliches", 50, true); // Arial, 16 point, anti-aliasing on
  textFont(title, 50); // font and its size setting
  fill(#dddddd);
  
  if(score > 0 && score%10 == 0) {
    //print("10point?") debugging;
    fill(#000000, colorOpacity += 50);
  }

  text("Score", (width/2)-width*0.034, (height/2)-50); // score drawing
  
  scoreText = createFont("Staatliches", 280, true);
  //fill(#dddddd);
  textFont(scoreText, 280);
  text(str(score), (width/2)-width*0.04, (height/2)+170);
  
  // brick drawing color setting
  stroke(0); // stroke color
  strokeWeight(2); // stroke thickness

  // bricks drawing
  // if it is '1', a brick shows, otherwise it doesn't appear.
  for(i=0; i<bRowNo; i++){
    for(j=0; j<bColNo; j++){
      if ( bricks[i][j] == 1) {
        fill(#EAAC8B);
        strokeWeight(0);
        rect(j*bWidth, i*bHeight, bWidth, bHeight, 20);        
      } else if ( bricks[i][j] == 2){
        fill(#6E7889);
        strokeWeight(0);
        rect(j*bWidth, i*bHeight, bWidth, bHeight, 20);
      } else if ( bricks[i][j] == 3){
        fill(#6D597A);
        noStroke();
        rect(j*bWidth, i*bHeight, bWidth, bHeight, 20);
        stroke(1);
      }
    }
  }
 
  // ball drawing and movement
  noStroke();
  fill(ballColor);
  ellipse(x, y, diam, diam); 
  x += xDir; //x = x + xDir;
  y += yDir; 
  
  // drawing a pad at new positon
  fill(padColor);
  padX += ((float)(mouseX-padWidth/2) - padX) * easyInOut;
  padY = constrain(padY, 100, 1640);
  rect(padX, padY + mouseEvent*10, padWidth, 20, 10);  
  
  // ball bouncing 
  if ( x < diam/2 || x > width-diam/2) { // left and right side check
    xDir *= -1;
  }
  if ( y > height-diam/2 ) { // down side check
    yDir *= -1;
    score -= 4;
    rect(0,0, 1680, 900, 20);
    fill(255, 0, 0, 10);
  }
  
  // if the ball in in the region of bricks
  if ( y < bHeight*bRowNo ) {
    // when the ball hits the bricks
    if ( bricks[(int)y/bHeight][(int)x/bWidth] > 0) {
        yDir *= -1;
        bricks[(int)y/bHeight][(int)x/bWidth]--;
        score += 2;
        if(score > 9) padWidth = 300;
        else if(score > 19 ) padWidth = 200;
    }
    else if ( y < 0) yDir *= -1;     // bounce at the top
  }
  
  // pad bounding
  if ( x > padX && x < padX + padWidth && y > (padY + mouseEvent*10)-diam/2){
         yDir *= -1;
         fill(#FF0000);
         rect(padX+2, (padY + mouseEvent*10)+10, padWidth-4, 16, 5);
  }
}

void mouseWheel(MouseEvent event) {
  mouseEvent += event.getCount();  
  println(mouseEvent);
}
