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
    
    var sql = `insert into survey(title, content, createdate, updatedate) values(\'${req.body.title}\', \'${req.body.explain}\', now(), now());`;
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
    
    var sql = `select * from survey`;
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

router.get('/:id', async (req, res) => {
    
    var sql = `select * from survey where id = ${req.params.id};`;
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

router.post('/:id', async (req, res) => {
    
    var sql = `insert into survey_answer(survey_id, answer, militarynumber, createdate, updatedate) values(${req.params.id}, \'${req.body.answer}\', \'${req.body.militaryNumber}\', now(), now());`;
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

router.delete('/:id', async (req, res) => {
    
    var sql = `delete from survey where id = ${req.params.id};delete from survey_answer where survey_id = ${req.params.id};`;
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
