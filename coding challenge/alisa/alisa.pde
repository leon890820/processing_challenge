PImage img;
int sl=2;
int f=0;
boolean up=true;
PImage[] imgs=new PImage[100];
int row=width/sl;
int cul=height/sl;
float p=float(300)/float(640);
void setup(){
  size(1280,640);
  row=width/sl;
  cul=height/sl;
  img=loadImage("aya.png");
  
  for(int i=0;i<100;i+=1){
    if (i<10){
      imgs[i]=loadImage("IMG0000"+i+".bmp");
    }  
    else{
      imgs[i]=loadImage("IMG000"+i+".bmp");
    }
    
}

  
  //print(p);
  loadPixels();
  int count=1;
  for(int x=0;x<row;x+=1){
    
    for(int y =0;y<cul;y+=1){
      
      color c=img.get(int(x*sl*p),int(y*sl*p));
      stroke(c);
      fill(c,255);
      rect(x*sl,y*sl,sl,sl);
      if(x==row-1||y==cul-1){
        rect((x+1)*sl,(y+1)*sl,sl,sl);
        print("1");
      }
      //fill(0);
     // textSize(10);
      //text(count,x*sl,y*sl);
      //count+=1;
      //print(count);
     // print(int(x*sl*p),int(y*sl*p)+"\n");
     //print(c);
    }
    fill(0);
    //text(count,x*sl,10);
    count+=1;
  }
  //updatePixels();
  
  
}

void draw(){
  translate(width/2,height/2);
  background(0);
  loadPixels();
  for(int x=-row/2;x<row/2;x+=1){
    
    for(int y =-cul/2;y<cul;y+=1){
      
      color c=imgs[f%100].get(int((x+row/2)*sl*p),int((y+cul/2)*sl*p));
      noStroke();
      fill(c,255);
      rect(x*sl,y*sl,sl,sl);
      if(x==row/2-1||y==cul/2-1){
        rect((x+1)*sl,(y+1)*sl,sl,sl);
        
      }
      if(x==-row/2||y==-cul/2){
        rect((x-1)*sl,(y-1)*sl,sl,sl);
        
      }
      //fill(0);
     // textSize(10);
      //text(count,x*sl,y*sl);
      //count+=1;
      //print(count);
     // print(int(x*sl*p),int(y*sl*p)+"\n");
    }
    fill(0);
    //text(count,x*sl,10);
    //count+=1;
  }
  //updatePixels();
  f+=1;
  //print(f+"\n");
  if(up==true){
    sl+=1;
  }
  else{
    sl-=1;
  }
  //float sls=sin(float(sl)*PI/180);
  //sls=map(sls,-1,1,1,600);
  row=width/(int)sl;
  cul=height/(int)sl;
  //print(row+"\n");
  if(sl>50) up=false;
  if(sl<=2) up=true;
  
}
