/** Compile in background on *.tex modification and notify on failure
 * Install nodejs
 * $ npm install -g grunt-cli
 * $ npm install
 * Ensure pdflatex is on PATH
 * $ grunt
 */

'use strict';

var notifier = require('node-notifier');


module.exports = function(grunt) {

require('load-grunt-tasks')(grunt);

var latexCallback = function(err, stdout, stderr, cb) {
  if(err) {
    var errs = stdout.split('! ');
    errs = errs[errs.length - 1].split('\n');
    notifier.notify({
      title: 'LaTeX build failed',
      message: errs[0]
    }, function() {
      cb(err, stdout, stderr, cb);
    });
  } else { 
    cb(err, stdout, stderr, cb);
  }
};


grunt.initConfig({
  watch: {
    default: {
      files: ['**/*.tex'],
      tasks: ['shell:pdflatex']
    },
    
   check: {
      files: ['**/*.tex'],
      tasks: ['shell:check']
    }

  },
  
  shell: {
    pdflatex: {
      command: 'make main',
      options: {
        callback: latexCallback
      }
    },
    
    check: {
      command: 'make no-output',	
      options: {
        callback: latexCallback
      }
    }
  
  }

});


grunt.registerTask('default', ['watch:default']);
grunt.registerTask('check', ['watch:check']);

};


