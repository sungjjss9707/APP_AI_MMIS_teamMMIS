var express = require('express');
var router = express.Router();
const mysql = require('mysql');


const connection =   mysql.createPool({
    user:'admin',
    password:'05751234',
    database: 'MMIS',
    host:'mmis.cip9531xqh6o.ap-northeast-2.rds.amazonaws.com',
});

router.get('/', async (req, res) => {
  console.log('GET all notice');
    console.log(req.params, req.query);
    connection.query(`select * from board`, (error, results, fields) => {

        if (error) {
            console.log(error);
        }else{
            res.send(results[0]);
            console.log(results);
        }
    })
});
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

router.get('/:seq', async (req, res) => {
    console.log(`GET all ${req.params.seq}`);
  console.log(req.params, req.query);
    
    connection.query(`select * from board where seq = \'${req.params.seq}\';`, (error, results, fields) => {

        if (error) {
            console.log(error);
        }else{
            res.send(results[0]);
            console.log(results);
        }
    })
});
router.put('/:seq', async (req, res) => {
    console.log(`put updeate ${req.body}`);
    //console.log(req.params, req.query, req.body);
   //var body = req.body;
    var new_content = req.body.newcontent;
    console.log(new_content);
    var sql = `UPDATE board SET content =\'${new_content}\' where seq = \'${req.params.seq}\';`;
    connection.query(sql, (error, results, fields) => {

        if (error) {
            console.log(error);
        }else{
            console.log(results);
	    res.send(req.body);
        }
    })
});

router.delete('/:seq', async (req, res) => {
    console.log(`delete which seg is ${req.params.seq}`);
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

