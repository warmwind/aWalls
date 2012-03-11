mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
StorySchema = new Schema {
  storyNo       : String,
  title         : String,
  owner         : String,
  description   : String
}

Model = mongoose.model('Story', StorySchema)

class Story

  constructor: (@storyNo, @title, @owner, @description) ->
  create: (callback) ->
    model = new Model
    model.storyNo = @storyNo
    model.title = @title
    model.owner = @owner
    model.description = @description
    model.save (err) ->
      console.log err if err
      console.log "Story was successfully saved" unless err
    callback()

  @findAll: (callback) ->
    Model.find {}, (err, docs) ->
      callback docs

  @find: (id, callback) ->
    Model.findById id, (err, story) ->
      if (err) 
        console.log err
        res.send 'Post not found'
      else
        callback story

  @update: (id, req, callback) ->
    Model.update storyNo: req.param 'storyNo', {title: req.param('title'), owner: req.param('owner'), description: req.param('description')}, {}, (err, numAffected) ->
      if (err)
        console.log err
      else
        console.log "#{numAffected} row(s) affected"
        callback()

  @delete: (id, callback) ->
    Model.findById id, (err, story) ->
      if (err) 
        console.log err
        res.send 'Post not found'
      else
        story.remove (err) ->
          callback() 

exports.Story = Story
