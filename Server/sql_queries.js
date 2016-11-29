var mysql = require('mysql');

module.exports={
	getCursillos: function(dbInfo, searchCursillo, fn) {
		var queryString = `SELECT * FROM CURSILLO WHERE CURSILLO_ID LIKE '${searchCursillo.CURSILLO_ID}' AND GENDER LIKE '${searchCursillo.GENDER}' AND START_DATE LIKE '${searchCursillo.START_DATE}' AND END_DATE LIKE '${searchCursillo.END_DATE}' AND STREET LIKE '${searchCursillo.STREET}' AND CITY LIKE '${searchCursillo.CITY}' AND STATE_NAME LIKE '${searchCursillo.STATE_NAME}' AND ZIP_CODE LIKE '${searchCursillo.ZIP_CODE}'`;
		var conn = mysql.createConnection(dbInfo);
		conn.query(queryString, function(err, rows, fields){
			if(err) {
				fn(err);
				return;
			}
			fn(err, rows);
		});
		conn.end();
	},

	getIndividuals: function(dbInfo, searchIndividual, fn) {
		var queryString = `SELECT * FROM INDIVIDUAL WHERE INDIVIDUAL_ID LIKE '${searchIndividual.INDIVIDUAL_ID}' AND GENDER LIKE '${searchIndividual.GENDER}' AND FIRST_NAME LIKE '${searchIndividual.FIRST_NAME}' AND PREFERRED_NAME LIKE '${searchIndividual.PREFERRED_NAME}' AND LAST_NAME LIKE '${searchIndividual.LAST_NAME}' AND DOB LIKE '${searchIndividual.DOB}' AND STREET LIKE '${searchIndividual.STREET}' AND CITY LIKE '${searchIndividual.CITY}' AND STATE_NAME LIKE '${searchIndividual.STATE_NAME}' AND ZIP_CODE LIKE '${searchIndividual.ZIP_CODE}' AND PHONE_NUMBER LIKE '${searchIndividual.PHONE_NUMBER}' AND EMAIL LIKE '${searchIndividual.EMAIL}' AND OCCUPATION LIKE '${searchIndividual.OCCUPATION}' AND WORK_NUMBER LIKE '${searchIndividual.WORK_NUMBER}' AND SPOUSE_FIRST LIKE '${searchIndividual.SPOUSE_FIRST}' AND SPOUSE_LAST LIKE '${searchIndividual.SPOUSE_LAST}' AND SPOUSE_ID LIKE '${searchIndividual.SPOUSE_ID}' AND PARISH_ID LIKE '${searchIndividual.PARISH_ID}'`;
				var conn = mysql.createConnection(dbInfo);
		conn.query(queryString, function(err, rows, fields){
			if(err) {
				fn(err);
				return;
			}
			fn(err, rows);
		});
		conn.end();
	},

	getParishs: function(dbInfo, searchParish, fn) {
		var queryString = `SELECT * FROM PARISH WHERE PARISH_ID LIKE '${searchParish.PARISH_ID}' AND PARISH_NAME LIKE '${searchParish.PARISH_NAME}' AND STREET LIKE '${searchParish.STREET}' AND CITY LIKE '${searchParish.CITY}' AND STATE_NAME LIKE '${searchParish.STATE_NAME}' AND ZIPCODE LIKE '${searchParish.ZIPCODE}' AND PHONE_NUMBER LIKE '${searchParish.PHONE_NUMBER}' AND SPONSOR_NAME LIKE '${searchParish.SPONSOR_NAME}'`;
		var conn = mysql.createConnection(dbInfo);
		conn.query(queryString, function(err, rows, fields){
			if(err) {
				fn(err);
				return;
			}
			fn(err, rows);
		});
		conn.end();
	},

	addCursillo: function(dbInfo, newCursillo, fn) {
		var queryString = `INSERT INTO CURSILLO VALUES(${newCursillo.CURSILLO_ID}, ${newCursillo.DESCRIPTION}, ${newCursillo.GENDER}, ${newCursillo.START_DATE}, ${newCursillo.END_DATE}, ${newCursillo.NOTES}, ${newCursillo.STREET}, ${newCursillo.CITY}, '${newCursillo.STATE_NAME}, ${newCursillo.ZIP_CODE})`;
		var conn = mysql.createConnection(dbInfo);
		conn.query(queryString, function(err, rows, fields){
			if(err) {
				fn(err);
				return;
			}
			fn(err, rows);
		});
		conn.end();
	},

	addIndividual: function(dbInfo, newIndividual, fn) {
		var queryString = `INSERT INTO INDIVIDUAL VALUES(${newIndividual.cursilloID}, ${newIndividual.id}, ${newIndividual.gender}, ${newIndividual.active}, ${newIndividual.firstName}, ${newIndividual.preferred}, ${newIndividual.lastName}, ${newIndividual.month}, ${newIndividual.day}, ${newIndividual.year}, ${newIndividual.street}, ${newIndividual.city}, ${newIndividual.state}, ${newIndividual.zip}, ${newIndividual.phone}, ${newIndividual.email}, ${newIndividual.jobTitle}, ${newIndividual.workPhone}, ${newIndividual.maritalStatus}, ${newIndividual.spouseFirst}, ${newIndividual.spouseLast}, ${newIndividual.spouseAttended}, ${newIndividual.spouseID}, ${newIndividual.spouseID}, ${newIndividual.living}, ${newIndividual.role}, ${newIndividual.talkID}, ${newIndividual.talkNumber}, ${newIndividual.talkDescription}`;
		var conn = mysql.createConnection(dbInfo);
		conn.query(queryString, function(err, rows, fields){
			if(err) {
				fn(err);
				return;
			}
			fn(err, rows);
		});
		conn.end();
	},

	addParish: function(dbInfo, newParish, fn) {
		var queryString = `INSERT INTO PARISH VALUES(${newParish.id}, ${newParish.name}, ${newParish.street}, ${newParish.city}, ${newParish.state}, ${newParish.zip}, ${newParish.phone}, ${newParish.sponsorName}, ${newParish.notes})`;
		var conn = mysql.createConnection(dbInfo);
		conn.query(queryString, function(err, rows, fields){
			if(err) {
				fn(err);
				return;
			}
			fn(err, rows);
		});
		conn.end();
	},

	removeCursillo: function(dbInfo, newCursillo, fn) {
		var queryString = `DELETE FROM CURSILLO WHERE CURSILLO_ID = ${newCursillo.CURSILLO_ID}`;
		var conn = mysql.createConnection(dbInfo);
		conn.query(queryString, function(err, rows, fields){
			if(err) {
				fn(err);
				return;
			}
			fn(err, rows);
		});
		conn.end();
	},

	removeIndividual: function(dbInfo, newIndividual, fn) {
		var queryString = `DELETE FROM INDIVIDUAL WHERE INDIVIDUAL_ID LIKE ${newIndividual.INDIVIDUAL_ID}`;
		var conn = mysql.createConnection(dbInfo);
		conn.query(queryString, function(err, rows, fields){
			if(err) {
				fn(err);
				return;
			}
			fn(err, rows);
		});
		conn.end();
	},

	removeParish: function(dbInfo, newParish, fn) {
		var queryString = `DELETE FROM PARISH WHERE PARISH_ID LIKE ${newParish.PARISH_ID}`;
		var conn = mysql.createConnection(dbInfo);
		conn.query(queryString, function(err, rows, fields){
			if(err) {
				fn(err);
				return;
			}
			fn(err, rows);
		});
		conn.end();
	},
}
