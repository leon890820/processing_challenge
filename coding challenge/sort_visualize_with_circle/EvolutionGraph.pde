class EvolutionGraph extends PApplet {

  EvolutionGraph() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    
  }

  void setup() {
    background(150);
    frameRate(60);
  }

  void draw() {
    background(0);

    
    if (count<shuffleTime) {
      numberShuffle(100);
      newDot();
      count+=1;
      
    } else {
      for (int i=0; i<1; i+=1) {
        if (stop==false) {
         
          algorithm.quickSort.run();
        }
      }
    }
   
  }
  void exit() {
    dispose();
    graph = null;
  }
}
