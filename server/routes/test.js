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
router.get('/', async (req, res) => {
   // console.log(req.params, req.query);
    connection.query(`select * from board;`, (error, results, fields) => {

        if (error) {
            console.log(error);
        }else{
            res.send(results);
           // console.log(results);
        }
    })
});

router.get('/:seq', async (req, res) => {
   // console.log(`GET only ${req.params.seq}`);
    //console.log(req.params, req.query);
    console.log('get only 1');
    connection.query(`select * from board where seq = \'${req.params.seq}\';`, (error, results, fields) => {

        if (error) {
            console.log(error);
        }else{
            res.send(results[0]);
          //  console.log(results);
        }
    })
});


   //var body = req.body;
/*
router.post('/', async (req, res) => {
    console.log(`POST notice ${req.body}`);
    console.log(req.params, req.query, req.body);
   //var body = req.body;
	
    var sql = `insert into board (writer, subject, content, ins_user_id, ins_date) value (\'${req.body.writer}\', \'${req.body.subject}\', \'${req.body.content}\', \'${req.body.ins_user_id}\',now());`;
    connection.query(sql, (error, results, fields) => {

        if (error) {
            console.log(error);
        }else{
            //res.status(results).send(req.body);
            console.log(results);
	    //res.send({name : 'Minsu'});
	    res.send(req.body);
	    //res.send(results[0]);
	   // res.status(200).send('OK');
        }
    })
});
*/

router.post('/', async (req, res) => {
    console.log('post test');
    console.log(req.params, req.query, req.body);
    console.log(req.body.content);	
    var sql = `insert into board (writer, subject, content, ins_user_id, ins_date) value (\'${req.body.writer}\', \'${req.body.subject}\', \'${req.body.content}\', \'${req.body.ins_user_id}\',now());`;
    connection.query(sql, (error, results, fields) => {
         console.log(req.body.content);
         if (error) {
            console.log(error);
        }else{
            console.log(results);
	    
		
	    console.log(req.body.content);
	    var newsql = `select * from board where writer = \'${req.body.writer}\' and subject = \'${req.body.subject}\' and content = \'${req.body.content}\';`; 
		connection.query(newsql,(error1, results1, fields1) => {
                //mybody = results1[0];
		console.log(results1[0]);
		res.send(results1[0]);
            })
	    
	   // console.log(mybody);
 
	//    res.send(req.body);
	    //res.send(results[0]);
	   // res.status(200).send('OK');
        }
    })
   //var body = req.body;
});

router.put('/:seq', async (req, res) => {
    console.log(`put test`);
    //console.log(req.params, req.query, req.body);
   //var body = req.body;
    var new_subject = req.body.newsubject;
    var new_content = req.body.newcontent;
   // console.log(new_content);
    var sql = `UPDATE board SET subject =\'${new_subject}\', content =\'${new_content}\' where seq = \'${req.params.seq}\';`;
    connection.query(sql, (error, results, fields) => {
        var mybody;
        if (error) {
            console.log(error);
        }else{
	     ////////////////////////////////////////////////////////////////////////////////////////////////////////
	    var newsql = `select * from board where seq = \'${req.params.seq}\';`;
	    connection.query(newsql,(error1, results1, fields1) => {
                mybody = results1[0];
		console.log(mybody);
		res.send(mybody);
            })
	    console.log(mybody);
	    //res.send(mybody);
	    ////////////////////////////////////////////////////////////////////////////////////////////
            //res.send(req.body);
        }
    })
});

router.delete('/:seq', async (req, res) => {
    console.log(`delete test`);
    //console.log(req.params, req.query, req.body);
   //var body = req.body;
   // var new_content = req.body.newcontent;
   // console.log(new_content);
    var sql = "DELETE FROM board where seq = " + req.params.seq + ";";
    connection.query(sql, (error, results, fields) => {

        if (error) {
            console.log(error);
        }else{
            console.log(results);
	    res.send("delete success");
        }
    })
});

module.exports = router;
