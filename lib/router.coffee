Router.configure({
  "layoutTemplate":"layout"
  "loadingTemplate":"loading"
  "notFoundTemplate": "notFound"
  "waitOn":()->
    Meteor.subscribe("posts")
    Meteor.subscribe("sensors")
})

Router.route "/", "name":"postsList"

requireLogin = ()->
  if !Meteor.user()
    if Meteor.loggingIn() then @render(@loadingTemplate) else @render("accessDenied")
  else
    @next()

#posts
Router.route "/posts/:_id", "name":"postPage", "data":()->Posts.findOne @params._id
Router.route "/posts/:_id/edit", "name":"postEdit", "data":()->Posts.findOne @params._id
Router.route "/submit","name":"postSubmit"

#sensors
Router.route "/sensors/collect", "name":"sensorCollect", "data":()->sensors.findOne()
Router.route "/sensors/client", "name":"sensorClient", "data":()->sensors.findOne()

Router.onBeforeAction "dataNotFound", "only":"postPage"
Router.onBeforeAction requireLogin, "only":"postSubmit"