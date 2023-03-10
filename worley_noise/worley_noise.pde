// 1) randomly distribute feature points in space
// 2) Fn(x) = distance to the nth closest point
// x => represents a pixel
PVector[] points = new PVector[100];
int nth = 0;
void setup()
{
  size(400,400);
  // init array with random values
  for(int i = 0; i < points.length; i++)
  {
    println(points[i]);
    points[i] = new PVector();
    points[i].x = random(width);
    points[i].y = random(height);
    points[i].z = random(width);
  }
  
}

void draw()
{
  loadPixels();
  for (int x=0; x < width; x++)
  {
    for (int y=0; y < height; y++)
    {
      // pour chaque pixel
      // on calcule la distance par rapport aux points
      float distances[] = new float[points.length];
      for(int i = 0; i < points.length; i++)
      {
        float z = (frameCount * 1.) % width;
        float d = dist(x, y, z, points[i].x, points[i].y, points[i].z);
        //if (mousePressed)
        //{
        //  d = dist(x, y ,points[i].x, points[i].y);
        //}
        distances[i] = d;
        
      }
      float sorted[] = sort(distances);
      
      float r = map(sorted[0], 0, 100,0,255);
      float g = map(sorted[1], 0, 50,255,0);
      float b = map(sorted[2], 0, 100,0,100);
      
      pixels[y * width + x] = color(r,g,b);
    }
  }
  
  updatePixels();
  //noLoop();
  // display and move points array
  //for(PVector v : points)
  //{
  //  stroke(0,255,0);
  //  strokeWeight(8);
  //  point(v.x,v.y);
  //  //move
  //  v.x += random(-5,5);
  //  v.y += random(-5,5);
  //}
  
}
