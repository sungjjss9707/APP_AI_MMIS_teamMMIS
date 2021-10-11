var express = require('express');
var router = express.Router();
const mysql = require('mysql');
const multer = require("multer");
const path = require("path");

var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "public/images/");
  },
  filename: function (req, file, cb) {
    const ext = path.extname(file.originalname);
    cb(null, path.basename(file.originalname, ext) + "-" + Date.now() + ext);
  },
});

var upload = multer({ storage: storage });

const connection =   mysql.createPool({
    user:'admin',
    password:'05751234',
    database: 'MMIS',
    host:'mmis.cip9531xqh6o.ap-northeast-2.rds.amazonaws.com',
});


/* GET users listing. */

router.get('/', async (req, res) => {

    var sql = `select  (\'${req.body.title}\', \'${req.body.content}\',\'${writer}\',now() ,now());`;
    connection.query(sql, (error, results, fields) => {

	 if (error) {
            console.log(error);
	    res.send({"code" : "-1"});
        }else{
	    var newsql = `select * from board where writer = \'${writer}\' and title = \'${req.body.title}\' and content = \'${req.body.content}\';`; 
		console.log(newsql);
		connection.query(newsql,(error1, results1, fields1) => {
                //mybody = results1[0];
		//console.log(results1[0]);
		var noticeresponse = {"code" : "1", "msg" : "success", "data" : results1[0]};
		//res.send(results1[0]);
		res.send(noticeresponse);
            })
        }
    })
   //var body = req.body;
});

router.post('/', upload.single("image"), async (req, res) => {
    var image = `/images/${req.file.filename}`;
    var sql = `insert into photo(photo, createtime, updatetime) values(\'${image}\', now(), now());`;
    connection.query(sql, (error, results, fields) => {

	 if (error) {
            console.log(error);
	    res.send({"code" : "-1"});
        }else{
	    var noticeresponse = {"code" : "1", "msg" : "success", "data" : results1[0]};
		//res.send(results1[0]);
		res.send(noticeresponse);
        }
    })
   //var body = req.body;
});

module.exports = router;
