var express = require('express');
var router = express.Router();

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
