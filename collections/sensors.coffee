@sensors = new Mongo.Collection("sensors")

if sensors.find().count() == 0 && Meteor.isServer
  sensors.insert {
    gamma : 0
    beta : 0
    alpha : 0
  }

sensors.allow {
  "insert" : ()->true
  "update" : ()->true
}