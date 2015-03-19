Template.sensorClient.helpers {
  "accelerometer" : ()->sensors.findOne()
  "webkit" : ()-> if window.webkit then return true else return false
}

Template.sensorClient.rendered = ()->
  clientPoint0 = $("#client-point-0")
  clientPoint1 = $("#client-point-1")
  clientPoint2 = $("#client-point-2")
  clientPoint3 = $("#client-point-3")

  sensorData = sensors.find()
  sensorData.observe {
    changed : (data)->

      clientPoint0.anima3d {rotateX:data.y+"deg", rotateY:data.x+"deg", rotateZ:"0deg"}, 50

      clientPoint1.anima3d {rotateX:data.y+"deg", rotateY:-data.x+"deg", rotateZ:"0deg"}, 50
      clientPoint2.anima3d {rotateX:-data.y+"deg", rotateY:data.x+"deg", rotateZ:"0deg"}, 50
      clientPoint3.anima3d {rotateX:data.y+"deg", rotateY:data.x+"deg", rotateZ:"0deg"}, 50


  }