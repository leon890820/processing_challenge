population populations;
PFont f;
String target;
int popmax;
float mutationrate;
void setup(){
  size(640,360);
  background(255);
  f = createFont("Courier", 32, true);
  target="Pneumonoultramicroscopicsilicovolcanoconiosis";
  popmax=1000;
  mutationrate=0.01;
  populations=new population(target,mutationrate,popmax);
}
void draw(){
  
  background(255);
  populations.naturalSelection();
  populations.generation();
  populations.calcfitness();
  if(populations.finished){
    noLoop();
  }
  displayInfo();
  
  

}
void mousePressed(){
  background(255);
  populations.naturalSelection();
  populations.generation();
  populations.calcfitness();
  displayInfo();
}
void displayInfo(){
  String answer=populations.getBest();
  textFont(f);
  textAlign(LEFT);
  fill(0);
  
  textSize(20);
  text("Best phrase:",20,30);
  textSize(10);
  text(answer, 20, 100);
  
  textSize(18);
  text("total generations:     " + populations.generation, 20, 160);
  //text("average fitness:       " + nf(population.getAverageFitness(), 0, 2), 20, 180);
  text("total population: " + popmax, 20, 200);
  text("mutation rate:         " + int(mutationrate * 100) + "%", 20, 220);
  
  textSize(10);
  text("All phrases:\n" + populations.allPhrases(), 500, 10);
}
