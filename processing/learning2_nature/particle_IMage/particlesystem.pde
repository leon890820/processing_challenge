class particlesystem{
  ArrayList<particle> p;
  particlesystem(){
    p=new ArrayList<particle>();
  }
  void run(){
    for(int i=0;i<5;i+=1){
      p.add(new particle());
    }
    for(int i=0;i<p.size();i+=1){
      particle s=p.get(i);
      s.display();
      s.update();
      if(s.isdeath()){
        p.remove(i);
      }
    }
  
  }
  void addforce(PVector force){
    for(particle s:p){
      s.addforce(force);
    }
  }
  void addforce(){
    for(particle s:p){
      s.addforce();
    }
  }

}
