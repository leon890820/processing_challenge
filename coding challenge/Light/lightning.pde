class lightning{
  PVector pos;
  ArrayList<branch> branches;
  PVector dir;
  float len=1;
  lightning(){
    dir=new PVector(0,1);
    pos = new PVector(width/2,0);
    branches=new ArrayList<branch>();
    branches.add(new branch(pos,null,dir));
  }
  void run(){
    for(int i=0;i<10;i+=1){
      grow();
    }
    for(branch b:branches){
      b.show();
    }
    
  }
  
  void grow(){
    for(int i=branches.size()-1;i>=0;i-=1){
      branch b=branches.get(i);
      if(b.isgrow==false){
        branches.add(b.next());
        if(random(1)<0.008){
          branches.add(b.next());
        }
      }
    }
    
  }
  

}
