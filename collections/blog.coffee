@blogs = new Mongo.Collection("blogs")

if blogs.find().count() == 0 && Meteor.isServer
  blogs.insert {
    title:"Hello,world."
    content:"这里是第一篇Blog内容，很高兴与你相遇。",
    time:new Date()
  }

blogs.allow {
  "insert" : ()->true
  "update" : ()->true
}