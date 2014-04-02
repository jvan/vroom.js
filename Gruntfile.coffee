module.exports = (grunt) ->
   grunt.initConfig
      coffee:
         options:
            join: true
         compile:
            files: 'public/js/vroom.js': ['src/*.coffee']

      watch:
         coffeescript:
            files: 'src/*.coffee'
            tasks: ['coffee']

   grunt.loadNpmTasks 'grunt-contrib-coffee'
   grunt.loadNpmTasks 'grunt-contrib-watch'

   grunt.registerTask 'default', ['coffee']

