$(document).ready(function () {
    (function(d, script) {
        script          = d.createElement('script');
        script.type     = 'text/javascript';
        script.async    = true;
        script.onload   = function ( ) { };
        script.src      = '//127.0.0.1:3000/cmt.js?' + Math.random();
        d.getElementsByTagName('head')[0].appendChild(script);
    }(document));
}); 
