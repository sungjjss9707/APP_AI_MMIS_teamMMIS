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
