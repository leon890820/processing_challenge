class lightning{
  PVector pos;
  ArrayList<branch> branches;
  PVector dir;
  float len=1;
  float time=255;
  lightning(){
    dir=new PVector(0,1);
    pos = new PVector(random(0,width),0);
    branches=new ArrayList<branch>();
    branches.add(new branch(pos,null,dir,1000));
  }
  void run(){
    for(int i=0;i<100;i+=1){
      grow();
    }
    for(branch b:branches){
      b.show(time);
    }
    time-=5;
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
          branches.add(b.next(b.energy-1,0));
        }   
      }
    } 
  }
}

class branch{
  PVector pos;
  branch parent;
  PVector dir;
  boolean isgrow=false;
  float len=1;
  float energy;
  branch(PVector _pos,branch _parent,PVector _dir,float _energy){
    pos=_pos.copy();
    parent=_parent;
    dir=_dir.copy();
    energy=_energy;
    
  }
  void show(float time){
    
    float w=map(energy,0,1000,0,4);
    noStroke();
    //stroke(0,0,255,time);
    //circle(pos.x,pos.y,w*2);
    stroke(255,time);
    strokeWeight(w);
    if(parent!=null){
      line(pos.x,pos.y,parent.pos.x,parent.pos.y);
    }
    
    
  }
  branch next(float energys,float bias){   
    isgrow=true;
    PVector cdir;
    if (bias>=0){
      cdir=dir.copy().add(new PVector(random(-2+bias,2+bias),random(0,1)));
    }
    else{
      cdir=dir.copy().add(new PVector(random(-2-bias,2-bias),random(0,1)));      
    }
    cdir.normalize();
    cdir.mult(len);
    branch b=new branch(pos.copy().add(cdir),this,cdir,energys);
    return b;   
  }  
}
