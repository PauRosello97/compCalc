float UNISON = 0;
float MINOR_SECOND = 7.907;
float SECOND = 6.17;
float MINOR_THIRD = 4.322;
float FOURTH = 3.585;
float DIMINISHED_FIFTH = 11.492;
float FIFTH = 2.585;
float MINOR_SIXTH = 5.322;
float SIXTH = 3.907;
float MINOR_SEVENTH = 7.17;
float SEVENTH = 6.907;
float OCTAVE = 1;

float[][] POINTS = {{0, 0},{DIMINISHED_FIFTH, 0}};
float[] DESIRED_DISTANCES = {FOURTH, MINOR_SECOND};

void setup(){
  
  float[] target = {0, 0};
  float[] result = getPoint(target, 1);
  result = getPoint(result, 0.1);
  result = getPoint(result, 0.01);
  result = getPoint(result, 0.001);
  result = getPoint(result, 0.0001);
  result = getPoint(result, 0.00001);
  result = getPoint(result, 0.000001);
}

float[] getPoint(float[] target, float STEP_SIZE){
  
  int precision = str(STEP_SIZE).length()-2;
  float[] min = {target[0] - STEP_SIZE*100, target[1] - STEP_SIZE*100};
  float[] max = {target[0] + STEP_SIZE*100, target[1] + STEP_SIZE*100};
  
  int iterations = 0;
  for(int i=0; i<max.length; i++) iterations += (max[i]-min[i])/STEP_SIZE;
  
  float[] iP = {0,0};
  
  float minDifference = 100000000000000000.0;
  float[] closestPoint = {0,0};
  iP[0] = min[0];
  while(iP[0]<max[0]){
    iP[1] = min[1];
    while(iP[1]<max[1]){
      float[] k = {iP[0],iP[1]}; 
      float[] distances = {getDistance(k, POINTS[0]), getDistance(k, POINTS[1])};
      
      float difference = 0;
      for(int i=0; i<distances.length; i++) difference += abs((distances[0]-DESIRED_DISTANCES[i]));
      
      if(difference<minDifference){
        minDifference = difference;
        closestPoint = iP;
      }
      iP[1] += STEP_SIZE;
    }
    iP[0] += STEP_SIZE;
  }
  String pre = "%.0"+precision+"f";
  println();
  println("---------------------");
  println("SEARCHED IN:");
  println("x : [" + min[0] + ", " + max[0] + "]");
  println("y : [" + min[1] + ", " + max[1] + "]");
  println("WITH PRECISION: " + precision);
  println("DISTANCE A: " + getDistance(closestPoint, POINTS[0]));
  println("DISTANCE B: " + getDistance(closestPoint, POINTS[1]));
  println("RESULT: (" + String.format(pre, closestPoint[0]) + ", " + String.format(pre, closestPoint[1]) + ") - d: " + minDifference);
  
  float[] result = {closestPoint[0], closestPoint[1]};
  return result;
}

float getDistance(float[] pointA, float[] pointB){
  if(pointA.length != pointB.length) println("ERROR! The dimensions are not matching");
  float sum = 0;
  for(int i=0; i<pointA.length; i++){
    sum += pow(pointA[i] + pointB[i], 2);
  }
  return sqrt(sum);
}
