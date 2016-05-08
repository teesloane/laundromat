void createKnob(String knobName, float rangeA, float rangeZ, float defValue, float posX, float posY, boolean runReset) {

  Knob control = cp5.addKnob(knobName)

    .setRange(rangeA, rangeZ)
    .setValue(defValue)
    .setPosition(posX, posY)
    .setDecimalPrecision(0)
    .setRadius(20)
    .setColorForeground(knobForeground)
    .setColorBackground(knobBackground)
    .setColorActive(knobActive)
    .setDragDirection(Knob.HORIZONTAL);

}