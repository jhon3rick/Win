"use strict"

gulp        = require 'gulp'
concat      = require 'gulp-concat'
header      = require 'gulp-header'
gutil       = require 'gulp-util'
stylus      = require 'gulp-stylus'
coffee      = require 'gulp-coffee'
browserSync = require 'browser-sync'
uglify      = require 'gulp-uglify'
rename      = require 'gulp-rename'
jshint      = require 'gulp-jshint'
notify      = require 'gulp-notify'
pkg         = require './package.json'

path =
	distCoffee  : './dist/coffee'
	distStylus  : './dist/stylus'
	buildCoffee : './build/js'
	buildStylus : './build/css'
	coffee      : ['./source/coffee/*.coffee']
	stylus      : ['./source/stylus/*.styl']
	jshint      : ['./build/js/*.js']

banner = [
	"/**"
	" * <%= pkg.name %> - <%= pkg.description %>"
	" * @version v<%= pkg.version %>"
	" * @link    <%= pkg.homepage %>"
	" * @author  <%= pkg.author.name %> (Twitter <%= pkg.author.twitter %> || email <%= pkg.author.mail %>)"
	" * @license <%= pkg.license %>"
	" */"
	""
].join("\n")

gulp.task 'coffee', ->
	gulp.src path.coffee
		.pipe coffee({bare: true}).on 'error', gutil.log
		.pipe header banner, pkg: pkg
		.pipe gulp.dest path.buildCoffee

gulp.task 'minCoffee', ->
	gulp.src path.coffee
		.pipe(concat('Win.min.js'))
		.pipe coffee({bare: true}).on 'error', gutil.log
		.pipe uglify mangle: true
		.pipe header banner, pkg: pkg
		.pipe gulp.dest path.distCoffee

gulp.task 'stylus', ->
	gulp.src path.stylus
		.pipe stylus().on 'error', gutil.log
		.pipe header banner, pkg: pkg
		.pipe gulp.dest path.buildStylus

gulp.task 'minStylus', ->
	gulp.src path.stylus
		.pipe stylus({compress:true}).on 'error', gutil.log
		.pipe header banner, pkg: pkg
		.pipe(rename({extname: '.min.css'}))
		.pipe gulp.dest path.distStylus

gulp.task "validate", ->
     gulp.src path.jshint
        .pipe(jshint())
        .pipe(jshint.reporter('default'))
        .pipe(notify({ message: 'JSHints task complete' }));

gulp.task 'default', ->
	gulp.watch path.coffee, ['coffee', 'minCoffee']
	gulp.watch path.stylus, ['stylus', 'minStylus']


