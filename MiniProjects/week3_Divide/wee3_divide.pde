/*
  Collage Generator App : Divide
  by Minji Kil, 2022
*/

PImage img1, img2, img3;
int [][] bright;

void setup(){
   size(1024,720);

  // Load images
  img1 = loadImage("image1.jpg");
  img2 = loadImage("image2.jpg");
  img3 = loadImage("image3.jpg");
  img1.loadPixels();
  img2.loadPixels();
  img3.loadPixels();
  
  colorMode(HSB);
  
  bright = new int[img2.height][img2.width];
  
   // Extract color and brightness from image2
  for (int y = 0; y< img2.height; y++) {
    for (int x = 0; x< img2.width; x++) {
      color pixel = img2.pixels[y*img2.width + x];
      bright[y][x] = int(brightness(pixel));
    }
  }
  imageMode(CORNER);
  image(img1, 0, 0);
}

void draw(){
  // Draw background by rearranging image1
  for (int i=0; i<random(50,100); i++){
    image(get(int(random(width)), int(random(height)), int(random(50,300)), int(random(50,300))), random(width), random(height));
  }
  
  // Draw only the dark part of image2 using the stored value. 
  // At this time, image3 is used for the color.
  for (int y = 0; y < img2.height; y++) {
    for (int x = 0; x < img2.width; x++) {
      if (bright[y][x]<100){
        if (y*img3.width+x<img3.height*img3.width) {
          stroke(img3.pixels[y*img3.width+x],random(255));
        }
        point(x,y);
      }
    }
  }
  
  noLoop();
}
