@Posts = new Mongo.Collection("posts")

if Posts.find().count() == 0 && Meteor.isServer
  Posts.insert {
    title: 'Introducing Telescope'
    url: 'http://sachagreif.com/introducing-telescope/'
  }

  Posts.insert {
    title: 'Meteor'
    url: 'http://meteor.com'
  }

  Posts.insert {
    title: 'The Meteor Book'
    url: 'http://themeteorbook.com'
  }

@validatePost = (post)->
  errors = {}
  if !post.title then errors.title = "请填写标题"
  if !post.url then errors.url = "请填写 URL"
  errors

Posts.allow {
  "update" : (userId, post) -> ownsDocument userId, post
  "remove" : (userId, post) -> ownsDocument userId, post
}

Posts.deny {
  "update" : (userId, post, fieldNames) -> _.without(fieldNames, "url", "title").length > 0
}

Posts.deny {
  "update" : (userId, post, fieldNames, modifier) ->
    errors = validatePost modifier.$set
    errors.title || errors.url
}


Meteor.methods {
  "postInsert" : (postAttributes)->
    check Meteor.userId(), String
    check postAttributes, {
      "title" : String,
      "url" : String
    }

    errors = validatePost(postAttributes)
    if errors.title || errors.url then throw new Meteor.Error "incalid-post","你必须为你的帖子填写 标题 和 URL"

    postWithSameLink = Posts.findOne "url":postAttributes.url
    if postWithSameLink then return {
      postExists: true
      _id: postWithSameLink._id
    }

    user = Meteor.user()
    post = _.extend postAttributes, {
      userId : user._id
      author : user.username
      submitted : new Date()
    }

    postId = Posts.insert post
    "_id":postId
}