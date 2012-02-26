{exec} = require 'child_process'
task 'build', 'Build project app.coffee to app.js', ->
  exec 'coffee --compile -o lib/ ./*.coffee', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr
