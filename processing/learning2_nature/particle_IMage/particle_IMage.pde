PImage[] imgs;
ArrayList<particlesystem> ps;

void setup(){
  size(640,360,P2D);
  imgs=new PImage[5];
  imgs[0] = loadImage("corona.png");
  imgs[1] = loadImage("emitter.png");
  imgs[2] = loadImage("particle.png");
  imgs[3] = loadImage("texture.png");
  imgs[4] = loadImage("reflection.png");
  ps=new ArrayList<particlesystem>();
  ps.add(new particlesystem());
  
}
void draw(){
  PVector g=new PVector(0,-0.1);
  background(0);
  blendMode(ADD);
  for(particlesystem p:ps){
    p.run();
    p.addforce(g);
    if(mousePressed){
      
      p.addforce();
    }
  }
}
