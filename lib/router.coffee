Router.configure({
  "layoutTemplate":"layout"
  "loadingTemplate":"loading"
  "notFoundTemplate": "notFound"
  "waitOn":()->Meteor.subscribe("posts")
})

Router.route "/", "name":"postsList"

requireLogin = ()->
  if !Meteor.user()
    if Meteor.loggingIn() then @render(@loadingTemplate) else @render("accessDenied")
  else
    @next()

Router.route "/posts/:_id", "name":"postPage", "data":()->Posts.findOne @params._id
Router.route "/posts/:_id/edit", "name":"postEdit", "data":()->Posts.findOne @params._id
Router.route "/submit","name":"postSubmit"

Router.onBeforeAction "dataNotFound", "only":"postPage"
Router.onBeforeAction requireLogin, "only":"postSubmit"