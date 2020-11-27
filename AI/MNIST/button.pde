class button {
  PVector position;
  PVector pp;
  float len=150;
  float hei=50;
  String name;
  int num;
  boolean touch=false;
  boolean pressed=false;
  button(String _name, float _x, float _y, int _num, float _len, float _hei) {
    name=_name;
    position=new PVector(_x, _y);
    num=_num;
    len=_len;
    hei=_hei;
    pp=position.copy();
  }
  void show() {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if (touch==false) fill(0);
    else fill(50);
    stroke(255);
    rect(position.x, position.y, len, hei);
    fill(255);
    textSize(20);
    text(name, position.x, position.y-3);
  }
  void slidershow() {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if (touch==false) fill(0);
    else fill(50);
    noStroke();
    rect(position.x, position.y, len, hei);
    fill(255);
    textSize(20);
    text(name, position.x, position.y-3);
  }
  void select() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        reset();
        pressed=true;
      }
    } else pressed=false;
  }  

  void send() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true&&keylabel.t!="") {
      if (pressed==false) {
        String mt="";
        for (int i=0; i<mosaic.length; i+=1) {
          for (int j=0; j<mosaic[i].length; j+=1) {
            mt+=str(mosaic[i][j])+" ";
          }
        }
        mt+=keylabel.t;
        sdata.append(mt);
        String[] list=new String[sdata.size()];
        for (int i=0; i<list.length; i+=1) {
          list[i]=sdata.get(i);
        }
        saveStrings("data\\numberdata.txt", list);
        reset();
        pressed=true;
      }
    } else pressed=false;
  }
  
  
  void view() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menu=false;
        view=true;
        pressed=true;
      }
    } else pressed=false;
  }  
  
  
  void back() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menu=true;
        view=false;
        pressed=true;
      }
    } else pressed=false;
  } 
  void next() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        page+=1;
        viewload(page);
        
        pressed=true;
      }
    } else pressed=false;
  }  
  void prev() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        page-=1;
        viewload(page);
        pressed=true;
      }
    } else pressed=false;
  }  
  
  void reload() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        page=1;
        setup();
        viewload(page);
        pressed=true;
      }
    } else pressed=false;
  }  
  
  
  void label() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        blabel=!blabel;
         pressed=true;
      }
    } else pressed=false;
  } 
  void training() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        
        train=true;
        pressed=true;
      }
    } else pressed=false;
  }  
  
}
