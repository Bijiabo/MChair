exports = this

this.siteName = "MicroScope"

Meteor.publish "posts",()->Posts.find()

Meteor.startup