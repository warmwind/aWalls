{exec} = require 'child_process'
task 'build', 'Build project app.coffee to app.js', ->
  exec 'coffee --compile -o lib/ src/', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr

task 'spec', 'Run test in spec folder', ->
  invoke 'build'
  exec 'jasmine-node --color --verbose --coffee spec/', (err, stdout, stderr) ->
    console.log stdout + stderr

task 'restart', 'Compile and restart server', ->
  invoke 'build'
  exec 'node lib/app.js', (err, stdout, stderr) ->
    console.log stdout + stderr

