class CocktailSort{
  int bottom=0;
  int top=num-1;
  boolean swapped=true;
  
  CocktailSort(){
  
  
  }
  void run(){
    while(swapped){
      swapped=false;
      for(int i=bottom;i<top;i+=1){
        if(sortNumber[i]>sortNumber[i+1]){
          sortNumber=swap(i,i+1,sortNumber);
          newDot();
          swapped=true;
        }     
      }
      top-=1;
      for(int i=top;i>bottom;i-=1){
        if(sortNumber[i]<sortNumber[i-1]){
          sortNumber=swap(i,i-1,sortNumber);
          newDot();
          swapped=true;
        
        }
      
      }
      bottom+=1;
    
    }
  
  
  }


}
