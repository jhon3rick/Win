var gulp = require('gulp'),
    log = require('gulp-util').log,
    stylus = require('gulp-stylus'),
    coffee = require('gulp-coffee'),
    browserSync = require('browser-sync'),
  	uglify = require('gulp-uglify');

gulp.task('coffee', function() {
  gulp.src('./source/coffee/*.coffee')
    .pipe(coffee({bare: true, compress: true}).on('error', function(){
		console.log(err.name + " en " + err.plugin);
    }))
    .pipe(gulp.dest('public/js'))
});

gulp.task('stylus', function() {
  gulp.src('./source/stylus/*.styl')
    .pipe(stylus())
    // .pipe(stylus({compress: true}))
    .pipe(gulp.dest('public/css'))
});

gulp.task('uglify', function () {
  gulp.src('./public/js/*.js')
  .pipe(uglify())
  .pipe(gulp.dest('./public/js/min/'))
});

gulp.task('watch', function() {
	log('Watching files');
	gulp.watch('./source/**/*', ['build']);
});

gulp.task('browserSync', ['build'], function() {
  browserSync({
    server: {
      baseDir: './public'
    }
  });
});

gulp.task('clean', function() {
  gulp.src(['./public/assets', './public/index.html'], {read: false}).pipe(clean());
});

//define cmd line default task
gulp.task('script', ['coffee']);
gulp.task('build', ['script', 'uglify', 'stylus']);
gulp.task('produccion', ['build', 'watch', 'browserSync']);
gulp.task('default', ['coffee', 'stylus', 'watch']);
