const createError = require('http-errors');
const express = require('express');
const path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
//var indexRouter = require('./routes');
var postRouter = require('./routes/post');
var getRouter = require('./routes/get');
var noticeRouter = require('./routes/notice');
var boardRouter = require('./routes/board');
var updateRouter = require('./routes/update');
var deleteRouter = require('./routes/delete');
var testRouter = require('./routes/test');
var adminjoinRouter = require('./routes/adminjoin');
var adminloginRouter = require('./routes/adminlogin');
var normaljoinRouter = require('./routes/normaljoin');
var normalloginRouter = require('./routes/normallogin');
var normalmodifyRouter = require('./routes/normalmodify');
var dietRouter = require('./routes/diet');
var menuRouter = require('./routes/menu');
var photoRouter = require('./routes/photo');
const bodyParser = require('body-parser');
const cors = require('cors');
var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
app.set('port', process.env.PORT || 8080);
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.json());
//app.use('/', indexRouter);
app.use('/notice', noticeRouter);
app.use('/adminjoin', adminjoinRouter);
app.use('/adminlogin', adminloginRouter);
app.use('/normaljoin', normaljoinRouter);
app.use('/normallogin', normalloginRouter);
app.use('/normalmodify', normalmodifyRouter);
app.use('/diet', dietRouter);
app.use('/menu', menuRouter);
app.use('/photo', photoRouter);
//app.use('/post', postRouter);
//app.use('/update', updateRouter);
//app.use('/delete', deleteRouter);
//app.use('/get', getRouter);
//app.use('/test', testRouter);
//app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cors()); 
// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

var server = app.listen(app.get('port'), function() {
	console.log('Express server listening on port ' + server.address().port);
});

module.exports = app;
