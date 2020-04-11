class DNA{
  PVector[] gene;
  float maxforce=0.1;
  DNA(){
    gene=new PVector[(int)lifetime];
    for(int i=0;i<gene.length;i+=1){
      float theda=random(0,PI*2);
      gene[i]=new PVector(cos(theda),sin(theda));
      gene[i].mult(random(0,maxforce));
    }
  }
    DNA(PVector[] newgenes) {
    
    gene = newgenes;
  }
  DNA crossedover(DNA b){
    int n=(int)random(0,gene.length);
    PVector[] child=new PVector[gene.length];
    for(int i=0;i<gene.length;i+=1){
      if(i<n) child[i]=gene[i];
      else child[i]=b.gene[i];
    }
    DNA newgene=new DNA(child);
    return newgene;
  }
  void mutate(float m){
    for(int i=0;i<gene.length;i+=1){
      if(random(1)<m){
        float theda=random(0,PI*2);
        gene[i]=new PVector(cos(theda),sin(theda));
        gene[i].mult(random(0,maxforce));
      }
    }
    
  }
  
}
