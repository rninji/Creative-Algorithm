void guiSetting(){
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  
  bugRatSl = cp5.addSlider("bugRatio");
  bugRatSl.setPosition(width-260, 10);
  bugRatSl.setSize(120, 20);
  bugRatSl.setRange(1, 2);
  bugRatSl.setColorCaptionLabel(color(255,0,0));
  bugRatSl.setCaptionLabel("Bug Ratio");
  bugRatSl.setValue(1.2);
  
  dotSizeSl = cp5.addSlider("dotSize");
  dotSizeSl.setPosition(width-260, 35);
  dotSizeSl.setSize(120, 20);
  dotSizeSl.setRange(0, 15);
  dotSizeSl.setColorCaptionLabel(color(255,0,0));
  dotSizeSl.setCaptionLabel("Dot Size");
  dotSizeSl.setValue(7);
  
  dotCntSl = cp5.addSlider("dotCnt");
  dotCntSl.setPosition(width-260, 60);
  dotCntSl.setSize(120, 20);
  dotCntSl.setRange(0, 50);
  dotCntSl.setColorCaptionLabel(color(255,0,0));
  dotCntSl.setCaptionLabel("Dot Count");
  dotCntSl.setValue(25);
  
  dotDisXSl = cp5.addSlider("dotDistanceX");
  dotDisXSl.setPosition(width-260, 85);
  dotDisXSl.setSize(120, 20);
  dotDisXSl.setRange(0.01, 1);
  dotDisXSl.setColorCaptionLabel(color(255,0,0));
  dotDisXSl.setCaptionLabel("Dot Distance X");
  dotDisXSl.setValue(0.2);
  
  dotDisYSl = cp5.addSlider("dotDistanceY");
  dotDisYSl.setPosition(width-260, 110);
  dotDisYSl.setSize(120, 20);
  dotDisYSl.setRange(0.01, 1);
  dotDisYSl.setColorCaptionLabel(color(255,0,0));
  dotDisYSl.setCaptionLabel("Dot Distance Y");
  dotDisYSl.setValue(0.2);
  
  dotRatSlX = cp5.addSlider("dotRatioX");
  dotRatSlX.setPosition(width-260, 135);
  dotRatSlX.setSize(120, 20);
  dotRatSlX.setRange(0.5, 1.5);
  dotRatSlX.setColorCaptionLabel(color(255,0,0));
  dotRatSlX.setCaptionLabel("Dot Ratio X");
  dotRatSlX.setValue(1);
  
  dotRatSlY = cp5.addSlider("dotRatioY");
  dotRatSlY.setPosition(width-260, 160);
  dotRatSlY.setSize(120, 20);
  dotRatSlY.setRange(0.5, 1.5);
  dotRatSlY.setColorCaptionLabel(color(255,0,0));
  dotRatSlY.setCaptionLabel("Dot Ratio Y");
  dotRatSlY.setValue(1);
  
  dotColSl = cp5.addColorPicker("dotColor");
  dotColSl.setPosition(width-260, 185);
  dotColSl.setSize(255, 20);
  dotColSl.setCaptionLabel("Dot Color");
  dotColSl.hideBar();
  dotColSl.setColorValue(color(0,0,0));
  
  backColSl = cp5.addColorPicker("backColor");
  backColSl.setPosition(width-260, 250);
  backColSl.setSize(255, 20);
  backColSl.setCaptionLabel("backColor");
  backColSl.setCaptionLabel("Back Color");
  backColSl.setColorValue(color(255,0,0));
}

void mousePressed(){
  if (mouseX>width-260&&mouseY<290){
    cam.setActive(false);
  }
  else {
    cam.setActive(true);
  }
}
