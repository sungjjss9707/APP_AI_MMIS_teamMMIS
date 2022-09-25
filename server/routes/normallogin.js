var express = require('express');
var router = express.Router();
const mysql = require('mysql');


const connection =   mysql.createPool({
    user:'admin',
    password:'05751234',
    database: 'MMIS',
    host:'mmis.cip9531xqh6o.ap-northeast-2.rds.amazonaws.com',
});

router.post('/', async (req, res) => {
  //  var sql = `insert into adminuser (militaryNumber, password) value (\'${req.body.militaryNumber}\',\'${req.body.password}\';`;
    var sql =  `select * from normaluser where militaryNumber = \'${req.body.militaryNumber}\' and password = \'${req.body.password}\';`; 
    connection.query(sql, (error, results, fields) => {
    if (error) {
        console.log(error);
	res.send({"code" : -1});
    }
    else{
        if(!results[0]){
            console.log(results[0]);
            res.send({"code" : -1});
        }    
        else{
	    var name = results[0].name;
    	    var grade = results[0].grade;
	    var belong = results[0].belong;
	    console.log(name);
            var newsql = `select * from normaluser where militaryNumber = \'${req.body.militaryNumber}\' and password = \'${req.body.password}\';`; 
	    console.log(newsql);
	    connection.query(newsql,(error1, results1, fields1) => {
		if(error){

		}
		else{
		   // console.log(results1);
		    var al_query = `select 계란류, 우유, 메밀, 땅콩, 대두, 밀, 고등어, 게, 새우, 돼지고기, 복숭아, 토마토, 아황산류, 호두, 닭고기, 쇠고기, 오징어, 조개류, 잣 from normaluserallergy where militaryNumber = \'${req.body.militaryNumber}\';`;
		    connection.query(al_query, (error, results4, fields) => {
			if(error){
			}
			else{
		            var data = {"id": results1[0].id,"name" : name, "militaryNumber": req.body.militaryNumber, "password": req.body.password, "grade" : grade, "belong": belong, "allergy" : results4[0]};
			    var noticeresponse = {"code" : 1, "msg" : "success", "data" : data};
	   	            res.send(noticeresponse);
	
          		}
	
		    })

		}
            })
        }
    }
    })
});


module.exports = router;
