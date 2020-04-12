class tree{
  int num=1000;
  //leave[] leaves=new leave[num];
  ArrayList<leave> leaves;
  ArrayList<branch> branches;
  branch root;
  boolean found=false;
  tree(){
    leaves=new ArrayList<leave>();
    for(int i=0;i<num;i+=1){
      leaves.add(new leave());
      
    }
    PVector pos=new PVector(0,width/2,0);
    PVector dir=new PVector(0,-1,0);
    root=new branch(pos,null,dir);
    branches=new ArrayList<branch>();
    branches.add(root);
    branch current=root;
    while(!found){
      for(int i=0;i<leaves.size();i+=1){
        float d=dist(current.pos.x,current.pos.y,current.pos.z,leaves.get(i).pos.x,leaves.get(i).pos.y,leaves.get(i).pos.z);
        if(d<max){
          found=true;
        }
      }
      if(!found){
        branch nextbranch=current.next();
        current=nextbranch;
        branches.add(current);
      }
    }
  }
  
  void grow(){
    for(int i=0;i<leaves.size();i+=1){
      leave l=leaves.get(i);
      branch closethbranch=null;
      float record=100000;
      for(int j=0;j<branches.size();j+=1){
        branch b=branches.get(j);
        float d=dist(l.pos.x,l.pos.y,l.pos.z,b.pos.x,b.pos.y,b.pos.z);
        if(d<min){
          l.reached=true;
          closethbranch=null;
          break;
        }
        else if(d>max){
        
        }
        else if (closethbranch==null||d<record){
          closethbranch=b;
          record=d;
        }
      }
      if(closethbranch!=null){
        PVector dir=PVector.sub(l.pos,closethbranch.pos);
        PVector rand=PVector.random2D();
        //dir.add(rand);
        dir.normalize();
        closethbranch.dir.add(dir);
        closethbranch.count+=1;
      }
    }
    
    for(int i=leaves.size()-1;i>=0;i-=1){
      if(leaves.get(i).reached==true){
          leaves.remove(i);
          //print('1');
      }
    }
    for(int i=branches.size()-1;i>=0;i-=1){
      branch b=branches.get(i);
      if(b.count>0){
        b.dir.div(b.count);
        PVector newpos=PVector.add(b.pos,b.dir);
        branch newbranch=new branch(newpos,b,b.dir);
        branches.add(newbranch);
      }
      b.reset();
    }
    //print("i");
  }
  
  void show(){
    for(int i=0;i<leaves.size();i+=1){
      leaves.get(i).show();
    }
    for(int i=0;i<branches.size();i+=1){
      branches.get(i).show(i);
    }
  }
}
