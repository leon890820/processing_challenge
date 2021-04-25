class BubbleSort{
  
  BubbleSort(){
    
  
  
  }
  void run(){
    for(int i=0;i<sortNumber.length-1;i+=1){
      for(int j=0;j<sortNumber.length-1-i;j+=1){
        if(sortNumber[j]>sortNumber[j+1]){
          sortNumber=swap(j,j+1,sortNumber);
          newDot();
        }
      
      }
    }
  
  
  }



}
