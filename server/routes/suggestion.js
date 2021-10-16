var express = require('express');
var router = express.Router();
const mysql = require('mysql');


const connection =   mysql.createPool({
    user:'admin',
    password:'05751234',
    database: 'MMIS',
    host:'mmis.cip9531xqh6o.ap-northeast-2.rds.amazonaws.com',
    multipleStatements:true,

});


///////////////끝


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
			//console.log(newsql);
			connection.query(newsql,(error1, results1, fields1) => {
                //mybody = results1[0];
		//console.log(results1[0]);
		    		if(error){
				    res.send({"code" : -1});

		    		}
		    		else{
				    console.log(results1[0].militaryNumber);
				    var realnewsql = `select * from normaluser where militaryNumber = \'${results1[0].militaryNumber}\';`;
		        	    connection.query(realnewsql,(error1, results2, fields1) => {
					    if(error){
						res.send({"code" : -1});

					    }
					    else{
						var getcommentsql = `select * from suggestioncomments where suggestionid = ${suggestionid};`;
						connection.query(getcommentsql, (error, results3, fields) => {
						    if(error){
							res.send({"code" : -1});

						    }
						    else{
							//console.log(results3);
							var writerarray = [];
							var writersql = "";
							for(var i in results3){
							    writersql += `select * from adminuser where militaryNumber = \'${results3[i].militaryNumber}\';`;
							}
							console.log(writersql);
							connection.query(writersql, (error, results4, fields) =>{
							    if(error){
								console.log("여기서부터 안되냐?");
								res.send({"code" : -1});

							    }
							    else{
								var comment = [];
								var onecomment
								for(var i in results3){
								    //console.log(results3[i].content);
								    i//console.log(results4[i].writer);
								    onecomment = {"content": results3[i].content, "writer": results4[i][0]};
								    comment.push(onecomment);
								}
								var data = {"id" : results1[0].id, "title": results1[0].title, "content": results1[0].content, "writer": results2[0],"comments": comment, "createtime": results1[0].createtime, "updatetime": results1[0].updatetime};
		            					var noticeresponse = {"code" : 1, "msg" : "success", "data" : data};
		 	    					res.send(noticeresponse);


							    }
							})

						    }
						})
					    }
                        		})

		    		}
                	})

		    }
                })
        }
    })
   //var body = req.body;
});

router.get('/:id', async (req, res) => {
   // console.log(req.params, req.query, req.body);
   // console.log(req.body.content);
    var suggestionid = req.params.id;
    var writer = req.body.militaryNumber; ////////////////////////////////////////////////////
    var content = req.body.content;
    var newsql = `select * from suggestion where id = \'${suggestionid}\';`; 
			//console.log(newsql);
    connection.query(newsql,(error1, results1, fields1) => {
                //mybody = results1[0];
		//console.log(results1[0]);
				//
	if(error1){
	    res.send({"code" : -1});
 	}
	else{
				    //if(results1.length==0) res.send([]);
	    console.log(results1[0].militaryNumber);
	    var realnewsql = `select * from normaluser where militaryNumber = \'${results1[0].militaryNumber}\';`;
 	    connection.query(realnewsql,(error1, results2, fields1) => {
		if(error1){
		    res.send({"code" : -1});

		}
		else{
		    var getcommentsql = `select * from suggestioncomments where suggestionid = ${suggestionid};`;
		    connection.query(getcommentsql, (error, results3, fields) => {
			if(error){
			    res.send({"code" : -1});

			}
			else{
							//console.log(results3);
			    var writerarray = [];
			    var writersql = "";
			    for(var i in results3){
				writersql += `select * from adminuser where militaryNumber = \'${results3[i].militaryNumber}\';`;
			    }
			    console.log(writersql);
			    connection.query(writersql, (error, results4, fields) =>{
				if(error){
				    console.log("여기서부터 안되냐?");
				    res.send({"code" : -1});

				}
				else{
				    var comment = [];
				    var onecomment;
				    for(var i in results3){
								    //console.log(results3[i].content);
								    //console.log(results4[i].writer);
					onecomment = {"content": results3[i].content, "writer": results4[i][0]};
					comment.push(onecomment);
				    }
				    var data = {"id" : results1[0].id, "title": results1[0].title, "content": results1[0].content, "writer": results2[0],"comments": comment, "createtime": results1[0].createtime, "updatetime": results1[0].updatetime};
		            	    var noticeresponse = {"code" : 1, "msg" : "success", "data" : data};
		 	    	    res.send(noticeresponse);


				 }
			    })

			}
		    })
		}
	    })

	}
   })

   //var body = req.body;
});





router.get('/', async (req, res) => {
   // console.log(req.params, req.query, req.body);
   // console.log(req.body.content);
    var suggestionid = req.params.id;
    //console.log(suggestionid);
    var sql = `select * from suggestion;`;
    //console.log(sql);
    connection.query(sql, (error, results, fields) => {

	 if (error) {
            console.log(error);
	    res.send({"code" : -1});
        }
	else{
	    var suggestionidlist = [];
	    var sql1 = "";
	    for(var i in results){
		//console.log(results[i].id);
		suggestionidlist.push(results[i].id);
		sql1+= `select * from suggestioncomments where suggestionid = ${results[i].id};`;
	    }
	    //console.log(sql1);
	    connection.query(sql1, (error, results1, fields) => {

	 	if (error) {
                    console.log(error);
	    	    res.send({"code" : -1});
        	}
		else{
		    commentslist = [];
		    var admininformsql="";
		    for(var i in results1){
			for(var k in results1[i]){
			    //console.log(results1[i][k].content);
			    admininformsql+=  `select * from adminuser where militaryNumber = \'${results1[i][k].militaryNumber}\';`;
			}
			//console.log("-------------------------");
		    }
	    	}
		//console.log(admininformsql);
		connection.query(admininformsql, (error, results2, fields) =>{
		    if(error){

		    }
		    else{
			for(var i in results2){
			//    console.log(results2[i]);
			}
			var getnormalwritersql = "";
			for(var i in results){
			    //console.log(results[i].militaryNumber);
			    getnormalwritersql+= `select * from normaluser where militaryNumber = \'${results[i].militaryNumber}\';`;
			}
			//console.log(getnormalwritersql);
			connection.query(getnormalwritersql, (error, results3, fields)=>{
			    if(error){

			    }
			    else{
				var bigarray = [], commentswriter,id, title, content, writer, comments, updatetime, createtime, index=0;    
				for(var i in results){
				    id = results[i].id;
				    title = results[i].title;
				    content = results[i].content;
				    writer = results3[i];
				    comments = [];
				    createtime = results[i].createtime;
				    updatetime = results[i].updatetime;
				    //console.log(id);
				    //console.log(writer);
				    //console.log(results1[i]);
					
				    for(var k in results1[i]){
					commentswriter = results2[index];
					index++;
					//console.log(commentswriter);
					//console.log(results1[i][k]);
					comments.push({"content" : results1[i][k].content, "writer": commentswriter});
				    }
				    bigarray.push({"id":id, "title":title, "content":content, "writer": writer, "comments": comments, "createtime": createtime, "updatetime":updatetime});
				    console.log("---------------------------");
				}
				var response = {"code" : 1, "msg":"success", "data": bigarray};
				res.send(response);

			    }

			})



		    }
		})

            })
   	 }

    })
   //var body = req.body;
});


router.put('/:suggestionid/comment/:commentid', async (req, res) => {
   // console.log(req.params, req.query, req.body);
   // console.log(req.body.content);
    var suggestionid = req.params.suggestionid;
    var commentid = req.params.commentid;
    var writer = req.body.militaryNumber; ////////////////////////////////////////////////////
    var content = req.body.content;
	    //console.log("어렵노");
	    var mysql = `update suggestioncomments set content = \'${content}\' where suggestionid = ${suggestionid} and suggestionid_id = ${commentid} ;`; 
		console.log(mysql);
		connection.query(mysql,(error1, results0, fields1) => {
                //mybody = results1[0];
		//console.log(results1[0]);
		    if(error1){
			res.send({"code" : -2});	
		    }
		    else{
			console.log("업뎃 성공!");
			var newsql = `select * from suggestion where id = \'${suggestionid}\';`; 
			//console.log(newsql);
			connection.query(newsql,(error1, results1, fields1) => {
                //mybody = results1[0];
		//console.log(results1[0]);
		    		if(error1){
				    res.send({"code" : -1});

		    		}
		    		else{
				    console.log(results1[0].militaryNumber);
				    var realnewsql = `select * from normaluser where militaryNumber = \'${results1[0].militaryNumber}\';`;
		        	    connection.query(realnewsql,(error1, results2, fields1) => {
					    if(error1){
						res.send({"code" : -1});

					    }
					    else{
						var getcommentsql = `select * from suggestioncomments where suggestionid = ${suggestionid};`;
						connection.query(getcommentsql, (error, results3, fields) => {
						    if(error){
							res.send({"code" : -1});

						    }
						    else{
							//console.log(results3);
							var writerarray = [];
							var writersql = "";
							for(var i in results3){
							    writersql += `select * from adminuser where militaryNumber = \'${results3[i].militaryNumber}\';`;
							}
							console.log(writersql);
							connection.query(writersql, (error, results4, fields) =>{
							    if(error){
								console.log("여기서부터 안되냐?");
								res.send({"code" : -1});

							    }
							    else{
								var comment = [];
								var onecomment
								for(var i in results3){
								    //console.log(results3[i].content);
								    //console.log(results4[i].writer);
								    onecomment = {"content": results3[i].content, "writer": results4[i][0]};
								    comment.push(onecomment);
								}
								var data = {"id" : results1[0].id, "title": results1[0].title, "content": results1[0].content, "writer": results2[0],"comments": comment, "createtime": results1[0].createtime, "updatetime": results1[0].updatetime};
		            					var noticeresponse = {"code" : 1, "msg" : "success", "data" : data};
		 	    					res.send(noticeresponse);


							    }
							})

						    }
						})
					    }
                        		})

		    		}
                	})

		    }
                })
   //var body = req.body;
});

router.delete('/:id', async (req, res) => {
   // console.log(req.params, req.query, req.body);
   // console.log(req.body.content);
    var suggestionid = req.params.id;
    var writer = req.body.militaryNumber; ////////////////////////////////////////////////////
    var content = req.body.content;
    var newsql = `delete from suggestion where id = \'${suggestionid}\';`; 
			//console.log(newsql);
    connection.query(newsql,(error1, results1, fields1) => {
                //mybody = results1[0];
		//console.log(results1[0]);
				//
	if(error1){
	    res.send({"code" : -1});
 	}
	else{
		console.log("건의사항 삭제완료!");
	    var realnewsql = `delete from suggestioncomments where suggestionid = \'${suggestionid}\';`;
 	    connection.query(realnewsql,(error1, results2, fields1) => {
		if(error1){
		    res.send({"code" : -1});

		}
		else{
		    console.log("댓글삭제도 완료!");
		    res.send({"code" : 1, "msg": "success", "data": null});

		}
	    })

	}
   })

   //var body = req.body;
});


router.delete('/:suggestionid/comment/:commentid', async (req, res) => {
   // console.log(req.params, req.query, req.body);
   // console.log(req.body.content);
    var suggestionid = req.params.suggestionid;
    var commentid = req.params.commentid;
    var writer = req.body.militaryNumber; ////////////////////////////////////////////////////
    var content = req.body.content;
    var newsql = `delete from suggestioncomments where suggestionid = \'${suggestionid}\' and suggestionid_id = \'${commentid}\';`; 
			//console.log(newsql);
    connection.query(newsql,(error1, results1, fields1) => {
                //mybody = results1[0];
		//console.log(results1[0]);
				//
	if(error1){
	    res.send({"code" : -1});
 	}
	else{
		console.log("댓글 삭제완료!");
		res.send({"code" : 1, "msg": "success", "data": null});
	}
   })

   //var body = req.body;
});



module.exports = router;
