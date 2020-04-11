class population{
  float mutationRate;
  DNA[] DNAs;
  ArrayList<DNA> matingpool;
  String Target;
  int generation;
  boolean finished;
  int perfectscore;
  population(String p,float m,int num){
    Target=p;
    mutationRate=m;
    DNAs=new DNA[num];
    matingpool=new ArrayList<DNA>();
    finished=false;
    perfectscore=1;
    generation=0;
    for(int i=0;i<DNAs.length;i+=1){
      DNAs[i]=new DNA(target.length());
    }
    calcfitness();
  }
  void calcfitness(){
    for(int i=0;i<DNAs.length;i+=1){
      DNAs[i].fitness(target);
    }
  }
  void naturalSelection(){
    matingpool.clear();
    float maxfitness=0;
    for(int i=0;i<DNAs.length;i+=1){
      if(DNAs[i].fitness>maxfitness){
        maxfitness=DNAs[i].fitness;
      }
    }
    
    for(int i=0;i<DNAs.length;i+=1){
      float fitness=map(DNAs[i].fitness,0,maxfitness,0,1);
      int n=(int) fitness*100;
      for(int j=0;j<n;j+=1){
        matingpool.add(DNAs[i]);
      }
    }
  }
  void generation(){
    for(int i=0;i<DNAs.length;i+=1){
      int a=(int) random(matingpool.size());
      int b=(int) random(matingpool.size());
      DNA parentA =matingpool.get(a);
      DNA parentB =matingpool.get(b);
      DNA child=parentA.crossover(parentB);
      child.mutate(mutationRate);
      DNAs[i]=child;
    }
    generation+=1;
  }  
  String getBest(){
    float worldrecord=0;
    int index=0;
    for(int i=0;i<DNAs.length;i+=1){
      if(DNAs[i].fitness>worldrecord){
        index=i;
        worldrecord=DNAs[i].fitness;
      }
    }
    if(worldrecord==perfectscore) finished=true;
    return DNAs[index].getPhrase();
  }
  String allPhrases() {
    String everything = "";
    
    int displayLimit = min(DNAs.length,50);
    
    
    for (int i = 0; i < displayLimit; i++) {
      everything += DNAs[i].getPhrase() + "\n";
    }
    return everything;
  }
  
}
