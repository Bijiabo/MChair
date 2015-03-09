Meteor.publish "posts",()->Posts.find()
Meteor.publish "sensors",()->sensors.find()

Meteor.startup