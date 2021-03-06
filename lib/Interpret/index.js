// Generated by LiveScript 1.3.1
(function(){
  var fork, Interpret;
  fork = require('child_process').fork;
  import$(global, require('prelude-ls'));
  Interpret = (function(){
    Interpret.displayName = 'Interpret';
    var prototype = Interpret.prototype, constructor = Interpret;
    function Interpret(screen, main){
      this.screen = screen;
      this.main = main;
    }
    prototype.Normalize = function(it){
      it = join('\n')(
      map(function(it){
        return '  ' + it;
      })(
      split('\n')(
      it)));
      return it = drop(2, it);
    };
    prototype.Exec = function(string, _done){
      this._Fork(this.Normalize(string), _done);
    };
    prototype.Run = function(string, _done){
      string = "console.log do -> " + this.Normalize(string);
      this._Fork(string, _done);
    };
    prototype._Fork = function(string, _done){
      var child, done, out;
      child = fork(__dirname + '/Runner', {
        silent: true
      });
      done = function(){
        var done;
        _done.apply(this, arguments);
        return done = function(){};
      };
      out = [];
      child.on('error', function(){
        return done('error');
      });
      child.stdout.on('data', function(it){
        return out.push(it.toString());
      });
      child.on('close', function(){
        return done(null, out.join(''));
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
      return child.stdin.write(string);
    };
    return Interpret;
  }());
  module.exports = Interpret;
  function import$(obj, src){
    var own = {}.hasOwnProperty;
    for (var key in src) if (own.call(src, key)) obj[key] = src[key];
    return obj;
  }
}).call(this);
