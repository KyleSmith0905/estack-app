var express = require('express');
var router = express.Router();
var mysql2 = require('mysql2');
var body = require('body-parser');
var bcrypt = require("bcrypt");
var saltRounds = 10;
const session = require("express-session");
var cors = require('cors');
const app = require('../app');
const cookieParser = require('cookie-parser');

/* GET users listing. */

router.use(express.json());



//DataBase Details you need to reconfig this to work on you localhost and mySQL DB
var db = mysql2.createPool({
  host:"localhost",
  user:"root",
  password: "password",
  database: "estackdb"
})


router.use(body.urlencoded({extended : true}));


router.use(cookieParser());



//Posting property to DB
router.post('/sell' , (req,res) =>{
  var address = req.body.address;
  var type = req.body.type;
  var numBedrooms = req.body.numBedrooms;
  var numBathrooms = req.body.numBathrooms;
  var sqaureft = req.body.sqaureft;
  var yearBuilt = req.body.yearBuilt;
  var garageParking = req.body.garageParking;
  var ac = req.body.ac;
  var wheelChairAcces = req.body.wheelChairAcces;
  var offStreetParking = req.body.offStreetParking;
  var balcony = req.body.balcony;
  var furnished = req.body.furnished;
  var description = req.body.description;
  var hardWood = req.body.hardWood;
  var listingPrice = req.body.listingPrice;

  var sqlInsert = `INSERT INTO propertysell (address, type, numBedrooms, numBathrooms,
                    sqaureft, yearBuilt, garageParking, ac, wheelChairAcces, offStreetParking
                    ,balcony , furnished, description, hardWood, listingPrice ) 
                    VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,? )`

 

   
    db.query(sqlInsert, [address, type, numBedrooms, numBathrooms,
        sqaureft, yearBuilt, garageParking, ac, wheelChairAcces, offStreetParking
        ,balcony , furnished, description, hardWood, listingPrice], (err,result) =>{
      console.log(err)
  }) 
    

  });

// Get listed properties of a seller
router.post('/listSellProperty', (req, res) =>{
  console.log("enter this function.");
  var email = req.body.email;
  console.log("owner email ", email);
  var sqlQuery = `SELECT * from properties where owner_email = ?`;
  db.query(sqlQuery, [email], (err, result) =>{
    if(err){
      console.log(err);
      res.status("404").send({message : "Error on listing owners' properties."});
    }else{
      console.log(result);
      property_list = JSON.stringify(result);
      res.status("200").send({message: "Return Property List.", list: property_list});
    }
  });
});



module.exports = router;
