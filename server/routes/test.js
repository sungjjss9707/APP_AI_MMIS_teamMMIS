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
    connection.query(`insert into board (writer, subject, content, ins_user_id, ins_date) value (\'${req.body.writer}\', \'${req.body.subject}\', \'${req.body.content}\', \'${req.body.ins_user_id}\',now());`, (error, results, fields) => {

        if (error) {
            console.log(error);
        }else{
            res.status(results).send(req.body);
            console.log(results);
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

module.exports = router;
