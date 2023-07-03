package devices;

import cartago.INTERNAL_OPERATION;
import cartago.OPERATION;

import cartago.Artifact;
import cartago.ObsProperty;

public class HVAC extends Artifact {
  private double temperature;

  void init(double temp) {
    this.temperature = temp;
    defineObsProperty("state", "off");
    defineObsProperty("temperature", this.temperature);
    log("Temperature: " + getObsProperty("temperature").doubleValue());
  }

  @OPERATION
  void turn_on() {
    if (getObsProperty("state").stringValue().equals("off")) {
      getObsProperty("state").updateValue("on");
      this.execInternalOp("updateTemperatureProc", -1);
      log("HVAC on");
    }
  }

  @OPERATION
  void turn_off() {
    if (getObsProperty("state").stringValue().equals("on")) {
      getObsProperty("state").updateValue("off");
      log("HVAC off");
    }
  }

  @INTERNAL_OPERATION
  void updateTemperatureProc(double step) {
    ObsProperty temp = getObsProperty("temperature");
    ObsProperty state = getObsProperty("state");
    while (!state.stringValue().equals("off")) {
      temp.updateValue(temp.doubleValue() + step);
      log("Temperature: " + temp.doubleValue());
      this.await_time(300);
    }
  }
}