class EvolutionGraph extends PApplet {

  EvolutionGraph() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(900, 600);
  }

  void setup() {
    background(150);
    frameRate(30);
  }

  void draw() {
    background(150);
    fill(0);
    strokeWeight(1);
    textSize(15);
    textAlign(CENTER, CENTER);
    text("Iteration", width/2, height-10);
    translate(10, height/2);
    rotate(PI/2);
    text("MSV", 0, 0);      
    rotate(-PI/2);
    translate(-10, -height/2);
    textSize(10);
    noFill();
    stroke(255, 0, 0);

    beginShape();
    for (int i=0; i<MSV.size(); i+=1) {
      if(i==0) continue;
      float y=map(MSV.get(i), 0, maxM(MSV), height-60, 50);
      float x=map(i, 0, MSV.size(), 50, width-50);        
      vertex(x, y);
    }
    endShape();
    //println(pow(10, str(MSV.size()).length()));
    for (int i=0; i<MSV.size(); i+=1) {
      //float y=map(MSV.get(i), 0, maxM(MSV), height-60, 50);
      float x=map(i, 0, MSV.size(), 50, width-50);     
      if (i%pow(10, str(MSV.size()).length()-1)==0) {
        translate(x, 560);
        rotate(PI/2);
        text(i, 0, 0);
        rotate(-PI/2);
        translate(-x, -560);
      }
    }
    for(int i=0;i<10;i+=1){
      float y=map(maxM(MSV)*i/9, 0, maxM(MSV), height-60, 50);
      text(maxM(MSV)*i/9,25,y);
    }


    stroke(0);
    line(40, 50, 40, 540);
    line(40, 540, 900, 540);
  }
  float maxM(FloatList f) {
    float max=-1000000;
    for (int i=0; i<f.size(); i+=1) {
      if (f.get(i)>max) {
        max=f.get(i);
      }
    }

    return max;
  }
  void exit() {
    dispose();
    graph = null;
  }
}
