class EvolutionGraph extends PApplet {

  EvolutionGraph() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(1000, 600);
  }

  void setup() {
    background(255);
    for (int i=0; i<recordClusters[0].length; i+=1) {
      DataCluster dc=recordClusters[0][i];
      stroke(0);
      fill(dc.clusterColor, 100);
      ellipse(dc.location.x, dc.location.y, width*0.8/dataPoints.length, 20);
      fill(0);
      textAlign(CENTER, CENTER);
      text(dc.label, dc.location.x, dc.location.y);
    }
    for (int k=0; k<iteration; k+=1) {
      for (int i=0; i<recordClusters[k+1].length; i+=1) {
        if (notIn(recordClusters[k+1][i], recordClusters[k])) {
          DataCluster dc=recordClusters[k+1][i];
          stroke(0);
          line(dc.location.x,dc.location.y,dc.childA.location.x,dc.childA.location.y);
          line(dc.location.x,dc.location.y,dc.childB.location.x,dc.childB.location.y);
          
          stroke(0);
          noFill();
          String s="";
          for (int j=0; j<recordClusters[k+1][i].dataCluster.size(); j+=1) {
            s+=str(recordClusters[k+1][i].dataCluster.get(j).label)+" ";
          }
          fill(dc.clusterColor, 100);
          ellipse(dc.location.x, dc.location.y, max(width*0.8/dataPoints.length,s.length()*8), 20);
          
          fill(0);
          text(s, dc.location.x, dc.location.y);
        }
      }
    }
  }

  boolean notIn(DataCluster a, DataCluster[] b) {
    for (int i=0; i<b.length; i+=1) {
      if (a.dataCluster==b[i].dataCluster) return false;
    }

    return true;
  }
}
