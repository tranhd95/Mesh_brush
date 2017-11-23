class DelaunaySystem {

  float[][]             points;
  ArrayList<PVector>    arrayPoints;
  color                 strokeColor;
  float                 strokeWeight;
  int                   maxPoints;
  float                 lineDistance;

  DelaunaySystem(int max) {
    arrayPoints = new ArrayList();
    maxPoints = max;
    points = new float[1][1];
  }

  // Main rendering function
  public void render() {

    checkLimit();

    pushStyle();
    // Set styles
    stroke(strokeColor);
    strokeWeight(strokeWeight);
    
    convertToFloat();
    
    Delaunay delaunay = new Delaunay(points);
    float[][] myEdges = delaunay.getEdges(); 
    
    for (int i=0; i < myEdges.length; i++)
    {
      float startX = myEdges[i][0];
      float startY = myEdges[i][1];
      float endX = myEdges[i][2];
      float endY = myEdges[i][3];
      if (dist(startX, startY, endX, endY) > lineDistance) {
        continue;
      }
      line( startX, startY, endX, endY );
    }
    
    popStyle();
  }
  
  public void move() {
    for (PVector point : arrayPoints) {
      point.add(PVector.random2D());
    }
  }

  // Adds point to the internal array list
  public void addPoint(float x, float y) {
    arrayPoints.add(new PVector(x, y));
  }

  // Converts array to float[][]
  private void convertToFloat() {
    float[][] newPoints = new float[arrayPoints.size()][2];
    for (int i = 0; i < arrayPoints.size(); i++) {
      PVector point = arrayPoints.get(i);
      newPoints[i][0] = point.x;
      newPoints[i][1] = point.y;
    }
    points = newPoints;
  }

  // If number of points reaches the limit, clear the array
  private void checkLimit() {
    boolean isOverLimit = points.length >= maxPoints;
    if (isOverLimit) {
      arrayPoints.clear();
    }
  }

  public void setStroke(int c) {
    this.strokeColor = c;
  }

  public void setStrokeWeight(float sw) {
    this.strokeWeight = sw;
  }

  public void setLineDistance(float d) {
    lineDistance = d;
  }
}