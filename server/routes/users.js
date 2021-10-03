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
  console.log('GET ALL seq');
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


router.get('/:seq', async (req, res) => {
    console.log(`GET ALL ${req.params.seq}`);
  console.log(req.params, req.query);
    
    connection.query(`select * from board where seq = "${req.params.seq}";`, (error, results, fields) => {

        if (error) {
            console.log(error);
        }else{
            res.send(results[0]);
            console.log(results);
        }
    })
});

module.exports = router;
