JSONObject levelData;
boolean menu=true;
boolean gameMode=false;
boolean trainMode=false;
boolean editMode=false;
boolean win=false;
boolean[] keyboardDetect;

int[] realTime=new int[3];
float countTime=0;

Block end;
ArrayList<Block> blocks;
ArrayList<Obstacle> obstacles;
ArrayList<Enemy> enemys;
Button menuButton;
Button playButton;
Button backButton;
Button resetButton;
Button restartButton;
Button backToMenuButton;
Button editButton;
Player player;

float blockSize=50;

void setup() {
  size(1000, 800);
  background(0);
  obstacles=new ArrayList<Obstacle>();
  blocks=new ArrayList<Block>();
  enemys=new ArrayList<Enemy>();
  for(int i=0;i<realTime.length;i+=1) realTime[i]=0;
  keyboardDetect=new boolean[4];
  levelData = loadJSONObject("level1.json");
  for (int i=0; i<keyboardDetect.length; i+=1) keyboardDetect[i]=false;
  player=new Player(levelData.getJSONObject("player").getFloat("x"),levelData.getJSONObject("player").getFloat("y"));
  playButton=new Button("play", 500, 200, 1, 150, 50, 10);
  editButton=new Button("edit",500,400,1,150,50,0);
  backButton=new Button("back", 50, 25, 1, 100, 50, 0);
  resetButton=new Button("reset", 950, 25, 1, 100, 50, 0);
  restartButton=new Button("restart",350,400,1,100,50,0);
  backToMenuButton=new Button("back",550,400,1,100,50,0);
  addObstacles();
  addBlock();
  addEndBlock();
  addEnemy();
}

void addEnemy(){
  JSONArray JAs=levelData.getJSONArray("enemy");
  
  for(int i=0;i<JAs.size();i+=1){
    JSONObject obs=JAs.getJSONObject(i);
    int n=obs.getJSONArray("x").size();
    PVector[] pathPoint=new PVector[n];
    for(int j=0;j<n;j+=1){
      float x=obs.getJSONArray("x").getFloat(j);
      float y=obs.getJSONArray("y").getFloat(j);
      pathPoint[j]=new PVector(x,y);
    }
    float x=obs.getJSONArray("x").getFloat(0);
    float y=obs.getJSONArray("y").getFloat(0);
    String s=obs.getString("type");
    float r=obs.getFloat("r");
    float speed=obs.getFloat("speed");
    enemys.add(new Enemy(s,x,y,pathPoint,r,speed));
  }

}

void addEndBlock() {
  JSONObject obj=levelData.getJSONObject("end");
  end=new Block(obj.getFloat("x"), obj.getFloat("y"), obj.getFloat("len"), obj.getFloat("hei"), color(0, 0, 0, 0));
}

void addBlock() {
  JSONObject obs=levelData.getJSONObject("block");
  for (int i=0; i<obs.getJSONArray("x").size(); i+=1) {
    JSONArray x=obs.getJSONArray("x");
    JSONArray y=obs.getJSONArray("y");
    JSONObject obsColor=obs.getJSONObject("color");
    JSONArray r=obsColor.getJSONArray("r");
    JSONArray g=obsColor.getJSONArray("g");
    JSONArray b=obsColor.getJSONArray("b");
    color c=color(r.getFloat(i), g.getFloat(i), b.getFloat(i));
    blocks.add(new Block(x.getFloat(i), y.getFloat(i), blockSize, blockSize, c));
  }
}


void addObstacles() {
  String[] dataName={"x", "y", "len", "hei"};
  JSONObject obs=levelData.getJSONObject("obstacle");
  for (int i=0; i<obs.getJSONArray("x").size(); i+=1) {
    float[] data=new float[4];
    for (int j=0; j<data.length; j+=1) {
      data[j]=obs.getJSONArray(dataName[j]).getFloat(i);
    }
    obstacles.add(new Obstacle(data[0], data[1], data[2], data[3]));
  }
}
void draw() {
  background(0);
  if (menu) menu();
  else if (gameMode) game();
  else if (trainMode) train();
  else if (editMode) edit();
  
}


void menu() {
  playButton.show();
  playButton.run("play");
  editButton.show();
  editButton.run("edit");
}

void game() {
  textAlign(CENTER,CENTER);
  textSize(30);
  fill(255);
  text("DEATHS : "+player.deathTime,width/2,20);
  if (win==false) {
    countTime();
    backButton.show();
    backButton.run("back"); 
    resetButton.show();
    resetButton.run("reset");
    for(Enemy e:enemys){
      e.show();
      e.updata();
    }
    for (Block b : blocks) {
      b.show();
    }
    for (Obstacle o : obstacles) {
      o.show();
    }
    player.show();
    if(player.death==false){
      player.move();
    }
    player.win();
    player.death();
    fill(255, 0, 0);
    text(mouseX, mouseX, mouseY);
    text(mouseY, mouseX+50, mouseY);
  } else {
    textSize(48);
    textAlign(CENTER,CENTER);
    fill(255,0,0);
    text("You Win!!",450,300);
    restartButton.show();
    restartButton.run("restart");
    backToMenuButton.show();
    backToMenuButton.run("backToMenu");
  
  }
}
void train() {
}

void edit() {
  backButton.show();
  backButton.run("back");
}



void keyPressed() {
  if (key=='a'||key=='A') keyboardDetect[0]=true;
  if (key=='s'||key=='S') keyboardDetect[1]=true;
  if (key=='d'||key=='D') keyboardDetect[2]=true;
  if (key=='w'||key=='W') keyboardDetect[3]=true;
}

void keyReleased() {
  if (key=='a'||key=='A') keyboardDetect[0]=false;
  if (key=='s'||key=='S') keyboardDetect[1]=false;
  if (key=='d'||key=='D') keyboardDetect[2]=false;
  if (key=='w'||key=='W') keyboardDetect[3]=false;
}

void countTime(){
  countTime+=0.016;
  if(countTime>=1){
    countTime=0;
    realTime[2]+=1;
  }
  if(realTime[2]>=60){
    realTime[2]=0;
    realTime[1]+=1;
  }
  if(realTime[1]>=60){
    realTime[1]=0;
    realTime[0]+=1;
  }
  textAlign(CENTER,CENTER);
  textSize(30);
  fill(255);
  if(realTime[0]<10) text("0"+realTime[0]+":",width/2-100,780);
  else text(realTime[0]+":",width/2-100,780);
  if(realTime[1]<10) text("0"+realTime[1]+":",width/2-50,780);
  else text(realTime[1]+":",width/2-50,780);
  if(realTime[2]<10) text("0"+realTime[2]+"",width/2,780);
  else text(realTime[2]+"",width/2,780);
}
