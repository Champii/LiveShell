// Generated by LiveScript 1.3.1
(function(){
  var Wrapper, livescript;
  Wrapper = require('./Wrapper');
  livescript = require('livescript');
  process.stdin.once('data', function(it){
    return livescript.run(Wrapper(it.toString()));
  });
}).call(this);
