module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffee:
      compile:
        files:
          'lib/main.js': 'lib/main.coffee'

    coffeelint:
      options:
        max_line_length:
          level: 'ignore'
        no_empty_param_list:
          level: 'error'
      src: ['lib/main.coffee']
      test: ['spec/*.coffee']

    shell:
      test:
        command: 'jasmine-focused --captureExceptions --coffee spec'
        options:
          stdout: true
          stderr: true
          failOnError: true

  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-shell')
  grunt.registerTask 'clean', -> require('rimraf').sync('lib/main.js')
  grunt.registerTask('lint', ['coffeelint'])
  grunt.registerTask('test', ['default', 'shell:test'])
  grunt.registerTask('default', ['lint', 'coffee'])
