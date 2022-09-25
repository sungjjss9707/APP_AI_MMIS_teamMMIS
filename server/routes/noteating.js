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



router.get('/:year/:month/:day/', async (req, res) => {
        var month = req.params.month;
	var year = req.params.year;
	var day = req.params.day;
	var diet_query = `select * from noteating where year = \'${year}\' and month = \'${month}\' and day = \'${day}\';`;
    	connection.query(diet_query, (error, results, fields) => {
        if (error) {
        	console.log(error);
	  			res.send({"code" : -1});
				}	
				else{
					if(results.length==0){
						res.send({"code": -1});
					}
					else{
						console.log(results);
					}
    		}
   	})
});


router.put('/:year/:month/:day/:time/', async (req, res) => {
        var month = req.params.month;
	var year = req.params.year;
	var day = req.params.day;
	var time = req.params.time;
	var update_query = `update noteating set numofallpeople = \'${req.body.totalNumberOfPeople}\' where year = \'${year}\' and month = \'${month}\' and day = \'${day}\' and time = \'${time}\';`;
    	connection.query(update_query, (error, results0, fields) => {
        if (error) {
        	console.log(error);
	  			res.send({"code" : -1});
				}
				else{
					var diet_query = `select * from noteating where year = \'${year}\' and month = \'${month}\' and day = \'${day}\'and time = \'${time}\';`;
    	connection.query(diet_query, (error, results, fields) => {
        if (error) {
        	console.log(error);
	  		res.send({"code" : -1});
		}	
		else{
			
	    		var dutyarray=[], vacationarray=[], go_outarray=[], workarray=[], etcarray = [];
			dutyarray = results[0].duty.split(',');
			vacationarray = results[0].vacation.split(',');
			go_outarray = results[0].go_out.split(',');
			workarray = results[0].work.split(',');
			etcarray = results[0].etc.split(',');
			duty = [];
			vacation = [];
			go_out= [];
			work = [];
			etc = [];
			var dutysql="", goonbeon;
			for(var i in dutyarray){
				goonbeon = dutyarray[i];
				dutysql+=`select * from normaluser where militaryNumber = \'${goonbeon}\';`;
			}
			if(dutysql=="") dutysql = `select * from normaluser where militaryNumber = '-1';`;
			connection.query(dutysql, (error, results1, fields) => {
        			if (error) {
        				console.log(error);
	  				res.send({"code" : -1});
				}	
				else{
					if(dutyarray.length!=1){
						for(var i in dutyarray){
							duty.push(results1[i][0]);
						}
					}
					else if(dutyarray[0]!=''){
						duty.push(results1[0]);
					}
					var vacationsql="";
					
					for(var i in vacationarray){
						vacationsql+=`select * from normaluser where militaryNumber = \'${vacationarray[i]}\';`;
					}
					
					if(vacationsql=="") vacationsql = `select * from normaluser where militaryNumber = '-1';`;
					connection.query(vacationsql, (error, results2, fields) => {
        				if (error) {
        					console.log(error);
	  						res.send({"code" : -1});
						}	
						else{
								console.log(dutyarray);
								console.log(vacationarray);
								console.log(vacationarray.length);
								if(vacationarray.length!=1){
									for(var i in vacationarray){
										vacation.push(results2[i][0]);
									}
								}
								else if(vacationarray[0]!=''){
									vacation.push(results2[0]);
								}
							var go_outsql="";
							for(var i in go_outarray){
								go_outsql+=`select * from normaluser where militaryNumber = \'${go_outarray[i]}\';`;
							}
 							if(go_outsql=="") go_outsql = `select * from normaluser where militaryNumber = '-1';`;
							connection.query(go_outsql, (error, results3, fields) => {
        						if (error) {
        							console.log(error);
	  								res.send({"code" : -1});
								}	
								else{
									if(go_outarray.length!=1){
										for(var i in go_outarray){
											go_out.push(results3[i][0]);
										}
									}
									else if(go_outarray[0]!=''){
										go_out.push(results3[0]);
									}

									var worksql="";
									for(var i in workarray){
										worksql+=`select * from normaluser where militaryNumber = \'${workarray[i]}\';`;
									}
					
			//console.log(dutysql);
									if(worksql=="") worksql = `select * from normaluser where militaryNumber = '-1';`;
									connection.query(worksql, (error, results4, fields) => {
        								if (error) {
        									console.log(error);
	  										res.send({"code" : -1});
										}	
										else{
											if(workarray.length!=1){
												for(var i in workarray){
													work.push(results4[i][0]);
												}
											}
											else if(workarray[0]!=''){
												work.push(results4[0]);
											}

											var etcsql="";
											for(var i in etcarray){
												etcsql+=`select * from normaluser where militaryNumber = \'${etcarray[i]}\';`;
											}
										  
											if(etcsql=="") etcsql = `select * from normaluser where militaryNumber = '-1';`;
											console.log(etcsql);
											connection.query(etcsql, (error, results5, fields) => {
        										if (error) {
        											console.log(error);
	  												res.send({"code" : -1});
												}	
												else{
													//console.log(etcarray[0]);
													console.log(results1);
													console.log(results5);
													if(etcarray.length!=1){
														for(var i in etcarray){
															//console.log(results5[i][0]);
															etc.push(results5[i][0]);
														}
													}
													else if(etcarray[0]!=''){
														etc.push(results5[0]);
													}
													console.log(etc);

					//								console.log(results5);
													var reason = {"당직": duty, "휴가": vacation, "외출": go_out, "근무": work, "기타": etc};
													//console.log(results5.length);
														data = {"id" : results[0].id, "totalNumberOfPeople": results[0].numofallpeople, "reason" : reason};
													//res.send(reason);
														response = {"code":1, "msg":"success", "data": data};
														res.send(response);
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

				}
   	})
});



router.post('/:year/:month/:day/:time', async (req, res) => {
        var month = req.params.month;
	var year = req.params.year;
	var day = req.params.day;
	var time = req.params.time;
	var month = req.params.month;
  var mn = req.body.militaryNumber;
	var find_query = `select * from noteating where year = \'${year}\' and month = \'${month}\' and day = \'${day}\'and time = \'${time}\';`;
    	connection.query(find_query, (error, results, fields) => {
        if (error) {
        	console.log(error);
	  			res.send({"code" : -1});
				}	
				else{
					var modifynum = String(Number(results[0].numofallpeople)+1);
					var newreason = req.body.reason;
					var neweng;
					console.log(newreason);
					console.log("씨발");
					var originreason;
					var modifyreason = "";
					if(newreason == "당직"){
						originreason = results[0].duty;	
						neweng = 'duty';
					}
					else if(newreason == "휴가"){
						originreason = results[0].vacation;	
						neweng = 'vacation';

					}
					else if(newreason == "외출"){
						originreason = results[0].go_out;
						neweng = 'go_out';

					}
					else if(newreason == "근무"){
						originreason = results[0].work;	
							neweng = 'work';

					}
					else{
						originreason = results[0].etc;	
									neweng = 'etc';
					}
					if(originreason.length<1) modifyreason = mn;
					else	modifyreason = originreason+","+mn;
					var newsql = `update noteating set ${neweng} = \'${modifyreason}\', numofallpeople = \'${modifynum}\' where year = \'${year}\' and month = \'${month}\' and day = \'${day}\'and time = \'${time}\';`;
					console.log(newsql);
					connection.query(newsql, (error, results, fields) => {
						if(error){
							console.log(error);
							res.send({"code":-1});
						}
						else{
							var realnewsql = `select * from noteating where year = \'${year}\' and month = \'${month}\' and day = \'${day}\'and time = \'${time}\';`;
							connection.query(realnewsql,(error, results, fields) => {
								if(error){

								}
								else{
									var dutyarray=[], vacationarray=[], go_outarray=[], workarray=[], etcarray = [];
			dutyarray = results[0].duty.split(',');
			vacationarray = results[0].vacation.split(',');
			go_outarray = results[0].go_out.split(',');
			workarray = results[0].work.split(',');
			etcarray = results[0].etc.split(',');
			duty = [];
			vacation = [];
			go_out= [];
			work = [];
			etc = [];
			var dutysql="", goonbeon;
			for(var i in dutyarray){
				goonbeon = dutyarray[i];
				dutysql+=`select * from normaluser where militaryNumber = \'${goonbeon}\';`;
			}
			if(dutysql=="") dutysql = `select * from normaluser where militaryNumber = '-1';`;
			connection.query(dutysql, (error, results1, fields) => {
        			if (error) {
        				console.log(error);
	  				res.send({"code" : -1});
				}	
				else{
					if(dutyarray.length!=1){
						for(var i in dutyarray){
							duty.push(results1[i][0]);
						}
					}
					else if(dutyarray[0]!=''){
						duty.push(results1[0]);
					}
					var vacationsql="";
					
					for(var i in vacationarray){
						vacationsql+=`select * from normaluser where militaryNumber = \'${vacationarray[i]}\';`;
					}
					
					if(vacationsql=="") vacationsql = `select * from normaluser where militaryNumber = '-1';`;
					connection.query(vacationsql, (error, results2, fields) => {
        				if (error) {
        					console.log(error);
	  						res.send({"code" : -1});
						}	
						else{
								console.log(dutyarray);
								console.log(vacationarray);
								console.log(vacationarray.length);
								if(vacationarray.length!=1){
									for(var i in vacationarray){
										vacation.push(results2[i][0]);
									}
								}
								else if(vacationarray[0]!=''){
									vacation.push(results2[0]);
								}
							var go_outsql="";
							for(var i in go_outarray){
								go_outsql+=`select * from normaluser where militaryNumber = \'${go_outarray[i]}\';`;
							}
 							if(go_outsql=="") go_outsql = `select * from normaluser where militaryNumber = '-1';`;
							connection.query(go_outsql, (error, results3, fields) => {
        						if (error) {
        							console.log(error);
	  								res.send({"code" : -1});
								}	
								else{
									if(go_outarray.length!=1){
										for(var i in go_outarray){
											go_out.push(results3[i][0]);
										}
									}
									else if(go_outarray[0]!=''){
										go_out.push(results3[0]);
									}

									var worksql="";
									for(var i in workarray){
										worksql+=`select * from normaluser where militaryNumber = \'${workarray[i]}\';`;
									}
					
			//console.log(dutysql);
									if(worksql=="") worksql = `select * from normaluser where militaryNumber = '-1';`;
									connection.query(worksql, (error, results4, fields) => {
        								if (error) {
        									console.log(error);
	  										res.send({"code" : -1});
										}	
										else{
											if(workarray.length!=1){
												for(var i in workarray){
													work.push(results4[i][0]);
												}
											}
											else if(workarray[0]!=''){
												work.push(results4[0]);
											}

											var etcsql="";
											for(var i in etcarray){
												etcsql+=`select * from normaluser where militaryNumber = \'${etcarray[i]}\';`;
											}
										  
											if(etcsql=="") etcsql = `select * from normaluser where militaryNumber = '-1';`;
											console.log(etcsql);
											connection.query(etcsql, (error, results5, fields) => {
        										if (error) {
        											console.log(error);
	  												res.send({"code" : -1});
												}	
												else{
													//console.log(etcarray[0]);
													console.log(results1);
													console.log(results5);
													if(etcarray.length!=1){
														for(var i in etcarray){
															//console.log(results5[i][0]);
															etc.push(results5[i][0]);
														}
													}
													else if(etcarray[0]!=''){
														etc.push(results5[0]);
													}
													console.log(etc);

					//								console.log(results5);
													var reason = {"당직": duty, "휴가": vacation, "외출": go_out, "근무": work, "기타": etc};
													//console.log(results5.length);
														data = {"id" : results[0].id, "totalNumberOfPeople": results[0].numofallpeople, "reason" : reason};
													//res.send(reason);
														response = {"code":1, "msg":"success", "data": data};
														res.send(response);
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



								}

							})
		
    		}
   	})
});


router.delete('/:year/:month/:day/:time', async (req, res) => {
        var month = req.params.month;
	var year = req.params.year;
	var day = req.params.day;
	var time = req.params.time;
	var month = req.params.month;
  var mn = req.body.militaryNumber;
	var find_query = `select * from noteating where year = \'${year}\' and month = \'${month}\' and day = \'${day}\'and time = \'${time}\';`;
    	connection.query(find_query, (error, results, fields) => {
        if (error) {
        	console.log(error);
	  			res.send({"code" : -1});
				}	
				else{
					var modifynum = String(Number(results[0].numofallpeople)-1);
					var newreason = req.body.reason;
					var neweng;
					var originreason;
					var modifyreason = "";
					if(newreason == "당직"){
						originreason = results[0].duty;	
						neweng = 'duty';
					}
					else if(newreason == "휴가"){
						originreason = results[0].vacation;	
						neweng = 'vacation';

					}
					else if(newreason == "외출"){
						originreason = results[0].go_out;
						neweng = 'go_out';

					}
					else if(newreason == "근무"){
						originreason = results[0].work;	
							neweng = 'work';

					}
					else{
						originreason = results[0].etc;	
									neweng = 'etc';
					}
					var cutyeejeonreason = originreason.split(',');
					if(cutyeejeonreason.length==1){
						modifyreason = "";
					}
					else{
						for(var i in cutyeejeonreason){
							if(cutyeejeonreason[i]!=mn){
								modifyreason+=cutyeejeonreason[i];
								modifyreason+=",";
							}
						}
						modifyreason = modifyreason.substring(0, modifyreason.length-1);
					}
					console.log("씨발로마");
					console.log(modifyreason);

					var newsql = `update noteating set ${neweng} = \'${modifyreason}\', numofallpeople = \'${modifynum}\' where year = \'${year}\' and month = \'${month}\' and day = \'${day}\'and time = \'${time}\';`;
					console.log(newsql);
					connection.query(newsql, (error, results, fields) => {
						if(error){
							console.log(error);
							res.send({"code":-1});
						}
						else{
							var realnewsql = `select * from noteating where year = \'${year}\' and month = \'${month}\' and day = \'${day}\'and time = \'${time}\';`;
							connection.query(realnewsql,(error, results, fields) => {
								if(error){

								}
								else{
									var dutyarray=[], vacationarray=[], go_outarray=[], workarray=[], etcarray = [];
			dutyarray = results[0].duty.split(',');
			vacationarray = results[0].vacation.split(',');
			go_outarray = results[0].go_out.split(',');
			workarray = results[0].work.split(',');
			etcarray = results[0].etc.split(',');
			duty = [];
			vacation = [];
			go_out= [];
			work = [];
			etc = [];
			var dutysql="", goonbeon;
			for(var i in dutyarray){
				goonbeon = dutyarray[i];
				dutysql+=`select * from normaluser where militaryNumber = \'${goonbeon}\';`;
			}
			if(dutysql=="") dutysql = `select * from normaluser where militaryNumber = '-1';`;
			connection.query(dutysql, (error, results1, fields) => {
        			if (error) {
        				console.log(error);
	  				res.send({"code" : -1});
				}	
				else{
					if(dutyarray.length!=1){
						for(var i in dutyarray){
							duty.push(results1[i][0]);
						}
					}
					else if(dutyarray[0]!=''){
						duty.push(results1[0]);
					}
					var vacationsql="";
					
					for(var i in vacationarray){
						vacationsql+=`select * from normaluser where militaryNumber = \'${vacationarray[i]}\';`;
					}
					
					if(vacationsql=="") vacationsql = `select * from normaluser where militaryNumber = '-1';`;
					connection.query(vacationsql, (error, results2, fields) => {
        				if (error) {
        					console.log(error);
	  						res.send({"code" : -1});
						}	
						else{
								console.log(dutyarray);
								console.log(vacationarray);
								console.log(vacationarray.length);
								if(vacationarray.length!=1){
									for(var i in vacationarray){
										vacation.push(results2[i][0]);
									}
								}
								else if(vacationarray[0]!=''){
									vacation.push(results2[0]);
								}
							var go_outsql="";
							for(var i in go_outarray){
								go_outsql+=`select * from normaluser where militaryNumber = \'${go_outarray[i]}\';`;
							}
 							if(go_outsql=="") go_outsql = `select * from normaluser where militaryNumber = '-1';`;
							connection.query(go_outsql, (error, results3, fields) => {
        						if (error) {
        							console.log(error);
	  								res.send({"code" : -1});
								}	
								else{
									if(go_outarray.length!=1){
										for(var i in go_outarray){
											go_out.push(results3[i][0]);
										}
									}
									else if(go_outarray[0]!=''){
										go_out.push(results3[0]);
									}

									var worksql="";
									for(var i in workarray){
										worksql+=`select * from normaluser where militaryNumber = \'${workarray[i]}\';`;
									}
					
			//console.log(dutysql);
									if(worksql=="") worksql = `select * from normaluser where militaryNumber = '-1';`;
									connection.query(worksql, (error, results4, fields) => {
        								if (error) {
        									console.log(error);
	  										res.send({"code" : -1});
										}	
										else{
											if(workarray.length!=1){
												for(var i in workarray){
													work.push(results4[i][0]);
												}
											}
											else if(workarray[0]!=''){
												work.push(results4[0]);
											}

											var etcsql="";
											for(var i in etcarray){
												etcsql+=`select * from normaluser where militaryNumber = \'${etcarray[i]}\';`;
											}
										  
											if(etcsql=="") etcsql = `select * from normaluser where militaryNumber = '-1';`;
											console.log(etcsql);
											connection.query(etcsql, (error, results5, fields) => {
        										if (error) {
        											console.log(error);
	  												res.send({"code" : -1});
												}	
												else{
													//console.log(etcarray[0]);
													console.log(results1);
													console.log(results5);
													if(etcarray.length!=1){
														for(var i in etcarray){
															//console.log(results5[i][0]);
															etc.push(results5[i][0]);
														}
													}
													else if(etcarray[0]!=''){
														etc.push(results5[0]);
													}
													console.log(etc);

					//								console.log(results5);
													var reason = {"당직": duty, "휴가": vacation, "외출": go_out, "근무": work, "기타": etc};
													//console.log(results5.length);
														data = {"id" : results[0].id, "totalNumberOfPeople": results[0].numofallpeople, "reason" : reason};
													//res.send(reason);
														response = {"code":1, "msg":"success", "data": data};
														res.send(response);
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



								}

							})
		
    		}
   	})
});







router.get('/:year/:month/:day/:time', async (req, res) => {
        var month = req.params.month;
	var year = req.params.year;
	var day = req.params.day;
	var time = req.params.time;
	var diet_query = `select * from noteating where year = \'${year}\' and month = \'${month}\' and day = \'${day}\'and time = \'${time}\';`;
    	connection.query(diet_query, (error, results, fields) => {
        if (error) {
        	console.log(error);
	  		res.send({"code" : -1});
		}	
		else{
			if(results.length==0) res.send({"code" : 1, "msg": "success", "data":[]});
			else{
	    		var dutyarray=[], vacationarray=[], go_outarray=[], workarray=[], etcarray = [];
			dutyarray = results[0].duty.split(',');
			vacationarray = results[0].vacation.split(',');
			go_outarray = results[0].go_out.split(',');
			workarray = results[0].work.split(',');
			etcarray = results[0].etc.split(',');
			duty = [];
			vacation = [];
			go_out= [];
			work = [];
			etc = [];
			var dutysql="", goonbeon;
			for(var i in dutyarray){
				goonbeon = dutyarray[i];
				dutysql+=`select * from normaluser where militaryNumber = \'${goonbeon}\';`;
			}
			if(dutysql=="") dutysql = `select * from normaluser where militaryNumber = '-1';`;
			connection.query(dutysql, (error, results1, fields) => {
        			if (error) {
        				console.log(error);
	  				res.send({"code" : -1});
				}	
				else{
					if(dutyarray.length!=1){
						for(var i in dutyarray){
							duty.push(results1[i][0]);
						}
					}
					else if(dutyarray[0]!=''){
						duty.push(results1[0]);
					}
					var vacationsql="";
					
					for(var i in vacationarray){
						vacationsql+=`select * from normaluser where militaryNumber = \'${vacationarray[i]}\';`;
					}
					
					if(vacationsql=="") vacationsql = `select * from normaluser where militaryNumber = '-1';`;
					connection.query(vacationsql, (error, results2, fields) => {
        				if (error) {
        					console.log(error);
	  						res.send({"code" : -1});
						}	
						else{
								console.log(dutyarray);
								console.log(vacationarray);
								console.log(vacationarray.length);
								if(vacationarray.length!=1){
									for(var i in vacationarray){
										vacation.push(results2[i][0]);
									}
								}
								else if(vacationarray[0]!=''){
									vacation.push(results2[0]);
								}
							var go_outsql="";
							for(var i in go_outarray){
								go_outsql+=`select * from normaluser where militaryNumber = \'${go_outarray[i]}\';`;
							}
 							if(go_outsql=="") go_outsql = `select * from normaluser where militaryNumber = '-1';`;
							connection.query(go_outsql, (error, results3, fields) => {
        						if (error) {
        							console.log(error);
	  								res.send({"code" : -1});
								}	
								else{
									if(go_outarray.length!=1){
										for(var i in go_outarray){
											go_out.push(results3[i][0]);
										}
									}
									else if(go_outarray[0]!=''){
										go_out.push(results3[0]);
									}

									var worksql="";
									for(var i in workarray){
										worksql+=`select * from normaluser where militaryNumber = \'${workarray[i]}\';`;
									}
					
			//console.log(dutysql);
									if(worksql=="") worksql = `select * from normaluser where militaryNumber = '-1';`;
									connection.query(worksql, (error, results4, fields) => {
        								if (error) {
        									console.log(error);
	  										res.send({"code" : -1});
										}	
										else{
											if(workarray.length!=1){
												for(var i in workarray){
													work.push(results4[i][0]);
												}
											}
											else if(workarray[0]!=''){
												work.push(results4[0]);
											}

											var etcsql="";
											for(var i in etcarray){
												etcsql+=`select * from normaluser where militaryNumber = \'${etcarray[i]}\';`;
											}
										  
											if(etcsql=="") etcsql = `select * from normaluser where militaryNumber = '-1';`;
											console.log(etcsql);
											connection.query(etcsql, (error, results5, fields) => {
        										if (error) {
        											console.log(error);
	  												res.send({"code" : -1});
												}	
												else{
													//console.log(etcarray[0]);
													console.log(results1);
													console.log(results5);
													if(etcarray.length!=1){
														for(var i in etcarray){
															//console.log(results5[i][0]);
															etc.push(results5[i][0]);
														}
													}
													else if(etcarray[0]!=''){
														etc.push(results5[0]);
													}
													console.log(etc);

					//								console.log(results5);
													var reason = {"당직": duty, "휴가": vacation, "외출": go_out, "근무": work, "기타": etc};
													//console.log(results5.length);
														data = {"id" : results[0].id, "totalNumberOfPeople": results[0].numofallpeople, "reason" : reason};
													//res.send(reason);
														response = {"code":1, "msg":"success", "data": data};
														res.send(response);
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
    		}
   	})
});







module.exports = router;
