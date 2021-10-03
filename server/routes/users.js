var express = require('express');
var router = express.Router();
const mysql = require('mysql');
const bodyParser = require('body-parser');

const connection =   mysql.createPool({
    user:'admin',
    password:'05751234',
    database: 'MMIS',
    host:'mmis.cip9531xqh6o.ap-northeast-2.rds.amazonaws.com',
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
/* GET users listing. */
router.get('/', async (req, res) => {
  console.log(req.params, req.query);
    
    connection.query(`select * from board`, (error, results, fields) => {

        if (error) {
            console.log(error);
        }else{
            // res.send({result: 'success'});
            console.log(results);
        }
    })
});

module.exports = router;
