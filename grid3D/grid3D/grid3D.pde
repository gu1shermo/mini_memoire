//import peasy.*;
// colors

// TODO improvments
// interpolation to draw triangles

color c0 = #BAD1CD;
color c1 = #416165;
color c2 = #E15554;
color c3 = #F6AE2D;
color c4 = #542344;

color fillColor = c2;
//PeasyCam cam;
float rotation = 0.0;
float field[][][];
int field_states[][][];
int res = 25;
int x_width, y_height, z_depth;
// ISO SURFACE
float isoValue = 0.25;
float isoInc = .010;

// record
String filename = "simplex_anim";
int nFrames = 1000;
int currentFrame = 0;

// WORLEY NOISE
int nPoints = 50;
PVector[] points = new PVector[nPoints];
int nth = 0;

// SIMPLEX NOISE
OpenSimplexNoise noise;

//int[] triangles = listOfEdges;
int[] triangles = triTable;

// TODO camera for user
void setup()
{
  
  size(960,540, P3D);
  x_width  = width / res +1; 
  y_height = width / res +1; 
  z_depth  = width / res +1;
  
  field = new float[x_width][y_height][z_depth];
  field_states = new int[x_width][y_height][z_depth];
  // CAM PEASY
  //cam = new PeasyCam(this, 100);
  
  //cam.setMinimumDistance(5);
  //cam.setMaximumDistance(1000);
  //initFieldArrayRandom(); // RANDOM
  //initFieldArrayPerlin(); // PERLIN
  //initWorleyPoints();     // WORLEY1
  //initFieldArrayWorley(nth); // WORLEY2
  noise = new OpenSimplexNoise();// SIMPLEX1
  initFieldArraySimplex(); // SIMPLEX 2
  // comparaison doc
  //field_states[0][0][0] = 0; // v4
  //field_states[0][0][1] = 0; // v7
  //field_states[0][1][0] = 0; // v0
  //field_states[0][1][1] = 0; // v3
  //field_states[1][0][0] = 0; // v5
  //field_states[1][0][1] = 0; // v6
  //field_states[1][1][0] = 0; // v1
  //field_states[1][1][1] = 1; // v2
  frameRate(60);
}

void draw()
{
  //noLoop();
  background(0);
  // debug worley
  //for(int i = 0; i < points.length; i++)
  //{
  //  stroke(255,0,0);
  //  strokeWeight(8);
  //  point(points[i].x,points[i].y,points[i].z);
  //}
  //translate(0, 100,-1000);
  
  //rotateY(0.35 + frameCount * .01);
  //rotateY(0.35);
  float camX = cos(frameCount * .01) * 1500;
  float camZ = sin(frameCount * .01) * 1500;
  
  //pointLight(255,255,255,0,500,0);
  
  //ortho(-width/2, width/2, -height/2, height/2, -10000,10000); 
  camera(
          camX , 0, camZ , // cam pos XYZ
          width/2, width/2, width/2, // cam lookAt XYZ
          //0,0,0,
          0, 1, 0 // cam orientation XYZ
          );
  
  //float orbitRadius= 1500;
  //float ypos= 500;
  //float xpos= cos(radians(rotation))*orbitRadius;
  //float zpos= sin(radians(rotation))*orbitRadius;
  
  //camera(xpos, ypos, zpos, 0, 0, 0, 0, -1, 0);
  //rotation++;
  
  //rotateX(0.35+ frameCount * .01);
  // ANIMATION
  if (frameCount % 2 == 0)
  {
    //initFieldArrayWorley(nth); // worley
    initFieldArraySimplex(); // simplex
    //initFieldArrayRandom(); // RANDOM
    //initFieldArrayPerlin(); // PERLIN
    isoValue -= isoInc;
    //println(isoValue, "frameCount % 2 == 0");
  }
  if(isoValue < 0 )
  {
    println(isoValue, "<0");
    isoValue = 1.;
  }
  
  PVector[] cubeVertexPositions = new PVector[8];
  // get values field array
  for(int i = 0; i < x_width-1; i++)
  {
    for(int j = 0; j < y_height-1; j++)
    {
      for(int k = 0; k < z_depth-1; k++)
      {
        
        
        // values on each vertex 0 or 1
        int v0 = field_states  [i]    [j+1]    [k];
        int v1 = field_states  [i+1]  [j+1]    [k];
        int v2 = field_states  [i+1]  [j+1]    [k+1];
        int v3 = field_states  [i]    [j+1]    [k+1];
        int v4 = field_states  [i]    [j]  [k];
        int v5 = field_states  [i+1]  [j]  [k];
        int v6 = field_states  [i+1]  [j]  [k+1];
        int v7 = field_states  [i]    [j]  [k+1];
        
        
        PVector v0Pos = new PVector(i*res,       (j+1)*res,    k*res        );
        PVector v1Pos = new PVector((i+1)*res,   (j+1)*res,    k*res        );
        PVector v2Pos = new PVector((i+1)*res,   (j+1)*res,    (k+1)*res    );
        PVector v3Pos = new PVector(i*res,       (j+1)*res,    (k+1)*res);
        PVector v4Pos = new PVector(i*res,       j*res,        k*res);
        PVector v5Pos = new PVector((i+1)*res,   j*res,        k*res        );
        PVector v6Pos = new PVector((i+1)*res,   j*res,        (k+1)*res    );
        PVector v7Pos = new PVector(i*res,       j*res,        (k+1)*res    );
        // fill array
        cubeVertexPositions[0] = v0Pos;
        cubeVertexPositions[1] = v1Pos;
        cubeVertexPositions[2] = v2Pos;
        cubeVertexPositions[3] = v3Pos;
        cubeVertexPositions[4] = v4Pos;
        cubeVertexPositions[5] = v5Pos;
        cubeVertexPositions[6] = v6Pos;
        cubeVertexPositions[7] = v7Pos;
        
        // debug draw cube edges
        //strokeWeight(.5);
        //stroke(200); // 
        //// front
        //line3D(v0Pos, v1Pos);
        //line3D(v1Pos, v2Pos);
        //line3D(v2Pos, v3Pos);
        //line3D(v3Pos, v0Pos);
        //// back
        //line3D(v4Pos, v5Pos);
        //line3D(v5Pos, v6Pos);
        //line3D(v6Pos, v7Pos);
        //line3D(v7Pos, v4Pos);
        //// sides
        //line3D(v0Pos, v4Pos);
        //line3D(v1Pos, v5Pos);
        //line3D(v2Pos, v6Pos);
        //line3D(v3Pos, v7Pos);
        
        int state_index = getIndex(v0,v1,v2,v3,v4,v5,v6,v7);
        // println("cube:",i,j,k, "state_index", state_index);
        
        // TODO: refacto
        // get edgesindex to draw triangles
        int indexEdges[] = new int[16];
        for(int index = 0; index < 16; index++)
        {
          int el = triangles[state_index * 16 + index]; 
          indexEdges[index] = el;
        }
        //println("display array triangles to draw:");
        
        
        //for(int index = 0; index < 15; index++)
        //{
        //  print(indexEdges[index]+",", "");
        //}
        
        // draw triangles
        drawTriangles(cubeVertexPositions, indexEdges);
        
      }
    }
  }
  // debug display vertices CUBE
  //for(int i = 0; i < x_width; i++)
  //{
  //  for(int j = 0; j < y_height; j++)
  //  {
  //    for(int k = 0; k < z_depth; k++)
  //    {
  //      noFill();
  //      stroke(field_states[i][j][k] * 255);
  //      strokeWeight(8);
  //      point(i*res,j*res,k*res);
  //    }
  //  }
  //}
  if(currentFrame < nFrames)
    saveFrame("./frames/"+filename+"-######.png");
  currentFrame += 1;
}

void line3D(PVector a, PVector b)
{
  line(a.x,a.y,a.z,b.x,b.y,b.z);
}

int getIndex(int v0, int v1, int v2, int v3, int v4, int v5, int v6, int v7)
{
  return v0 * 1 + v1 * 2 + v2 * 4 + v3 * 8 + v4 * 16 + v5 * 32 + v6 * 64 + v7 * 128;
}

void drawTriangles(PVector[] cubeVertexPositions, int[] indexEdges)
{
  //print("drawTriangles()");
  for(int i = 0; i < indexEdges.length; i+=3)
  {
    if(indexEdges[i] == -1) continue;
    int index_edge0 = indexEdges[i+0];
    int index_edge1 = indexEdges[i+1];
    int index_edge2 = indexEdges[i+2];
    
    // get ALL middle edges (todo opti)
    PVector me0 = new PVector(
                  (cubeVertexPositions[0].x + cubeVertexPositions[1].x) * .5,
                  (cubeVertexPositions[0].y + cubeVertexPositions[1].y) * .5,
                  (cubeVertexPositions[0].z + cubeVertexPositions[1].z) * .5
                  );
    PVector me1 = new PVector(
                  (cubeVertexPositions[1].x + cubeVertexPositions[2].x) * .5,
                  (cubeVertexPositions[1].y + cubeVertexPositions[2].y) * .5,
                  (cubeVertexPositions[1].z + cubeVertexPositions[2].z) * .5
                  );
    
    PVector me2 = new PVector(
                  (cubeVertexPositions[2].x + cubeVertexPositions[3].x) * .5,
                  (cubeVertexPositions[2].y + cubeVertexPositions[3].y) * .5,
                  (cubeVertexPositions[2].z + cubeVertexPositions[3].z) * .5
                  );
    
    PVector me3 = new PVector(
                  (cubeVertexPositions[3].x + cubeVertexPositions[0].x) * .5,
                  (cubeVertexPositions[3].y + cubeVertexPositions[0].y) * .5,
                  (cubeVertexPositions[3].z + cubeVertexPositions[0].z) * .5
                  );
    PVector me4 = new PVector(
                  (cubeVertexPositions[4].x + cubeVertexPositions[5].x) * .5,
                  (cubeVertexPositions[4].y + cubeVertexPositions[5].y) * .5,
                  (cubeVertexPositions[4].z + cubeVertexPositions[5].z) * .5
                  );
    PVector me5 = new PVector(
                  (cubeVertexPositions[5].x + cubeVertexPositions[6].x) * .5,
                  (cubeVertexPositions[5].y + cubeVertexPositions[6].y) * .5,
                  (cubeVertexPositions[5].z + cubeVertexPositions[6].z) * .5
                  );
    PVector me6 = new PVector(
                  (cubeVertexPositions[6].x + cubeVertexPositions[7].x) * .5,
                  (cubeVertexPositions[6].y + cubeVertexPositions[7].y) * .5,
                  (cubeVertexPositions[6].z + cubeVertexPositions[7].z) * .5
                  );
    PVector me7 = new PVector(
                  (cubeVertexPositions[7].x + cubeVertexPositions[4].x) * .5,
                  (cubeVertexPositions[7].y + cubeVertexPositions[4].y) * .5,
                  (cubeVertexPositions[7].z + cubeVertexPositions[4].z) * .5
                  );
    PVector me8 = new PVector(
                  (cubeVertexPositions[0].x + cubeVertexPositions[4].x) * .5,
                  (cubeVertexPositions[0].y + cubeVertexPositions[4].y) * .5,
                  (cubeVertexPositions[0].z + cubeVertexPositions[4].z) * .5
                  );
    PVector me9 = new PVector(
                  (cubeVertexPositions[1].x + cubeVertexPositions[5].x) * .5,
                  (cubeVertexPositions[1].y + cubeVertexPositions[5].y) * .5,
                  (cubeVertexPositions[1].z + cubeVertexPositions[5].z) * .5
                  );
    PVector me10 = new PVector(
                  (cubeVertexPositions[2].x + cubeVertexPositions[6].x) * .5,
                  (cubeVertexPositions[2].y + cubeVertexPositions[6].y) * .5,
                  (cubeVertexPositions[2].z + cubeVertexPositions[6].z) * .5
                  );
    PVector me11 = new PVector(
                  (cubeVertexPositions[3].x + cubeVertexPositions[7].x) * .5,
                  (cubeVertexPositions[3].y + cubeVertexPositions[7].y) * .5,
                  (cubeVertexPositions[3].z + cubeVertexPositions[7].z) * .5
                  );
    // middle edges array
    PVector[] middle_edges = new PVector[12];
    middle_edges[0] = me0;
    middle_edges[1] = me1;
    middle_edges[2] = me2;
    middle_edges[3] = me3;
    
    middle_edges[4] = me4;
    middle_edges[5] = me5;
    middle_edges[6] = me6;
    middle_edges[7] = me7;
    
    middle_edges[8] = me8;
    middle_edges[9] = me9;
    middle_edges[10] = me10;
    middle_edges[11] = me11;
    
    
    // draw triangle 
    fill(fillColor);
    stroke(30);
    strokeWeight(1);
    beginShape();
      vertex(middle_edges[index_edge0].x,middle_edges[index_edge0].y,middle_edges[index_edge0].z);
      vertex(middle_edges[index_edge1].x,middle_edges[index_edge1].y,middle_edges[index_edge1].z);
      vertex(middle_edges[index_edge2].x,middle_edges[index_edge2].y,middle_edges[index_edge2].z);
    endShape();
    
  }
}

void initFieldArrayRandom()
{
  // init field array
  for(int i = 0; i < x_width; i++)
  {
    for(int j = 0; j < y_height; j++)
    {
      for(int k = 0; k < z_depth; k++)
      {
        float r = random(1); // replace with true noise! in 3D
        field[i][j][k] = r;
        if(r>isoValue) r=0.;
        else r =1.;
        field_states[i][j][k] = (int)r;
      }
    }
  }
}

void initFieldArrayPerlin()
{
  float iOffs = 0;
  float inc = .15;
  for(int i = 0; i < x_width; i++)
  {
    float jOffs = 0;
    for(int j = 0; j < y_height; j++)
    {
      float kOffs = 0;
      for(int k = 0; k < z_depth; k++)
      {
        float r = noise(iOffs,jOffs,kOffs);
        //println(i,j,k,"noise perlin:",r);
        field[i][j][k] = r;
        if(r>isoValue) r=0.;
        else r =1.;
        field_states[i][j][k] = (int)r;
        kOffs += inc;
      }
      jOffs += inc;
    }
    iOffs += inc;
  }
  
}

void initFieldArraySimplex()
{
  float iOffs = 0.0;
  float inc = .15;
  for(int i = 0; i < x_width; i++)
  {
    float jOffs = 0;
    for(int j = 0; j < y_height; j++)
    {
      float kOffs = 0;
      for(int k = 0; k < z_depth; k++)
      {
        float r = (float) noise.eval(iOffs,jOffs,kOffs);
        //println(i, j, k, "noise simplex:", r);
        field[i][j][k] = r;
        if(r>isoValue) r=0.;
        else r =1.;
        field_states[i][j][k] = (int)r;
        kOffs += inc;
      }
      jOffs += inc;
    }
    iOffs += inc;
  }
  
}

void initWorleyPoints()
{
  for(int i = 0; i < points.length; i++)
  {
    points[i] = new PVector();
    points[i].x = random(width);
    points[i].y = random(width);
    points[i].z = random(width);
  }
  
}

void initFieldArrayWorley(int rank)
{
  int nBelow = 0;
  int nAbove = 0;
  
  for(int i = 0; i < x_width; i++)
  {
    for(int j = 0; j < y_height; j++)
    {
      for(int k = 0; k < z_depth; k++)
      {
        float distances[] = new float[points.length];
        for(int p = 0; p < points.length; p++)
        {
          // debug multiplier par la resolution ??
          float d = dist(i*res, j*res, k*res, points[p].x, points[p].y, points[p].z);
          //println("distance between:",i,j,k,"and",points[p].x, points[p].y, points[p].z);
          distances[p] = d;
        }
        float sorted[] = sort(distances);
        
        float distToNearestPoint = sorted[rank];
        //println(i,j,k,"distToNearestPoint",distToNearestPoint);
        distToNearestPoint = map(distToNearestPoint,0,400,0,1);
        //println(i,j,k,"distToNearestPoint map",distToNearestPoint);
        distToNearestPoint = constrain(distToNearestPoint,0,1);
        //println(i,j,k,"distToNearestPoint constrain",distToNearestPoint);
        
        if(distToNearestPoint < .5) nBelow += 1;
        else nAbove += 1; 
        
        field[i][j][k] = distToNearestPoint;
        
        if(distToNearestPoint > isoValue) distToNearestPoint=0.;
        else distToNearestPoint =1.;
        field_states[i][j][k] = (int)distToNearestPoint;
      }
    }
  }
  
  //println("nBelow:", nBelow);
  //println("nAbove:", nAbove);
  //println("maxDistance:", maxDistance);
  
}
