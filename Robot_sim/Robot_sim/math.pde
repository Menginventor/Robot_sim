float[][] add_vect(float[][] a, float[][] b) {
  float[][] result = new float[a.length][a[0].length];
  for (int i = 0; i<a.length; i++) {
    for (int j = 0; j<a[0].length; j++) {
      result[i][j] = a[i][j] + b[i][j];
    }
  }
  return result;
}
float[][] sub_vect(float[][] a, float[][] b) {
  float[][] result = new float[a.length][a[0].length];
  for (int i = 0; i<a.length; i++) {
    for (int j = 0; j<a[0].length; j++) {
      result[i][j] = a[i][j] - b[i][j];
    }
  }
  return result;
}
float[][] mult_vect(float[][] a, float b) {
  float[][] result = new float[a.length][a[0].length];
  for (int i = 0; i<a.length; i++) {
    for (int j = 0; j<a[0].length; j++) {
      result[i][j] = a[i][j]*b;
    }
  }
  return result;
}