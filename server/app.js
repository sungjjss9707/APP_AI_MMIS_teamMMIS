const createError = require('http-errors');
const express = require('express');
const path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
//var indexRouter = require('./routes');/////////////////////////////
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
var surveyRouter = require('./routes/survey');
var dietRouter = require('./routes/diet');
var menuRouter = require('./routes/menu');
var photoRouter = require('./routes/photo');
var noteatingRouter = require('./routes/noteating');
var suggestionRouter = require('./routes/suggestion');
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
app.use(cors());
//app.use('/', indexRouter);
app.use('/notice', noticeRouter);
app.use('/adminjoin', adminjoinRouter);
app.use('/adminlogin', adminloginRouter);
app.use('/normaljoin', normaljoinRouter);
app.use('/normallogin', normalloginRouter);
app.use('/normalmodify', normalmodifyRouter);
app.use('/noteating', noteatingRouter);
app.use('/survey', surveyRouter);
app.use('/diet', dietRouter);
app.use('/menu', menuRouter);
app.use('/photo', photoRouter);
app.use('/suggestion', suggestionRouter);
//app.use('/post', postRouter);
//app.use('/update', updateRouter);
//app.use('/delete', deleteRouter);
//app.use('/get', getRouter);
//app.use('/test', testRouter);
//app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));


app.use(cors()); 

var server = app.listen(app.get('port'), function() {
	console.log('Express server listening on port ' + server.address().port);
});

module.exports = app;
