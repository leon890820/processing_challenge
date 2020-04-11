class particlesystem{
  ArrayList<particle> s;
  PVector origin;
  particlesystem(PVector o){
    s=new ArrayList<particle>();
    origin=o.get();
    s.add(new particle(origin));
    
  }
  
  void run(){
    float r=random(1);
    for(int i=0;i<s.size();i+=1){
      particle p=s.get(i);
      p.display();
      p.update();
      if(p.isdead()){
        s.remove(i);  
      }
   
    } 
    if(r<0.5){
      s.add(new particle(origin));
    }
    else{
      s.add(new Sparticle(origin));
    }
  

  }
  
}
