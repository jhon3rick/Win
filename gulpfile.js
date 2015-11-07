var gulp = require('gulp'),
    log = require('gulp-util').log,
    stylus = require('gulp-stylus'),
    coffee = require('gulp-coffee'),
    browserSync = require('browser-sync'),
  	uglify = require('gulp-uglify');

gulp.task('ugly', function () {
  gulp.src('js/*.js')
  .pipe(uglify())
  .pipe(gulp.dest('./public/js/build/'))
});

gulp.task('scripts', function() {
  gulp.src('./source/coffee/*.coffee')
    .pipe(coffee({bare: true, compress: true}).on('error', function(){
		console.log(err.name + " en " + err.plugin);
    }))
    .pipe(gulp.dest('public/js'))
});

gulp.task('styles', function() {
  gulp.src('./source/stylus/*.styl')
    .pipe(stylus({compress: true}))
    .pipe(gulp.dest('public/css'))
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
gulp.task('compile', ['scripts']);
gulp.task('build', ['compile', 'ugly', 'styles']);
gulp.task('default', ['build', 'watch', 'browserSync']);