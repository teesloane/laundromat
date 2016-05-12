/* ========= Call this function to create a slider. ========== */

void createSlider(String knobName, float rangeA, float rangeZ, float defValue, float posX, float posY) {

  cp5.addSlider(knobName)

    .setRange(rangeA, rangeZ)
    .setValue(defValue)
    .setPosition(posX, posY)
    .setDecimalPrecision(0)
    .setSize(width/2, 10)
    .setColorForeground(sliderForeground)
    .setColorBackground(sliderBackground)
    .setColorActive(sliderActive);
}

void createInterface() {
  // create keyboard
  for (int i = 0; i < keyboard.length; i++) {
    keyboard[i] = new VKey(width/4 + i*width/24, height-height/10, 48+i, notes[i]);
  }

  // UI Knobs.
  float sliderY = 15;
  createSlider("Rotation", -10, 10, 1.5, width/2 - width/4, sliderY);
  createSlider("Gravity", 0, 20, 10, width/2 - width/4, sliderY*2);
  createSlider("Friction", 0, 1, 0, width/2 - width/4, sliderY*3);
  createSlider("Sides", 4, 10, 6, width/2 - width/4, sliderY*4);
  createSlider("SideLength", 40, 100, 70, width/2 - width/4, sliderY*5);
  createSlider("DeShape", 0, 90, 0, width/2 - width/4, sliderY*6);

  // midi device dropdown label:
Textlabel midiDevicesHeader = cp5.addTextlabel("midiDevices")
                    .setText("SELECT MIDI DEVICE:")
                    .setPosition(15,15)
                    .setColorValue(color(255))
                    .setFont(createFont("Arial", 11))
                    ;

  DropdownList outputs = cp5.addDropdownList("MidiDevice").setPosition(15, 45)
    .setColorForeground(sliderForeground)
    .setColorBackground(sliderBackground)
    .setBarHeight(20)
    .setSize(125, 1000);


  String[] availableOutputs = MidiBus.availableOutputs();
  for (int i = 0; i < availableOutputs.length; i++) {
    outputs.addItem(availableOutputs[i], i) ;
  }
}

/* ========= Class for creating a key in the keyboard ========== */

class VKey {

  /*
  * Change button color based on whether sharp or not
   * note: buttons must have text to differntiate.
   */
  CallbackListener cb;

  int keySize = 20;
  float x;
  float y;
  int midiNote;

  int whiteFg = color(230, 234, 144);
  int whiteBg = color(230, 234, 144);
  int whiteActive = color(210, 214, 124);

  int blackBg = (color(52, 152, 219));
  int blackFg = (color(32, 112, 202));
  int blackActive = color(70, 64, 74);

  VKey(float xPos, float yPos, int note, String id) {
    x = xPos;
    y = yPos;
    final int midiNote = note;

    cp5.addButton(id)
      .setPosition(x, y)
      .setSize(keySize, keySize)
      .setColorForeground(blackFg)
      .setColorBackground(blackBg)
      .setColorActive(blackActive)
      .addCallback(new CallbackListener() {
      void controlEvent(CallbackEvent theEvent) {
        switch(theEvent.getAction()) {
          case(ControlP5.ACTION_PRESSED):

          if (ballCount == maxBalls) {
            return;
          }

          if (ballCount <= maxBalls) {
            balls[ballCount] = new Ball(10, midiNote);

            ballCount += 1;
          }

          break;
        }
      }
    }
    );
  }
}