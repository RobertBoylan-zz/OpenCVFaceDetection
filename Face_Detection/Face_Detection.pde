import gab.opencv.*; //<>//
import java.awt.Rectangle;
import java.awt.Point;

OpenCV opencv;
Rectangle[] faces, noses;
PImage src;

void setup() {
  size(1080, 720);

  src = loadImage("Christmas2017Party.jpg"); // load image
  src.resize(width, height); // resize image to fit canvas

  opencv = new OpenCV(this, src); // initialize OpenCV

  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); // load the haar-cascade for faces
  faces = opencv.detect(); // detect the faces in the image

  opencv.loadCascade(OpenCV.CASCADE_NOSE); // load the haar-cascade for noses
  noses = opencv.detect(); // detect the noses in the image
  
  surface.setTitle("Face Detection");
}

void draw() {
  image(src, 0, 0); // display original image

  noFill(); // don't fill shapes
  strokeWeight(3); // line thickness
  stroke(0, 255, 0); // green colour

  for (int i = 0; i < faces.length; i++) { // loop over all detected faces
    for (int j = 0; j < noses.length; j++) { // loop over all detected noses
      if (faces[i].contains(noses[j])) { // test whether the current detected nose is in the current detected face
        rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height); // draw rectangle around all detected faces
        break; // break out of inside for loop and go to next face
      }
    }
  }

  noLoop();
}

//boolean insideFaceBoundary(Rectangle face, Rectangle feature) {
//  if ((feature.x >= face.x) && ((feature.x + feature.width) <= (face.x + face.width)) && (feature.y >= face.y) && ((feature.y + feature.height) <= (face.y + face.height))) {
//    return true;
//  }
//  return false;
//}