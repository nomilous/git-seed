child_process = require 'child_process'
hound         = require 'hound'

docs = (after) ->
    console.log 'docs...'
    opts = ['src/*.coffee']
    docco = child_process.spawn './node_modules/.bin/docco', opts
    docco.stdout.pipe process.stdout
    docco.stderr.pipe process.stderr
    docco.on 'exit', -> after()

build = (after) ->
    console.log 'build...'
    options = ['-c','-b', '-o', 'lib', 'src']
    builder = child_process.spawn './node_modules/.bin/coffee', options
    builder.stdout.pipe process.stdout
    builder.stderr.pipe process.stderr
    builder.on 'exit', -> after()

runSpec = (fileOrFolder, after) ->
    console.log 'run test...'
    test_runner = child_process.spawn './node_modules/.bin/mocha', [
        '--colors',
        '--compilers', 
        'coffee:coffee-script', 
        fileOrFolder
    ]
    test_runner.stdout.pipe process.stdout
    test_runner.stderr.pipe process.stderr
    test_runner.on 'exit', -> after()

changed = (file) ->
    if match = file.match /(src|spec)\/(.+)(_spec)?.coffee/
        spec_file = 'spec/' + match[2] + '_spec.coffee'
        spec_file = file if match[1] == 'spec'
        console.log 'Running: ', spec_file
        runSpec spec_file, ->

watchSrcDir = ->
    console.log 'Watching ./src'
    watcher = hound.watch './src'
    watcher.on 'change', (file, stats) ->
        return unless file.match /\.coffee$/
        build -> changed file

watchSpecDir = ->
    console.log 'Watching ./spec'
    watcher = hound.watch './spec'
    watcher.on 'change', (file, stats) ->
        changed file


task 'dev', 'Run dev/spec', ->
    watchSpecDir()
    watchSrcDir()


task 'spec', 'Run all tests', -> 
    build -> runSpec './spec', ->


task 'build', 'Build', ->
    build ->

task 'doc', 'Docco build', ->
    docs -> 

