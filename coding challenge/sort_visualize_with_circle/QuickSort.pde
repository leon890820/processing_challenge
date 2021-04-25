class QuickSort {
  
  QuickSort() {
    
  }
  void run() {
    quickSort(0,sortNumber.length-1);
    newDot();    
    
    stop=true;
  }
  
  void quickSort(int s,int t){
    if(s>=t) return;
    int x=sortNumber[s];
    int i=s;
    int count=0;
    for(int j=i+1;j<=t;j+=1){
      if(sortNumber[j]<x){
        untillSwap(i+count,j);
        count+=1;
      }
    
    }
    
    quickSort(s,s+count);
    quickSort(s+count+1,t);
  
  }
  void untillSwap(int i,int j){
    while(true){
      if(i==j) break;
      sortNumber=swap(j-1,j,sortNumber);
      newDot();
      //delay(0.01);
      
      
      j-=1;
    }
  
  }
  
  /*
  int[] quickSort(int[] q) {
    if (q.length<=1) {
      return q;
    } else {
      int pivot=q[(int)random(q.length)];
      IntList lessList=new IntList();
      IntList largeList=new IntList();
      for (int qq : q) {
        if (qq<pivot) lessList.append(qq);
        else if (qq>pivot) largeList.append(qq);
      }
      int[] less=new int[lessList.size()];
      int[] large=new int[largeList.size()];
      for (int i=0; i<lessList.size(); i+=1) less[i]=lessList.get(i);
      for (int i=0; i<largeList.size(); i+=1) large[i]=largeList.get(i);
      
      return concatenate(quickSort(less),pivot,quickSort(large));
      
      
    }
  }
  
  
  int[] concatenate(int[] less,int p,int[] large){
    int index=0;
    int[] c=new int[less.length+large.length+1];
    for(int i=0;i<less.length;i+=1){
      c[index]=less[i];
      index+=1;
    }
    c[index]=p;
    index+=1;
    for(int i=0;i<large.length;i+=1){
      c[index]=large[i];
      index+=1;
    }
    return c;
  }
  */
}
