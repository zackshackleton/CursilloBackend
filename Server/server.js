var express = require('express');
var session = require('express-session');
var mysql = require('mysql');
var sqlQueries = require('./sql_queries');
var app = express();
var bodyParser = require('body-parser');

var dbInfo = {
  host     : 'localhost',
  user     : 'Cursillo_User',
  password : 'Password',
  database : 'CursilloDB',
  dateStrings : true
}

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json({limit: '15mb'}));

app.use('/',function(req,res,next){
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "X-Requested-With, Content-Type, Accept");
  next();
});

app.post('/getCursillos', function(req, res) {
  var searchCursillo = {
    CURSILLO_ID: req.body.data.id,
    GENDER: req.body.data.gender,
    START_DATE: req.body.data.startYear,
    END_DATE: req.body.data.endYear,
    STREET: req.body.data.street,
    CITY: req.body.data.city,
    STATE_NAME: req.body.data.state,
    ZIP_CODE: req.body.data.zip,
  }

  sqlQueries.getCursillos(dbInfo, searchCursillo, function(err, newCursillos){
    if(err){
      res.json({
        success : false,
        errorMessage : "Error getting the cursillos in getCursillos " + err
      });
      return;
    }
    res.json({
      success : true,
      cursillos : newCursillos
    });
  });
});

app.post('/getIndividuals', function(req, res) {
  var searchIndividual = {
    CURSILLO_ID: req.body.data.cursilloID,
    INDIVIDUAL_ID: req.body.data.id,
    GENDER: req.body.data.gender,
    FIRST_NAME: req.body.data.firstName,
    PREFERRED_NAME: req.body.data.preferred,
    LAST_NAME: req.body.data.lastName,
    DOB: req.body.data.year,
    STREET: req.body.data.street,
    CITY: req.body.data.city,
    STATE_NAME: req.body.data.state,
    ZIP_CODE: req.body.data.zip,
    PHONE_NUMBER: req.body.data.phone,
    EMAIL: req.body.data.email,
    OCCUPATION: req.body.data.jobTitle,
    WORK_NUMBER: req.body.data.workPhone,
    SPOUSE_FIRST: req.body.data.spouseFirst,
    SPOUSE_LAST: req.body.data.spouseLast,
    SPOUSE_ID: req.body.data.spouseID,
    PARISH_ID: req.body.data.parishID,
    ROLE: req.body.data.role,
  }

  sqlQueries.getIndividuals(dbInfo, searchIndividual, function(err, newIndividuals){
    if(err){
      res.json({
        success : false,
        errorMessage : "Error getting the Individual in getIndividuals " + err
      });
      return;
    }
    res.json({
      success : true,
      individuals : newIndividuals
    });
  });
});

app.post('/getParishs', function(req, res) {
  var searchParish = {
    PARISH_ID: req.body.data.id,
    PARISH_NAME: req.body.data.name,
    STREET: req.body.data.street,
    CITY: req.body.data.city,
    STATE_NAME: req.body.data.state,
    ZIPCODE: req.body.data.zip,
    PHONE_NUMBER: req.body.data.phone,
    SPONSOR_NAME: req.body.data.sponsorName,
  }

  sqlQueries.getParishs(dbInfo, searchParish, function(err, newParishs){
    if(err){
      res.json({
        success : false,
        errorMessage : "Error getting the Parishs in getParishs " + err
      });
      return;
    }
    res.json({
      success : true,
      parishs : newParishs
    });
  });
});

app.post('/addCursillo', function(req, res) {
  var newCursillo = {
    CURSILLO_ID: req.body.data.id,
    GENDER: req.body.data.gender,
    START_DATE: req.body.data.startYear + '-' + req.body.data.StartMonth + '-' + req.body.data.StartDay,
    END_DATE: req.body.data.endYear + '-' + req.body.data.EndMonth + '-' + req.body.data.EndDay,
    STREET: req.body.data.street,
    CITY: req.body.data.city,
    STATE_NAME: req.body.data.state,
    ZIP_CODE: req.body.data.zip,
    DESCRIPTION: req.body.data.description,
    NOTES: req.body.data.notes,
  }

  sqlQueries.addCursillo(dbInfo, newCursillo, function(err, newCursillos){
    if(err){
      res.json({
        success : false,
        errorMessage : "Error getting the cursillos in getCursillos " + err
      });
      return;
    }
    res.json({
      success : true,
    });
  });
});

app.post('/addIndividual', function(req, res) {
  var newIndividual = {
    id: req.body.data.id,
    gender: req.body.data.gender,
    active: req.body.data.active,
    firstName: req.body.data.firstName,
    preferred: req.body.data.preferred,
    lastName: req.body.data.lastName,
    month: req.body.data.month,
    day: req.body.data.day,
    year: req.body.data.year,
    street: req.body.data.street,
    city: req.body.data.city,
    state: req.body.data.state,
    zip: req.body.data.zip,
    phone: req.body.data.phone,
    email: req.body.data.email,
    jobTitle: req.body.data.jobTitle,
    workPhone: req.body.data.workPhone,
    maritalStatus: req.body.data.maritalStatus,
    spouseFirst: req.body.data.spouseFirst,
    spouseLast: req.body.data.spouseLast,
    spouseAttended: req.body.data.spouseAttended,
    spouseID: req.body.data.spouseID,
    spouseID: req.body.data.parishID,
    living: req.body.data.living,
    role: req.body.data.role,
    talkID: req.body.data.talkID,
    talkNumber: req.body.data.talkNumber,
    talkDescription: req.body.data.talkDescription,
  }

  sqlQueries.addIndividual(dbInfo, newIndividual, function(err, newIndividual){
    if(err){
      res.json({
        success : false,
        errorMessage : "Error getting the Individuals in addIndividual " + err
      });
      return;
    }
    res.json({
      success : true,
    });
  });
});

app.post('/addParish', function(req, res) {
  var newParish = {
    id: req.body.data.id,
    name: req.body.data.name,
    street: req.body.data.street,
    city: req.body.data.city,
    state: req.body.data.state,
    zip: req.body.data.zip,
    phone: req.body.data.phone,
    sponsorName: req.body.data.sponsorName,
    notes: req.body.data.notes,
  }

  sqlQueries.addParish(dbInfo, newParish, function(err, newParishs){
    if(err){
      res.json({
        success : false,
        errorMessage : "Error getting the Parishs in getParishs " + err
      });
      return;
    }
    res.json({
      success : true,
    });
  });
});

app.post('/removeCursillo', function(req, res) {
  var newCursillo = {
    CURSILLO_ID: req.body.data.id,
  }

  sqlQueries.removeCursillo(dbInfo, newCursillo, function(err, newCursillos){
    if(err){
      res.json({
        success : false,
        errorMessage : "Error getting the cursillos in getCursillos " + err
      });
      return;
    }
    res.json({
      success : true,
    });
  });
});

app.post('/removeIndividual', function(req, res) {
  var newIndividual = {
    INDIVIDUAL_ID: req.body.data.id,
  }

  sqlQueries.removeIndividual(dbInfo, newCursillo, function(err, newIndividual){
    if(err){
      res.json({
        success : false,
        errorMessage : "Error getting the cursillos in getCursillos " + err
      });
      return;
    }
    res.json({
      success : true,
    });
  });
});

app.post('/removeParish', function(req, res) {
  var newParish = {
    PARISH_ID: req.body.data.id,
  }

  sqlQueries.removeParish(dbInfo, newParish, function(err, newParish){
    if(err){
      res.json({
        success : false,
        errorMessage : "Error getting the Parishs in getParishs " + err
      });
      return;
    }
    res.json({
      success : true,
    });
  });
});

var portNumber = 8000;
app.listen(portNumber);
console.log("Cursillo Server started on port: "+portNumber);
