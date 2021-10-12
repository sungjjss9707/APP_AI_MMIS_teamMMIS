var express = require('express');
var router = express.Router();
const mysql = require('mysql');




const connection =   mysql.createPool({
    user:'admin',
    password:'05751234',
    database: 'MMIS',
    host:'mmis.cip9531xqh6o.ap-northeast-2.rds.amazonaws.com',
});


/* GET users listing. */



router.post('/', async (req, res) => {
    
    var sql = `insert into photo(photo, militaryNumber, createtime, updatetime) values(\'${req.body.photo}\', \'${req.body.militaryNumber}\', now(), now());`;
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

router.get('/', async (req, res) => {
    
    var sql = `select * from photo order by id limit 30;`;
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

router.get('/:id/comments', async (req, res) => {
    
    var sql = `insert into photocomments(photo_id, militaryNumber, createtime, updatetime) values(\'${req.params.id}\', \'${req.body.militaryNumber}\', now(), now());`;
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
