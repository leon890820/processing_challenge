class lightning{
  PVector pos;
  ArrayList<branch> branches;
  PVector dir;
  float len=1;
  lightning(){
    dir=new PVector(0,1);
    pos = new PVector(width/2,0);
    branches=new ArrayList<branch>();
    branches.add(new branch(pos,null,dir,1000));
  }
  void run(){
    for(int i=0;i<100;i+=1){
      grow();
    }
    for(branch b:branches){
      b.show();
    }
    
  }
  
  void grow(){
    for(int i=branches.size()-1;i>=0;i-=1){
      boolean issplict=false;
      branch b=branches.get(i);
      if(b.isgrow==false){
        float s=random(5,9);
        if(random(1)<(b.energy)/50000){
          issplict=true;          
          s/=10;
          branches.add(b.next(s*b.energy,2));
        }
        if(issplict==true){
          branches.add(b.next((1-s)*b.energy,-2));
        }
        else if(b.energy>50){
          branches.add(b.next(b.energy-0.2,0));
        }
        
      }
    }
    
  }
  

}
