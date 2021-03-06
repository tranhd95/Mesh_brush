import java.lang.Float.*;

class DelaunaySystem {

  float[][]             points;
  ArrayList<PVector>    arrayPoints;
  color                 strokeColor;
  int                   strokeAlpha;
  float                 strokeWeight;
  int                   maxPoints;
  float                 lineDistance;
  boolean               generated;

  DelaunaySystem(int max) {
    arrayPoints = new ArrayList();
    maxPoints = max;
    points = new float[1][2];
  }

  // Main rendering function
  public void render() {

    checkLimit();

    pushStyle();
    // Set styles
    stroke(strokeColor, strokeAlpha);
    strokeWeight(strokeWeight);

    convertToFloat();

    Voronoi delaunay = new Voronoi(points);
    float[][] myEdges = delaunay.getEdges(); 

    Delaunay delaunay2 = new Delaunay(points);
    float[][] myEdges2 = delaunay2.getEdges();

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

    for (int i=0; i < myEdges2.length; i++)
    {
      float startX = myEdges2[i][0];
      float startY = myEdges2[i][1];
      float endX = myEdges2[i][2];
      float endY = myEdges2[i][3];
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

  // Generate random points on sketch
  public void generateRandom() {
    generated = true;
    for (int i = 0; i < maxPoints; i++) {
      addPoint(random(width), random(height));
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

    if (generated) return;
    boolean isOverLimit = points.length >= maxPoints;
    if (isOverLimit) {
      arrayPoints.clear();
      background(0);
    }
  }

  public float getMeanX() {
    float result = Statistics.meanX(points);
    return Float.isNaN(result) ? 0 : result;
  }

  public float getMeanY() {
    float result = Statistics.meanY(points);
    return Float.isNaN(result) ? 0 : result;
  }

  public float getMedianX() {
    float result = Statistics.medianX(points);
    return Float.isNaN(result) ? 0 : result;
  }

  public float getMedianY() {
    float result = Statistics.medianY(points);
    return Float.isNaN(result) ? 0 : result;
  }

  public void setStroke(int c) {
    this.strokeColor = c;
    this.strokeAlpha = 255;
  }

  public void setStroke(int c, int alpha) {
    this.strokeColor = c;
    this.strokeAlpha = alpha;
  }

  public void setStrokeWeight(float sw) {
    this.strokeWeight = sw;
  }

  public void setLineDistance(float d) {
    lineDistance = d;
  }
  
  public void clear() {
    arrayPoints.clear();
  }
}