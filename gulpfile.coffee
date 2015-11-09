"use strict"

gulp        = require 'gulp'
concat      = require 'gulp-concat'
header      = require 'gulp-header'
gutil       = require 'gulp-util'
stylus      = require 'gulp-stylus'
coffee      = require 'gulp-coffee'
browserSync = require 'browser-sync'
uglify      = require 'gulp-uglify'
pkg         = require './package.json'

path =
	buildCoffee   : './public/js'
	buildStylus   : './public/css'
	coffee        : ['./source/coffee/*.coffee']
	stylus        : ['./source/stylus/*.styl']

banner = [
	"/**"
	" * <%= pkg.name %> - <%= pkg.description %>"
	" * @version v<%= pkg.version %>"
	" * @link    <%= pkg.homepage %>"
	" * @author  <%= pkg.author.name %> (<%= pkg.author.site %>)"
	" * @license <%= pkg.license %>"
	" */"
	""
].join("\n")

gulp.task 'coffee', ->
	gulp.src path.coffee
		.pipe coffee().on 'error', gutil.log
		.pipe gulp.dest path.buildCoffee
		.pipe uglify mangle: true
		.pipe header banner, pkg: pkg

gulp.task 'stylus', ->
	gulp.src path.stylus
		.pipe stylus().on 'error', gutil.log
		.pipe gulp.dest path.buildStylus

gulp.task 'default', ->
	gulp.watch path.coffee, ['coffee']
	gulp.watch path.stylus, ['stylus']


