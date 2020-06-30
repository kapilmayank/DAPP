Eutil = require('ethereumjs-util');
EcommerceStore = artifacts.require("./EcommerceStore.sol");
module.exports = function(callback){
	current_time = Math.round(new Date()/1000);
	amt_1 = web3.utils.toWei('1','ether');
	EcommerceStore.deployed().then(function(i){i.addProductToStore('iphone5','Cell Phones & Accessories','QmNtdgiX19ex6wpxeeiottgLwUWZUq4ZnbCzYa6Z42WHLv','QmWgdZ6D28ATAHUMRx7dNKxshby6djWzY7hr4vhWVnEyfv',current_time,current_time+200,2*amt_1,0).then(function(f){console.log(f)})});
    EcommerceStore.deployed().then(function(i){i.addProductToStore('iphone5s','Cell Phones & Accessories','QmSgWzFu81nwGWskcThrHJcfKBxpZCsTvHnVfUpksY1v9g','Qmc2iFcYfwdTqezYvyuXL1jsnBeBmLSBy8jbLi5gPiyYqY ',current_time,current_time+400,3*amt_1,1).then(function(f){console.log(f)})});
    EcommerceStore.deployed().then(function(i){i.addProductToStore('iphone6','Cell Phones & Accessories','QmS4NJxXsZ56uA9p6deG8EYyNpVdrakumNEVXGygZXanaL','QmbhtmQjgDu3UXjPBGdRgm6j7iNezSNrLBbQdRuNXLcS5q ',current_time,current_time+14,amt_1,0).then(function(f){console.log(f)})});
    EcommerceStore.deployed().then(function(i){i.addProductToStore('iphone6s','Cell Phones & Accessories','QmYiJ4q64gmj2kh14LJ4ftUnVXt1SQ7GGcxQwYjN1yHw2V ','QmdR9xS4SSS3z6nVQVvk43LjcECsvUJQEBtRhsEPmAmLgH ',current_time,current_time+86400,4*amt_1,1).then(function(f){console.log(f)})});
    EcommerceStore.deployed().then(function(i){i.addProductToStore('iphone7','Cell Phones & Accessories','QmeX7a89LCx4unSBrvLAT6uZpRiD2uoPfhZA2HemVcaMht','QmYN65oXsXEj7d1hisNqCBZSGuFt91vFnY55cU6Wq6xR6p ',current_time,current_time+86400,5*amt_1,1).then(function(f){console.log(f)})});
    EcommerceStore.deployed().then(function(i){i.addProductToStore('jeans','Clothing & Shoes','QmbKfJRy4rkMVtmwu1JVn7GZtm949H91heNoRL48vEJkrT','QmX7BnTYW9EQmdjUuw4yMLN6tSiaVjMnSq4tcg5Dp9nqt1',current_time,current_time+86400*3,5*amt_1,1).then(function(f){console.log(f)})});
    EcommerceStore.deployed().then(function(i){i.productIndex.call().then(function(f){console.log(f)})});
}
