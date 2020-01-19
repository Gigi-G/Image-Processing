PImage I;
float[][] R, Im;
int r = 108;
int r1 = 128;

void settings(){
  I = loadImage("lena.png");
  I.filter(GRAY);
  I.resize(r,r);
  R = new float[I.width][I.height];
  Im = new float[I.width][I.height];
  for(int i=0; i<I.width; i++){
     for(int j=0; j<I.height; j++) R[i][j] = Im[i][j] = 0; 
  }
  size(386,128);
}

void setup(){
   background(255);
   DFT(I);
   
   PImage im = createImage(I.width,I.height,RGB);
   PImage img = createImage(I.width,I.height,RGB);
   
   float c = 255.0/log(256);
   for(int u=0; u<im.width; u++){
      for(int v=0; v<im.height; v++){
           im.set(u,v,color(c*log(1.0+sqrt(pow(R[u][v],2)+pow(Im[u][v],2)))));
           img.set(u,v,color(c*log(1.0+atan((Im[u][v]/R[u][v])))));
      }
   }
   
   im.resize(r1,r1);
   translation(im);
   
   im.resize(r,r);
   rDFT(im);
   im.resize(r1,r1);
   image(im,128,0);
   
   img.resize(r1,r1);
   image(img,256,0);
}

void DFT(PImage I){
    for(int u=0; u<I.width; u++){
     for(int v=0; v<I.height; v++){
       for(int x=0; x<I.width; x++){
          for(int y=0; y<I.height; y++){
              R[u][v] += red(I.get(x,y)) * cos(2.0*PI*(1.0*u*x/I.width + 1.0*v*y/I.height));
              Im[u][v] += red(I.get(x,y)) * (-sin(2.0*PI*(1.0*u*x/I.width + 1.0*v*y/I.height)));
          }
       }
       R[u][v] /= (float)(I.width*I.height);
       Im[u][v] /= (float)(I.width*I.height);
     }
   }
}

void rDFT(PImage im){
  float sum = 0;
   float co = 0;
   float si = 0;
   for(int u=0; u<im.width; u++){
     for(int v=0; v<im.height; v++){
       sum = 0;
       for(int x=0; x<im.width; x++){
          for(int y=0; y<im.height; y++){
              co = cos(2.0*PI*(1.0*u*x/im.width + 1.0*v*y/im.height));
              si = sin(2.0*PI*(1.0*u*x/im.width + 1.0*v*y/im.height));
              sum+=((R[x][y]*co)+(-Im[x][y]*si))+((Im[x][y]*co)+(R[x][y]*si));
          }
       }
       im.set(u,v,color(sum));
     }
   }
}

void translation(PImage im){
   PImage A, B, C, D;
   A = im.get(0,0,im.width/2,im.height/2);
   B = im.get(im.width/2,0,im.width/2,im.height/2);
   C = im.get(0,im.height/2,im.width/2,im.height/2);
   D = im.get(im.width/2,im.height/2,im.width/2,im.height/2);
   image(D,0,0);
   image(C,im.width/2,0);
   image(B,0,im.height/2);
   image(A,im.width/2,im.height/2);
}
