int exp = 6; //1:normal, 2:smile, 3:mad, 4:left wink, 5:right wink, 6:close eyes

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add(mouthHeight); 
  msg.add(mouthWidth);
  msg.add(eyeLeft);
  msg.add(eyeRight);
  msg.add(eyebrowLeft);
  msg.add(eyebrowRight);
  msg.add(jaw);
  woscP5.send(msg, dest);
}

// automatically called whenever osc message is received
int oscEvent(OscMessage m) {

  /* check if theOscMessage has the address pattern we are looking for. */
  if (m.checkAddrPattern("/wek/outputs")==true) {

    /* check if the typetag is the right one. */
    if (m.checkTypetag("f")) {

      exp = (int)m.get(0).floatValue();  // get the first osc argument
      //println(exp);

        if (exp == 1) {
          // neutral face
        } else if (exp == 2) {
          // smlie 
          
          sm++;
        } else if (exp == 3) {
          // mad 
          
          md++;
        } else if (exp == 4) {
          // left wink
         
          lw++;
        } else if (exp == 5) {
          //right wink
          
          rw++;
        } else if (exp == 6) {
          //close eyes
          
          cl++;
        } 
      }
      return exp;
    }
    return 0;
  }
