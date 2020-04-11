class DNA{
  char[] gene;
  float fitness;
  DNA(int num){
    gene=new char[num];
    fitness=0;
    for(int i=0;i<gene.length;i+=1){
      gene[i]=(char) random(32,128);
    }
  }
  void fitness(String target){
    int score=0;
    for(int i=0;i<gene.length;i+=1){
      if(gene[i]==target.charAt(i)){
        score+=1;
      }
    }
    fitness=(float)score/(float)target.length();
  }
  DNA crossover(DNA b){
    DNA child=new DNA(gene.length);
    int midpoint=(int)random(gene.length);
    for(int i=0;i<gene.length;i+=1){
      if(i<midpoint) child.gene[i]=gene[i];
      else child.gene[i]=b.gene[i];
      
    }
    return child;
  }
  void mutate(float m){
    for(int i=0;i<gene.length;i+=1){
      if(random(1)<m){
        gene[i]=(char)random(32,128);
      }
    }
  }
  String getPhrase() {
    return new String(gene);
  }
}
