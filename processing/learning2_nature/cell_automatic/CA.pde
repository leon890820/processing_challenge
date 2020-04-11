class CA{
  int[] cell;
  int generation;
  int[] ruleset;
  int w=5;
  CA(int[] r){
    ruleset=r;
    cell=new int[width/w];
    restart();
  }
  void display(){
    //translate(0,generation);
    for(int i=0;i<cell.length;i+=1){
      if(cell[i]==1) fill(0);
      else fill(255);
      noStroke();
      rect(i*w,generation*w,w,w);
    }
  }
  void update(){
  
  }
  void restart(){
    for(int i=0;i<cell.length;i+=1){
      cell[i]=0;
    }
    cell[cell.length/2]=1;
    generation=0;
  }
  void generate(){
    int[] next=new int[cell.length];
    for(int i=1;i<cell.length-1;i+=1){
      int left=cell[i-1]; 
      int me=cell[i];
      int right=cell[i+1];
      next[i]=rule(left,me,right);
      
    }
    cell=next;
    generation+=1;
  }
  int rule(int a,int b,int c){
    if (a == 1 && b == 1 && c == 1) return ruleset[0];
    if (a == 1 && b == 1 && c == 0) return ruleset[1];
    if (a == 1 && b == 0 && c == 1) return ruleset[2];
    if (a == 1 && b == 0 && c == 0) return ruleset[3];
    if (a == 0 && b == 1 && c == 1) return ruleset[4];
    if (a == 0 && b == 1 && c == 0) return ruleset[5];
    if (a == 0 && b == 0 && c == 1) return ruleset[6];
    if (a == 0 && b == 0 && c == 0) return ruleset[7];
    return 0;
  }
  boolean finished(){
    if(generation*w>height){
      return true;
      
    }
    else{
      return false;
    }
  }
  void reset(){
    for (int i = 0; i < 8; i++) {
      ruleset[i] = int(random(2));
    }
    for (int i = 0; i < cell.length; i++) {
      cell[i] = 0;
    }
    cell[cell.length/2] = 1;    // We arbitrarily start with just the middle cell having a state of "1"
    generation = 0;
    
  }
}
