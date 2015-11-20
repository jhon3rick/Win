// Generated by CoffeeScript 1.10.0
(function() {
  "use strict";
  var banner, browserSync, closure, coffee, concat, gulp, gutil, header, jshint, notify, path, pkg, rename, stylus, uglify;

  gulp = require('gulp');

  concat = require('gulp-concat');

  header = require('gulp-header');

  gutil = require('gulp-util');

  stylus = require('gulp-stylus');

  coffee = require('gulp-coffee');

  browserSync = require('browser-sync');

  uglify = require('gulp-uglify');

  rename = require('gulp-rename');

  jshint = require('gulp-jshint');

  notify = require('gulp-notify');

  closure = require('gulp-closure-compiler-service');

  pkg = require('./package.json');

  path = {
    distCoffee: './dist/js',
    distStylus: './dist/css',
    buildCoffee: './build/js',
    buildStylus: './build/css',
    coffee: ['./source/coffee/*.coffee'],
    stylus: ['./source/stylus/*.styl'],
    jshint: ['./build/js/*.js'],
    modules: ['./source/coffee/Win.coffee', './source/coffee/Win.form.coffee', './source/coffee/Win.ajax.coffee', './source/coffee/Win.ini.coffee', './source/coffee/Win.desktop.coffee']
  };

  banner = ["/**", " * <%= pkg.name %> - <%= pkg.description %>", " * @version v<%= pkg.version %>", " * @link    <%= pkg.homepage %>", " * @author  <%= pkg.author.name %> (Twitter <%= pkg.author.twitter %> || email <%= pkg.author.mail %>)", " * @license <%= pkg.license %>", " */", ""].join("\n");

  gulp.task('coffee', function() {
    return gulp.src(path.coffee).pipe(coffee().on('error', gutil.log)).pipe(header(banner, {
      pkg: pkg
    })).pipe(gulp.dest(path.buildCoffee));
  });

  gulp.task('minCoffee', function() {
    return gulp.src(path.modules).pipe(concat('Win.min.js')).pipe(coffee().on('error', gutil.log)).pipe(uglify({
      mangle: true
    })).pipe(header(banner, {
      pkg: pkg
    })).pipe(gulp.dest(path.distCoffee));
  });

  gulp.task('stylus', function() {
    return gulp.src(path.stylus).pipe(stylus().on('error', gutil.log)).pipe(header(banner, {
      pkg: pkg
    })).pipe(gulp.dest(path.buildStylus));
  });

  gulp.task('minStylus', function() {
    return gulp.src(path.stylus).pipe(stylus({
      compress: true
    }).on('error', gutil.log)).pipe(header(banner, {
      pkg: pkg
    })).pipe(rename({
      extname: '.min.css'
    })).pipe(gulp.dest(path.distStylus));
  });

  gulp.task('closure', function() {
    return gulp.src(path.modules).pipe(concat('Win.min.js')).pipe(coffee().on('error', gutil.log)).pipe(closure()).pipe(header(banner, {
      pkg: pkg
    })).pipe(gulp.dest(path.distCoffee));
  });

  gulp.task("validate", function() {
    return gulp.src(path.jshint).pipe(jshint()).pipe(jshint.reporter('default')).pipe(notify({
      message: 'JSHints task complete'
    }));
  });

  gulp.task('default', function() {
    gulp.watch(path.coffee, ['coffee']);
    return gulp.watch(path.stylus, ['stylus']);
  });

  gulp.task('compile_watch', function() {
    gulp.watch(path.coffee, ['minCoffee']);
    return gulp.watch(path.stylus, ['minStylus']);
  });

  gulp.task('compile_google', ['closure', 'minStylus']);

  gulp.task('compile', ['minCoffee', 'minStylus']);

}).call(this);
