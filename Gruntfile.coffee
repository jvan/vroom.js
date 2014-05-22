module.exports = (grunt) ->
   grunt.initConfig
      coffee:
         options:
            join: true
         compile:
            files: 'public/js/vroom.js': ['src/*.coffee']
      copy:
         js:
            files:
               'public/js/vendor/jquery.min.js':    'bower_components/jquery/dist/jquery.min.js'
               'public/js/vendor/bootstrap.min.js': 'bower_components/bootstrap/dist/js/bootstrap.min.js'
               'public/js/vendor/gl-matrix-min.js': 'bower_components/gl-matrix/dist/gl-matrix-min.js'
               'public/js/vendor/numeric.js':       'bower_components/numericjs/src/numeric.js'
         
         css:
            files:
               'public/css/vendor/bootstrap.min.css': 'bower_components/bootstrap/dist/css/bootstrap.min.css'


      watch:
         coffeescript:
            files: 'src/*.coffee'
            tasks: ['coffee']

   grunt.loadNpmTasks 'grunt-contrib-coffee'
   grunt.loadNpmTasks 'grunt-contrib-copy'
   grunt.loadNpmTasks 'grunt-contrib-watch'

   grunt.registerTask 'default', ['coffee']

