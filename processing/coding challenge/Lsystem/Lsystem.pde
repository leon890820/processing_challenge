String word;
String theword="";
float len=10;
void setup(){
  size(640,640);
  word="F";
  background(0);
  
  print(word+"\n");
}
void draw(){
  
   
}

void Lsystem(){
  for(int i=0;i<word.length();i+=1){
      if(word.charAt(i)=='F'){
        theword+="FF+[+F-F-F]-[-F+F+F]";
      }
      else{
        theword+=word.charAt(i);
      }
  }
  word=theword;
  theword="";
}
void keyPressed(){
  Lsystem();
  print(word+"\n");
  run();
}
void run(){
  stroke(255);
  translate(width/2,height);
  for(int i=0;i<word.length();i+=1){
     len=random(5,10);
    if(word.charAt(i)=='F'){
      line(0,0,0,-len);
      translate(0,-len);
    }
    else if(word.charAt(i)=='+'){
      rotate(random(0,PI/6));
    }
    else if(word.charAt(i)=='-'){
      rotate(-random(0,PI/6));
    }
    else if(word.charAt(i)=='['){
      pushMatrix();
    }
    else if(word.charAt(i)==']'){
      popMatrix();
    }
  }
}
class rule{
  char a;
  char b;
  rule(char A,char B){
    a=A;
    b=B;
  }
}
