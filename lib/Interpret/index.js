// Generated by LiveScript 1.3.1
(function(){
  var fork, Interpret;
  fork = require('child_process').fork;
  Interpret = (function(){
    Interpret.displayName = 'Interpret';
    var prototype = Interpret.prototype, constructor = Interpret;
    function Interpret(screen, main){
      this.screen = screen;
      this.main = main;
    }
    prototype.Run = function(string, _done){
      var child, done;
      child = fork(__dirname + '/Runner', {
        silent: true
      });
      done = function(){
        var done;
        _done.apply(this, arguments);
        return done = function(){};
      };
      child.on('error', function(){
        return done('error');
      });
      child.stdout.on('data', function(it){
        return done(null, it.toString());
      });
      child.stderr.on('data', function(it){
        return done(it.toString());
      });
      child.stdout.on('error', function(){
        return done('error_stdout');
      });
      child.stdin.on('error', function(){
        return done('error_stdin');
      });
      child.stdin.write(string);
    };
    return Interpret;
  }());
  module.exports = Interpret;
}).call(this);