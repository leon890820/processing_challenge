class EvolutionGraph extends PApplet {
  
   EvolutionGraph() {
       super();
       PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
   }
   
   void settings() {
      size(900,600); 
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
      textAlign(CENTER,CENTER);
      text("iteration", width/2,height-10);
      translate(10,height/2);
      rotate(PI/2);
      text("MSV", 0,0);
      rotate(-PI/2);
      translate(-10,-height/2);
      textSize(10);
      
   }
   
   void exit() {
      dispose();
      graph = null;
   }
}
