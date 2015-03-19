Template.sensorCollect.helpers {
  "accelerometer" : ()->sensors.findOne()
}

@updateAcceleormeter = (acceleormeter)->
  oldData = sensors.findOne()
  sensors.update oldData._id, $set:acceleormeter, (error)->
    if error then throwError error.reason
