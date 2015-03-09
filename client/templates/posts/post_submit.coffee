Template.postSubmit.events {
  "submit form" : (event)->
    event.preventDefault()

    post = {
      "url" : $(event.target).find('[name=url]').val()
      "title" : $(event.target).find('[name=title]').val()
    }

    errors = validatePost(post)
    if errors.title || errors.url then return Session.set "postSubmitErrors",errors

    Meteor.call "postInsert", post, (error,result)->
      if error then return throwError error.reason
      if result.postExists then throwError "This link has already been posted（该链接已经存在）"

      Router.go 'postPage',"_id":result._id
}

Template.postSubmit.created = () -> Session.set "postSubmitErrors",{}

Template.postSubmit.helpers {
  "errorMessage" : (field) -> Session.get("postSubmitErrors")[field]
  "errorClass" : (field) ->  if Session.get("postSubmitErrors")[field] then "has-error" else ""
}