
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
    
    var sql = `insert into survey(title, content, seq, createdate, updatedate) values(\'${req.body.title}\', \'${req.body.explain}\', \'${req.body.seq}\', now(), now()); `;
    for(const question of req.body.count){
         sql +=  `insert into question(seq, title, type, isOptional, options, question_num) values(\'${req.body.seq}\', \'${question.text}\', \'${question.type}\', \'${question.isOptional}\', \'${question.options}\', ${question.id}); `;
    }
    
   
    
    connection.query(sql, (error, results, fields) => {
        
	 if (error) {
            console.log(error);
	    res.send(req.body.count);
        }else{
	    var noticeresponse = {"code" : 1, "msg" : "success", "data" : results};
		
		res.send(noticeresponse);
        }
    })
   //var body = req.body;
});




router.get('/', async (req, res) => {
    
    var sql = `select * from survey as s left join question as q on s.seq = q.seq;`;
    connection.query(sql, (error, results, fields) => {

	 if (error) {
            console.log(error);
	    res.send({"code" : -1});
        }else{
	    var noticeresponse = {"code" : 1, "msg" : "success", "data" : results[0]};
	
		res.send(noticeresponse);
        }
    })
   //var body = req.body;
});

router.get('/:id', async (req, res) => {
    
    var sql = `select * from survey where seq = ${req.params.id};`;
    connection.query(sql, (error, results, fields) => {

	 if (error) {
            console.log(error);
	    res.send({"code" : -1});
        }else{
	    var noticeresponse = {"code" : 1, "msg" : "success", "data" : results[0]};
	
		res.send(noticeresponse);
        }
    })
   //var body = req.body;
});

router.post('/answer', async (req, res) => {
    
    var sql = `insert into survey_answer(seq, answer, question_num, militarynumber, createdate) values(${req.body.seq}, \'${req.body.answer}\', \'${req.body.id}\', \'${req.body.militaryNumber}\', now());`;
    connection.query(sql, (error, results, fields) => {

	 if (error) {
            console.log(error);
	    res.send({"code" : -1});
        }else{
	    var noticeresponse = {"code" : 1, "msg" : "success", "data" : results[0]};
		
		res.send(noticeresponse);
        }
    })
   //var body = req.body;
});

router.delete('/:id', async (req, res) => {
    
    var sql = `delete from survey where seq = ${req.params.id};delete from survey_answer where seq = ${req.params.id};`;
    connection.query(sql, (error, results, fields) => {

	 if (error) {
            console.log(error);
	    res.send({"code" : -1});
        }else{
	    var noticeresponse = {"code" : 1, "msg" : "success", "data" : results[0]};
	
		res.send(noticeresponse);
        }
    })
   //var body = req.body;
});


module.exports = router;
