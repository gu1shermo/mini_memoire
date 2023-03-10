float field[][];
int res = 5;
int cols, rows;
float inc = 0.1;
float zoffs = 0.0;
OpenSimplexNoise noise;
void setup()
{
  size(600,400);
  noise = new OpenSimplexNoise();
  cols = 1 + width / res;
  rows = 1 + height / res;
  field = new float[cols][rows];
  /*
  for(int j = 0; j < cols; j++)
  {
    for(int i = 0; i < rows; i++)
    {
      int r = (int)random(2);
      field[j][i] = r;
    }
  }
  */
  
}

void draw(){
  background(127);
  // process noise
  float xoffs = 0;
  
  for(int j = 0; j < cols; j++)
  {
    xoffs += inc;
    float yoffs = 0;
    for(int i = 0; i < rows; i++)
    {
      field[j][i] = (float) noise.eval(xoffs, yoffs, zoffs);
      yoffs += inc;
    }
  }
  zoffs += 0.02;
  
  
  for(int j = 0; j < cols - 1; j++)
  {
    for(int i = 0; i < rows - 1; i++)
    {
      fill(field[j][i] * 255);
      noStroke();
      rect(j*res, i*res,res,res);
      float x = j * res;
      float y = i * res;
      PVector a = new PVector(x + res * .5  , y);
      PVector b = new PVector(x + res       , y + res * .5);
      PVector c = new PVector(x + res * .5  , y + res);
      PVector d = new PVector(x             , y + res * .5);
      
      stroke(255,0,0);
      strokeWeight(1);
      int state = getState(
        ceil(field[j][i]),
        ceil(field[j+1][i]),
        ceil(field[j+1][i+1]),
        ceil(field[j][i+1])
      );
      switch(state)
      {
        case 0:
          break;
        case 1:
          line(a, d);
          break;
        case 2:
          line(a, b);
          break;
        case 3:
          line(b, d );
          break;
        case 4:
          line(b, c );
          break;
        case 5:
          line(a, d);
          line(b, c);
          break;
        case 6:
          line(a, c );
          break;
        case 7:
          line(c, d );
          break;
        case 8:
          line(c, d );
          break;
        case 9:
          line(a, c);
          break;
        case 10:
          line(a, b );
          line(c, d);
          break;
        case 11:
          line(b, c);
          break;
        case 12:
          line(b, d );
          break;
        case 13:
          line(a, b);
          break;
        case 14:
          line(a, d);
          break;
        case 15:
          break;
          
      }
      
    }
  }
}

void line(PVector a, PVector b)
{
  line(a.x,a.y,b.x,b.y);
}

int getState(int a, int b, int c, int d)
{
  return a * 1 + b * 2 + c * 4 + d * 8;
}
