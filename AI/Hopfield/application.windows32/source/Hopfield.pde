String[] Basic_training_data;
String[] Basic_testing_data;
String[] Bonus_training_data;
String[] Bonus_testing_data;
ArrayList<Data> testdatas;
ArrayList<Data> datas;
ArrayList<Data> bonustestdatas;
ArrayList<Data> bonusdatas;
Button[] trainButton;
Button[] bonustrainButton;
int cols;
int rows;
int bonuscols;
int bonusrows;
boolean menu=true;
boolean train=false;
boolean[] training;
boolean[] bonustraining;
net NN;
net bonusNN;
void setup(){
  size(600,600);
  background(0);
  datas=new ArrayList<Data>();
  testdatas=new ArrayList<Data>();
  bonusdatas=new ArrayList<Data>();
  bonustestdatas=new ArrayList<Data>();
  //basic_training
  FloatList input=new FloatList();  
  Basic_training_data=loadStrings("Basic_Training.txt");
  for(int i=0;i<Basic_training_data.length;i+=1){
    //println(Basic_training_data[i]);
    for(int j=0;j<Basic_training_data[i].length();j+=1){
      if(Basic_training_data[i].charAt(j)=='1'){
        input.append(1);
      }
      else{
        input.append(-1);
      }
    }    
    if(Basic_training_data[i].length()==0 || i==Basic_training_data.length-1){
      float[] in=new float[input.size()];
      
      for(int j=0;j<in.length;j+=1){
        in[j]=input.get(j);
      }
      datas.add(new Data(in));
      input.clear();
    }
    
  }
  //basic_test
  input=new FloatList();
  Basic_testing_data=loadStrings("Basic_Testing.txt");
  for(int i=0;i<Basic_testing_data.length;i+=1){
    //println(Basic_training_data[i]);
    for(int j=0;j<Basic_testing_data[i].length();j+=1){
      if(Basic_testing_data[i].charAt(j)=='1'){
        input.append(1);
      }
      else{
        input.append(-1);
      }
    }    
    if(Basic_testing_data[i].length()==0 || i==Basic_testing_data.length-1){
      float[] in=new float[input.size()];
      
      for(int j=0;j<in.length;j+=1){
        in[j]=input.get(j);
      }
      testdatas.add(new Data(in));
      input.clear();
    }
    
  }
  //bonus_training
  input=new FloatList();
  Bonus_training_data=loadStrings("Bonus_Training.txt");
  for(int i=0;i<Bonus_training_data.length;i+=1){
    //println(Basic_training_data[i]);
    for(int j=0;j<Bonus_training_data[i].length();j+=1){
      if(Bonus_training_data[i].charAt(j)=='1'){
        input.append(1);
      }
      else{
        input.append(-1);
      }
    }    
    if(Bonus_training_data[i].length()==0 || i==Bonus_training_data.length-1){
      float[] in=new float[input.size()];
      
      for(int j=0;j<in.length;j+=1){
        in[j]=input.get(j);
      }
      bonusdatas.add(new Data(in));
      input.clear();
    }
    
  }
  
  //bonus_testing
  input=new FloatList();
  Bonus_testing_data=loadStrings("Bonus_Testing.txt");
  for(int i=0;i<Bonus_testing_data.length;i+=1){
    //println(Basic_training_data[i]);
    for(int j=0;j<Bonus_testing_data[i].length();j+=1){
      if(Bonus_testing_data[i].charAt(j)=='1'){
        input.append(1);
      }
      else{
        input.append(-1);
      }
    }    
    if(Bonus_testing_data[i].length()==0 || i==Bonus_testing_data.length-1){
      float[] in=new float[input.size()];
      
      for(int j=0;j<in.length;j+=1){
        in[j]=input.get(j);
      }
      bonustestdatas.add(new Data(in));
      input.clear();
    }
    
  }
  //print(bonustestdatas.size());
  trainButton=new Button[testdatas.size()];
  bonustrainButton=new Button[bonustestdatas.size()];
  rows=Basic_training_data[0].length();
  cols=(Basic_training_data.length+1)/datas.size()-1;
  bonusrows=Bonus_training_data[0].length();
  bonuscols=(Bonus_training_data.length+1)/bonusdatas.size()-1;
  for(int i=0;i<testdatas.size();i+=1){
    trainButton[i]=new Button(str(i),100+(i*15*rows)+0.5*(rows*testdatas.get(0).scl),100+0.5*cols*testdatas.get(0).scl,0,rows*testdatas.get(0).scl*1.1,cols*testdatas.get(0).scl*1.1,0);
  }
  for(int i=0;i<bonustestdatas.size();i+=1){
    bonustrainButton[i]=new Button(str(i),100+((i%5)*11*rows)+0.5*(bonusrows*bonustestdatas.get(0).scl),255+int(i/5)*15*bonustestdatas.get(0).scl+0.5*bonuscols*bonustestdatas.get(0).scl,0,bonusrows*bonustestdatas.get(0).scl*1.1,cols*bonustestdatas.get(0).scl*1.1,0);
  }
  training=new boolean[testdatas.size()];
  bonustraining=new boolean[bonustestdatas.size()];
  NN=new net(cols,rows,datas);
  bonusNN=new net(bonuscols,bonusrows,bonusdatas);
  //print(bonuscols,bonusrows);
  //println(bonusNN.network.w[0]);
} 


void draw(){
  background(0);
  if(menu)menu();
  else if(train) train();


}

void menu(){
  for(Button b:trainButton){
    b.show();
    b.run(b.name);
  }
  for(Button b:bonustrainButton){
    b.show();
    b.bonusrun(b.name);
  }
  for(int i=0;i<testdatas.size();i+=1){
    testdatas.get(i).show(100+i*15*rows,100,rows,cols); 
  }
  for(int i=0;i<bonustestdatas.size();i+=1){
    bonustestdatas.get(i).show(100+(i%5)*10*bonusrows,250+int(i/5)*13*bonuscols,bonusrows,bonuscols); 
  }
  
  for(int i=0;i<testdatas.size();i+=1){
    if(training[i]==true) testdatas.get(i).train();
  
  }
  for(int i=0;i<bonustestdatas.size();i+=1){
    if(bonustraining[i]==true) bonustestdatas.get(i).bonustrain();
  
  }
  
  
}

void train(){


}
