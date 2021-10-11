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
    var sql1 = `select * from adminuser where militaryNumber = \'${req.body.militaryNumber}\';`; 
    connection.query(sql1, (error, results, field) => {
    if(error){
        console.log(error);
        res.send({"code" : -1});
    }
    else{
	console.log(results[0]);
	if(results[0]){
	    res.send({"code" :2});
	}
	else{
	    connection.query(sql, (error, results, fields) => {

            if (error) {
                console.log(error);
	    	res.send({"code" : -1});
            }
	    else{
		var newsql = `select * from adminuser where militaryNumber = \'${req.body.militaryNumber}\';`; 
		console.log(newsql);
		connection.query(newsql,(error, results, fields) => {
                //mybody = results1[0];
		//console.log(results1[0]);
		var noticeresponse = {"code" : 1, "msg" : "success", "data" : results[0]};
		//res.send(results1[0]);
		    res.send(noticeresponse);
            	})
            }	
    	    })
	}
    }
    })

   //var body = req.body;
});


module.exports = router;
