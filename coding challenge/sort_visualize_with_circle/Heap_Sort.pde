class HeapSort {
  HeapSort() {
  }
  void run(){
    heap_sort(sortNumber.length);
    newDot();
    stop=true;
  }
  void max_heapify(int start, int end) {
    
    int dad = start;
    int son = dad * 2 + 1;
    while (son <= end) { 
      if (son + 1 <= end && sortNumber[son] < sortNumber[son + 1]) 
        son++;
      if (sortNumber[dad] > sortNumber[son]) 
        return;
      else { 
        sortNumber=swap(dad, son,sortNumber);
        newDot();
        delay(1);
        dad = son;
        son = dad * 2 + 1;
      }
    }
  }

  void heap_sort(int len) {
    int i;

    for (i = len / 2 - 1; i >= 0; i--)
      max_heapify(i, len - 1);

    for (i = len - 1; i > 0; i--) {
      sortNumber=swap(0, i,sortNumber);
      newDot();
      delay(1);
      max_heapify(0, i - 1);
    }
  }
}
