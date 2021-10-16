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
	    var noticeresponse = {"code" : 1, "msg" : "success", "data" : results};
            res.send(noticeresponse);
           // console.log(results);
        }
    })
});

router.get('/:seq', async (req, res) => {
   // console.log(`GET only ${req.params.seq}`);
    //console.log(req.params, req.query);
    console.log('get only 1');
    connection.query(`select * from board where id = \'${req.params.seq}\';`, (error, results, fields) => {

        if (error) {
            console.log(error);
	    res.send({"code" : -1});
        }else{
	    var noticeresponse = {"code" : 1, "msg" : "success", "data" : results[0]};
            res.send(noticeresponse);
          //  console.log(results);
        }
    })
});



router.post('/', async (req, res) => {
   // console.log(req.params, req.query, req.body);
   // console.log(req.body.content);
    var writer = req.body.militaryNumber; ////////////////////////////////////////////////////
    var sql = `insert into suggestion (title, content,militaryNumber,createtime, updatetime) value (\'${req.body.title}\', \'${req.body.content}\',\'${writer}\',now() ,now());`;
    connection.query(sql, (error, results, fields) => {

	 if (error) {
            console.log(error);
	    res.send({"code" : -1});
        }else{
	    var newsql = `select * from suggestion where militaryNumber = \'${writer}\' and title = \'${req.body.title}\' and content = \'${req.body.content}\';`; 
		console.log(newsql);
		connection.query(newsql,(error1, results1, fields1) => {
                //mybody = results1[0];
		//console.log(results1[0]);
		    if(error){

		    }
		    else{
			var realnewsql = `select * from normaluser where militaryNumber = \'${writer}\';`;
		        connection.query(realnewsql,(error1, results2, fields1) => {
			    var data = {"id" : results1[0].id, "title": results1[0].title, "content": results1[0].content, "writer": results2[0],"comments": [], "createtime": results1[0].createtime, "updatetime": results1[0].updatetime};
		            var noticeresponse = {"code" : 1, "msg" : "success", "data" : data};
		 	    res.send(noticeresponse);
                        })

		    }
                })
        }
    })
   //var body = req.body;
});


router.post('/:id/comment', async (req, res) => {
   // console.log(req.params, req.query, req.body);
   // console.log(req.body.content);
    var suggestionid = req.params.id;
    var writer = req.body.militaryNumber; ////////////////////////////////////////////////////
    var content = req.body.content;
    var sql = `select * from suggestioncomments where suggestionid = \'${suggestionid}\';`;
    connection.query(sql, (error, results, fields) => {

	 if (error) {
            console.log(error);
	    res.send({"code" : -1});
        }else{
	    //console.log(results[0]);
	    //console.log(results.length);
	    var nextid;
	    if(results.length==0){
		nextid = 1;
	    }
	    else{
		var nextid = results[results.length-1].suggestionid_id+1;
	    }
	    console.log(nextid);
	    //console.log("어렵노");
	    var mysql = `insert into suggestioncomments value (${suggestionid}, ${nextid}, \'${writer}\', \'${content}\');`; 
		console.log(mysql);
		connection.query(mysql,(error1, results0, fields1) => {
                //mybody = results1[0];
		//console.log(results1[0]);
		    if(error){
			
		    }
		    else{
			console.log("인설트 성공!");
			var newsql = `select * from suggestion where id = \'${suggestionid}\';`; 
			console.log(newsql);
			connection.query(newsql,(error1, results1, fields1) => {
                //mybody = results1[0];
		//console.log(results1[0]);
		    		if(error){

		    		}
		    		else{
				    var realnewsql = `select * from normaluser where militaryNumber = \'${writer}\';`;
		        	    connection.query(realnewsql,(error1, results2, fields1) => {
			    		var data = {"id" : results1[0].id, "title": results1[0].title, "content": results1[0].content, "writer": results2[0],"comments": [], "createtime": results1[0].createtime, "updatetime": results1[0].updatetime};
		            		var noticeresponse = {"code" : 1, "msg" : "success", "data" : data};
		 	    		res.send(noticeresponse);
                        		})

		    		}
                	})

		    }
                })
        }
    })
   //var body = req.body;
});





router.put('/:seq', async (req, res) => {
    console.log(`put test`);
    //console.log(req.params, req.query, req.body);
   //var body = req.body;
    var new_title = req.body.title;
    var new_content = req.body.content;
   // console.log(new_content);
    var sql = `UPDATE board SET title =\'${new_title}\', updatetime = now(), content =\'${new_content}\' where id = \'${req.params.seq}\';`;
    connection.query(sql, (error, results, fields) => {
        var mybody;
        if (error) {
            console.log(error);
	    res.send({"code" : -1});
        }else{
	     ////////////////////////////////////////////////////////////////////////////////////////////////////////
	    var newsql = `select * from board where id = \'${req.params.seq}\';`;
	    connection.query(newsql,(error1, results1, fields1) => {
                mybody = results1[0];
	        var noticeresponse = {"code" : 1, "msg" : "success", "data" : results1[0]};

		console.log(mybody);
		res.send(noticeresponse);
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
    var sql = "DELETE FROM board where id = " + req.params.seq + ";";
    connection.query(sql, (error, results, fields) => {

        if (error) {
            console.log(error);
        }else{
            console.log(results);
            res.send({"code" : 1, "msg" : "success"});
	   // res.send("delete success");
        }
    })
});

module.exports = router;
