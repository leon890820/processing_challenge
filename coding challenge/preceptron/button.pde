class button{
  PVector position;
  PVector pp;
  float len=150;
  float hei=50;
  String name;
  int num;
  boolean touch=false;
  boolean pressed=false;
  button(String _name,float _x,float _y,int _num,float _len,float _hei){
    name=_name;
    position=new PVector(_x,_y);
    num=_num;
    len=_len;
    hei=_hei;
    pp=position.copy();
  }
  void show(float value){
    pp.y=position.y-value*(buttons.length*60+100-height)/100;
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if(touch==false) fill(0);
    else fill(50);
    stroke(255);
    rect(pp.x,pp.y,len,hei);
    fill(255);
    textSize(20);
    text(name,pp.x,pp.y-3);
  }
  void show(){
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if(touch==false) fill(0);
    else fill(50);
    stroke(255);
    rect(position.x,position.y,len,hei);
    fill(255);
    textSize(20);
    text(name,position.x,position.y-3);
  }
  void slidershow(){
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if(touch==false) fill(0);
    else fill(50);
    noStroke();
    rect(position.x,position.y,len,hei);
    fill(255);
    textSize(20);
    text(name,position.x,position.y-3);
  }
  void select(){
    if(mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2){
      touch=true;
    }
    else touch=false;     
    if (touch==true && mousePressed == true){
      if(pressed==false){
        initialize(name);
        pressed=true;
      }
    }
    else pressed=false;    
  }
  void slide(){
    
  
  }
  
  PVector sliderselect(){
    if(mouseX>position.x-len/2 && mouseX<position.x+len/2 && mouseY>position.y-hei/2 && mouseY<position.y+hei/2){
      touch=true;
    }
    
    
    if (touch==true && mousePressed == true){
      position.x=mouseX;
      position.y=mouseY;
    }
    else touch=false;
    return position;
    
  }
  
  void training(){
    if(mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2){
      touch=true;
    }
    else touch=false; 
    
    if (touch==true && mousePressed == true){
      if(pressed==false){
          training=true;
          menu=false;
          testing=false;
          bonus=false;
          n.lr=learning.v;
        pressed=true;
      }
    }
    else pressed=false;
  }  
  void back(){
    if(mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2){
      touch=true;
    }
    else touch=false;     
    if (touch==true && mousePressed == true){
      if(pressed==false){
        menu=true;
        training=false;
        testing=false;
        bonus=false;
        pressed=true;
        count=0;
        for(int i=0;i<n.weight.length;i+=1){
          for(int j=0;j<n.weight[i].length;j+=1){
            n.weight[i][j]=random(-10,10);
          }
        }
      }
    }
    else pressed=false;    
  }
  void test(){
    if(mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2){
      touch=true;
    }
    else touch=false;     
    if (touch==true && mousePressed == true){
      if(pressed==false){
        menu=false;
        training=false;
        testing=true;
        bonus=false;
        pressed=true;
      }
    }
    else pressed=false;    
  }
  
  void bonusarea(){
    if(mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2){
      touch=true;
    }
    else touch=false;     
    if (touch==true && mousePressed == true){
      if(pressed==false){
        menu=false;
        training=false;
        testing=false;
        bonus=true;
        pressed=true;
      }
    }
    else pressed=false;    
  }
  
}
