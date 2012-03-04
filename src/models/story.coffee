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
  create: ->
    model = new Model
    model.storyNo = @storyNo
    model.title = @title
    model.owner = @owner
    model.description = @description
    model.save (err) ->
      console.log err if err
      console.log "Story was successfully saved" unless err

  @findAll: (callback) ->
    Model.find {}, (err, docs) ->
      callback docs

exports.Story = Story