int citynum=12;
int populationsnum=100;
PVector[] cities = new PVector[citynum];
int[] best = new int[citynum];
int[] vals=new int[citynum];
int[] orders = new int[citynum];
int[][] populations=new int[populationsnum][citynum];
boolean finish = false;
float record;
float total;
float count=0;
void setup() {
    size(400,400);
    for (int i = 0; i < cities.length; i+=1) {
        PVector v=new PVector(random(width),random(height));
        cities[i]=v;
    }
    for (int i = 0; i < citynum; i+=1) {
        vals[i]=i;
    }
    
    arrayCopy(vals, best);
    total=factorial(citynum);
    for(int i=0;i<citynum;i+=1){
        orders[i]=i;
    }
    for(int i=0;i<populationsnum;i+=1){
        arrayCopy(shuffles(orders),populations[i]);        
    }    
    selectbest();
    
    
}



void draw() { 
    background(0);   
    fill(255);
    for (int i = 0; i < cities.length; i+=1) {
        textSize(10);
        circle(cities[i].x,cities[i].y,10);
        text(i,cities[i].x,cities[i].y-20);
    }
    evolution();
    selectbest();
    beginShape();
    stroke(255,0,255);
    noFill();
    strokeWeight(4);
    for (int i = 0; i < cities.length; i+=1) {
        vertex(cities[best[i]].x,cities[best[i]].y);
    }
    endShape();
    //println(best);
        
    
        
    
    count+=1;
    fill(255);
    textSize(20);
    
}

int[] swap(int[] a,int i,int j){
    int temp=a[i];
    a[i]=a[j];
    a[j]=temp;
    return a;
}

float calcDistance(PVector[] points,int[] order){
    float sum=0;
    for( int i=0; i<points.length-1; i+=1 ){
        float d=dist(points[order[i]].x, points[order[i]].y, points[order[i+1]].x, points[order[i+1]].y);
        sum+=d;
    }
    return sum;
}

float factorial(float a){
    if(a==1) return 1;
    else if(a<1) return 0;
    else return a*factorial(a-1);

}
int[] shuffles(int[] order){
    
    for(int i=0;i<100;i+=1){
        int i1=int(random(order.length));
        int i2=int(random(order.length));
        order=swap(order,i1,i2);

    }
    
    return order;
}

void evolution(){
    float[] score=new float[populationsnum];
    for(int i=0;i<score.length;i+=1){
        score[i]=1/(calcDistance(cities,populations[i])+1);
    }
    float sum=0;
    for(int i=0;i<score.length;i+=1){
      sum+=score[i];
    }
    for(int i=0;i<score.length;i+=1){
      score[i]=score[i]/sum;
    }
    //print(sum+"\n");
    selection(score);

}

void selection(float[] score){
    float low=0;
    float[] sc=new float[score.length+1];
    sc[0]=0;
    for(int i=0;i<score.length;i+=1){
        low+=score[i];
        sc[i+1]=low;
    }
    int[][] newpopulations=new int[populationsnum][citynum];
    for(int i=0;i<populationsnum;i+=1){
        float r=random(1);
        
        for(int j =0;j<score.length;j+=1){
            if(sc[j]<=r && r<=sc[j+1]){
                arrayCopy(populations[j],newpopulations[i]);
                //println(newpopulations[i]);
                break;
            }
        }
       
      
    }
    //println(score);
    
    //println(newpopulations[0]);
    arrayCopy(newpopulations,populations);
    mutate(0.1);
       
}
void mutate(float rate){
      for(int i=0;i<populationsnum;i+=1){
          if(random(1)<rate){
              int indexA=(int)random(orders.length);
              int indexB=(int)random(orders.length);
              populations[i]=swap(populations[i],indexA,indexB);
          }
    }
}
void selectbest(){
    float record=10000000;
    for(int i=0;i<populationsnum;i+=1){
        float d=calcDistance(cities,populations[i]);
        
        if (d<record){
            record=d;
            arrayCopy(populations[i],best);
            
        }
    }
}
