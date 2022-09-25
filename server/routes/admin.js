var express = require('express');
var router = express.Router();
const mysql = require('mysql');


const connection =   mysql.createPool({
    user:'admin',
    password:'05751234',
    database: 'MMIS',
    host:'mmis.cip9531xqh6o.ap-northeast-2.rds.amazonaws.com',
});

router.post('/', async (req, res) => {
    var sql = `insert into adminuser (name, militaryNumber, password, grade, belong, createtime, updatetime) value (\'${req.body.name}\', \'${req.body.militaryNumber}\',\'${req.body.password}\',\'${req.body.grade}\',\'${req.body.belong}\',now() ,now());`;
    connection.query(sql, (error, results, fields) => {

	 if (error) {
            console.log(error);
	    res.send({"code" : "-1"});
        }else{
	    var newsql = `select * from adminuser where militaryNumber = \'${req.body.militaryNumber}\';`; 
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

module.exports = router;
