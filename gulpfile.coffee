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
nib         = require 'nib'
closure     = require 'gulp-closure-compiler-service'
pkg         = require './package.json'

path =
	distCoffee  : './dist/js'
	distStylus  : './dist/css'
	buildCoffee : './example/js'
	buildStylus : './example/css'
	coffee      : ['./source/coffee/*.coffee']
	stylus      : ['./source/stylus/*.styl']
	jshint      : ['./build/js/*.js']
	modules     : ['./source/coffee/Win.coffee',
					'./source/coffee/Win.ini.coffee',
					'./source/coffee/Win.element.coffee',
					'./source/coffee/Win.css.coffee',
					'./source/coffee/Win.events.coffee',
					'./source/coffee/Win.query.coffee',
					'./source/coffee/Win.output.coffee',
					'./source/coffee/Win.script.coffee',

					'./source/coffee/Win.widget.coffee',
					'./source/coffee/Win.ajax.coffee',
					'./source/coffee/Win.form.coffee',
					'./source/coffee/Win.grilla.coffee']

git =
	distCoffee  : './example/js/winJs/js'
	distStylus  : './example/js/winJs/css'
	stylus      : ['./source_git/stylus/Win.styl',
					'./source_git/stylus/Win-theme-blue.styl']

	coffee      : ['./source_git/coffee/Win.coffee',
					'./source_git/coffee/Win.ini.coffee',
					'./source_git/coffee/Win.element.coffee',
					'./source_git/coffee/Win.css.coffee',
					'./source_git/coffee/Win.events.coffee',
					'./source_git/coffee/Win.query.coffee',
					'./source_git/coffee/Win.output.coffee',
					'./source_git/coffee/Win.form.coffee',
					'./source_git/coffee/Win.widget.coffee',
					'./source_git/coffee/Win.ajax.coffee']

	# modules     : ['./source/coffee/*.coffee']

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
		# .pipe coffee({bare: true}).on 'error', gutil.log
		.pipe coffee().on 'error', gutil.log
		.pipe header banner, pkg: pkg
		.pipe gulp.dest path.buildCoffee

gulp.task 'minCoffee', ->
	gulp.src path.modules
		.pipe(concat('Win.min.js'))
		.pipe coffee().on 'error', gutil.log
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
		.pipe stylus({ compress: true, use: nib() }).on 'error', gutil.log
		.pipe header banner, pkg: pkg
		.pipe(rename({extname: '.min.css'}))
		.pipe gulp.dest path.distStylus

gulp.task 'closure', ->
	gulp.src path.modules
		.pipe concat('Win.min.js')
		.pipe coffee().on 'error', gutil.log
		.pipe closure()
		.pipe header banner, pkg: pkg
		.pipe gulp.dest path.distCoffee


# TAREAS EJECUTADAS
gulp.task "validate", ->
     gulp.src path.jshint
        .pipe(jshint())
        .pipe(jshint.reporter('default'))
        .pipe(notify({ message: 'JSHints task complete' }));

# gulp.task 'default', ->
# 	gulp.watch path.coffee, ['coffee']
# 	gulp.watch path.stylus, ['stylus']

gulp.task 'default', ->
	# gulp.watch path.coffee, ['minCoffee']
	gulp.watch path.coffee, ['coffee']
	gulp.watch path.stylus, ['stylus']


gulp.task 'compile_watch', ->
	gulp.watch path.coffee, ['coffee']
	gulp.watch path.stylus, ['stylus']
	gulp.watch path.coffee, ['minCoffee']
	gulp.watch path.stylus, ['minStylus']

gulp.task 'coffee_watch', ->
	gulp.watch path.coffee, ['minCoffee']

gulp.task 'stylus_watch', ->
	gulp.watch path.stylus, ['minStylus']

gulp.task 'compile_google', ['closure','minStylus']
gulp.task 'compile', ['minCoffee','minStylus']

# GIT
gulp.task 'git_coffee', ->
	gulp.src git.coffee
		.pipe(concat('Win.min.js'))
		.pipe coffee().on 'error', gutil.log
		.pipe uglify mangle: true
		.pipe header banner, pkg: pkg
		.pipe gulp.dest git.distCoffee

gulp.task 'git_stylus', ->
	gulp.src git.stylus
		.pipe stylus({compress:true}).on 'error', gutil.log
		.pipe header banner, pkg: pkg
		.pipe(rename({extname: '.min.css'}))
		.pipe gulp.dest git.distStylus

gulp.task 'git', ['git_coffee','git_stylus']