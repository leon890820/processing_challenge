class population{
  ArrayList<rocket> matingpool;
  rocket[] populations;
  int generation=0;
  population(int num){
    populations=new rocket[num];
    for(int i=0;i<populations.length;i+=1){
      populations[i]=new rocket(new PVector(width/2,330),new DNA());
    }
    matingpool=new ArrayList<rocket>();
  }
  void live(){
    for(int i=0;i<populations.length;i+=1){
      populations[i].run();
    }
  }
  void fitness(){
    for(int i=0;i<populations.length;i+=1){
      populations[i].fitness();
    }
  }
  
  void selection(){
    matingpool.clear();
    float maxfitness=0;
    for(int i=0;i<populations.length;i+=1){
      if(populations[i].fitness>maxfitness){
        maxfitness=populations[i].fitness;   
      }
    }
    for(int i=0;i<populations.length;i+=1){
      float n=map(populations[i].fitness,0,maxfitness,0,1);
      n=int(n*100);
      for(int j=0;j<n;j+=1){
        matingpool.add(populations[i]);
      }
    }
  }
  void reproduction(){
    for(int i=0;i<populations.length;i+=1){
      int a=(int)random(0,matingpool.size());
      int b=(int)random(0,matingpool.size());
      rocket parentA=matingpool.get(a);
      rocket parentB=matingpool.get(b);
      DNA child=parentA.dna.crossedover(parentB.dna);
      child.mutate(mutationrate);
      populations[i]=new rocket(new PVector(width/2,330),child);
    }
    generation+=1;
  }
  
  
}
