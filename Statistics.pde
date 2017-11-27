public static class Statistics {

  public static float meanX(float[][] data) {
    float sum = 0;
    for (int i = 0; i < data.length; i++) {
      sum += data[i][0];
    }
    return sum / data.length;
  }

  public static float meanY(float[][] data) {
    float sum = 0;
    for (int i = 0; i < data.length; i++) {
      sum += data[i][1];
    }
    return sum / data.length;
  }

  public static float medianX(float[][] data) {
    if(data.length <= 1) return 0;
    int middle = data.length/2;
    if (data.length%2 == 1) {
      return data[middle][0];
    } else {
      return (data[middle][0] + data[middle][0]) / 2.0;
    }
  }
    public static float medianY(float[][] data) {
    if(data.length <= 1) return 0;
    int middle = data.length/2;
    if (data.length%2 == 1) {
      return data[middle][1];
    } else {
      return (data[middle][1] + data[middle][1]) / 2.0;
    }
  }
}