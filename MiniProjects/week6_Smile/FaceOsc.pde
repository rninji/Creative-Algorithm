public void found(int i) {
  found = i;
}

public void poseOrientation(float x, float y, float z) {
  poseOrientation.set(x, y, z);
}

public void mouthWidthReceived(float w) {
  mouthWidth = w;
}

public void mouthHeightReceived(float h) {
  mouthHeight = h;
}

public void eyeLeftReceived(float f) {
  eyeLeft = f;
}

public void eyeRightReceived(float f) {
  eyeRight = f;
}

public void eyebrowLeftReceived(float f) {
  eyebrowLeft = f;
}

public void eyebrowRightReceived(float f) {
  eyebrowRight = f;
}

public void jawReceived(float f) {
  jaw = f;
}
