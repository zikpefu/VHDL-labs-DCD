
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

//uchar3 to keep consistancy
typedef struct uchar3_t{
  unsigned char x, y, z;
  char nothing;
}uchar3;

uchar3 *readPPM(const char* filename, int *w, int *h){
  FILE *fp = fopen(filename, "rb");
  char headerInfo[10];
  int maxNum, i;


  fscanf(fp, "%s\n", headerInfo); //Should read a P
  fscanf(fp, "%d %d\n", w, h); //weight and height
  fscanf(fp, "%d\n", &maxNum); //Should be a 255

  uchar3 *newImage = malloc(*w * *h * sizeof(uchar3));
//scan in the char values
  for(i = 0; i < *w * *h; i++){
    fscanf(fp, "%c%c%c", &newImage[i].x, &newImage[i].y, &newImage[i].z);
  }

  fclose(fp);

  return newImage;

}

void writePPM(uchar3* Image, int w, int h, const char* fileName){
  FILE *out = fopen(fileName,"wb");
  //char out_header[10];
  int i;

  fprintf(out,"P6\n");
  fprintf(out,"%d %d\n", w, h);
  fprintf(out,"255\n");
  //output the values
  for(i = 0; i < w * h; i++){
    fprintf(out, "%c%c%c", Image[i].x,Image[i].y,Image[i].z);
  }
  fclose(out);
}



uchar3 * blur_image(uchar3 * pix, int w, int h){

          int xPix = 0;
          int yPix = 0;
          int zPix = 0;
          int i = 0;
          int a = 0;
          char Matrix[9] = {1, 2, 1, 2, 4, 2, 1, 2, 1};
          int offset[9] = {-1*w-1, -1 *w,-1 * w + 1, -1,0,1,w - 1, w, w + 1};
          uchar3 * edgePtr = malloc(w * h * sizeof(uchar3));
	//loop that goes through the entire pixel array
          for(i = 0; i < h * w; i++) {
              xPix = 0;
              yPix = 0;
              zPix = 0;
              //For loop to calcuate location for original array
              for(a = 0; a < 9; a++){
		//decide if the offset is valid
                if(offset[a] + i > 0 && offset[a] + i < w *h){
                  xPix += pix[i + offset[a]].x * Matrix[a];
                  yPix += pix[i + offset[a]].y * Matrix[a];
                  zPix += pix[i + offset[a]].z * Matrix[a];
                }
              }
              xPix /= 16;
              yPix /= 16;
              zPix /= 16;
              //Divide the pixel amount by 16
              edgePtr[i].x = xPix;
              edgePtr[i].y = yPix;
              edgePtr[i].z = zPix;
          }

  return edgePtr;
}
int main(int argc, char const *argv[]) {
  int w;
  int h;
  uchar3 * img = readPPM(argv[1], &w,&h);
//clock the time
  clock_t begin = clock();
  uchar3 * out_image = blur_image(img,w,h);
  clock_t end = clock();
  double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
  printf("Time is %.2f ms\n",time_spent * 1e3);
  writePPM(out_image, w, h, "output_image.ppm");
  return 0;
}
