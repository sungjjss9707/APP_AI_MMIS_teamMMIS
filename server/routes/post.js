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

router.get('/create',function(req, res, next) {
  connection.query("SELECT * FROM board;", function(err, result, fields){
    if(err){
      console.log(err);
      console.log("쿼리문에 오류가 있습니다.");
    }
    else{
      res.render('create', {
        results: result
      });
    }
  });
});

router.post('/create', function(req, res, next) {
  var body = req.body;

  connection.query("INSERT INTO board (writer,subject,content, ins_user_id, ins_date) VALUES (?, ?, ?, ?, ?)", [
     body.writer, body.subject, body.content, body.ins_user_id, now() 
  ], function(){
    res.redirect("/create");
  });
});

module.exports = router;
