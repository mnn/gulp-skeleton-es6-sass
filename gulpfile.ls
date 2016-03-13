require! {
  gulp
}
$ = (require \gulp-load-plugins)!

do ->
  c = $.util.colors
  $.util.log 'Basic', c.yellow('ES6 + Sass'), 'buildfile by', c.magenta(\monnef)

gulp.task \default, [\help]

gulp.task \help, $.taskListing

srcDir = \src
destDir = \build

sassGlob = srcDir + '/**/*.sass'
babelGlob = srcDir + '/**/*.js'
htmlGlob = srcDir + '/**/*.html'

gulp.task \sass, ->
  gulp.src sassGlob
    .pipe $.sass()
    .pipe gulp.dest destDir

gulp.task \babel, ->
  gulp.src babelGlob
    .pipe $.babel({presets:[\es2015]})
    .pipe gulp.dest destDir

gulp.task \html, ->
  gulp.src htmlGlob
    .pipe gulp.dest destDir

gulp.task \build, [\sass \babel \html]

gulp.task \watch, [\build], !->
  gulp.watch sassGlob, [\sass]
  gulp.watch babelGlob, [\babel]
  gulp.watch htmlGlob, [\html]

gulp.task \serve, [\watch], ->
  gulp.src destDir
    .pipe $.serverLivereload({
      +livereload
      +open
    })
