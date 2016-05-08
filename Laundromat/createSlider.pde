void createSlider(String knobName, float rangeA, float rangeZ, float defValue, float posX, float posY, boolean runReset) {

  Slider control = cp5.addSlider(knobName)

    .setRange(rangeA, rangeZ)
    .setValue(defValue)
    .setPosition(posX, posY)
    .setDecimalPrecision(0)
    .setSize(width/2, 15)
    .setColorForeground(sliderForeground)
    .setColorBackground(sliderBackground)
    .setColorActive(sliderActive);

}