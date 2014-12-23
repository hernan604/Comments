var comente = {
  onLoad: function() {
    // initialization code
    this.initialized = true;
    this.strings = document.getElementById("comente-strings");


  },

  onMenuItemCommand: function(e) {

    var doc = content.document;
      
    jQuery.noConflict();
    $ = function(selector,context) {
        return new jQuery.fn.init(selector,context||example.doc);
    };
    $.fn = $.prototype = jQuery.fn;

//  this.win = content.window;
//  this.doc = content.document;

//  var rand = Math.floor( ( Math.random() * 10000 ) + 1 );
//  var main = $('<div id="plugin-example">', content.document)
//      .appendTo(doc.body)
//      .html('Example Loaded!!!3');

//  $( "<iframe/>", content.document ).attr( "src", "http://localhost:8080/?url=" + content.document.location.href ).prependTo( doc.body );

    (function(d, script) {
        script = d.createElement('script');
        script.type = 'text/javascript';
        script.async = true;
        script.onload = function(){
            // remote script has loaded
            //alert('loaded');
        };
//      script.src = content.document.location.protocol + '//127.0.0.1:3000/cmt.js?' + Math.random();
        script.src = '//127.0.0.1:3000/cmt.js?' + Math.random();
        d.getElementsByTagName('head')[0].appendChild(script);
    }(content.document));
    
    var promptService = Components.classes["@mozilla.org/embedcomp/prompt-service;1"]
                                  .getService(Components.interfaces.nsIPromptService);
//  promptService.alert(window, this.strings.getString("helloMessageTitle"),
//                              this.strings.getString("helloMessage"));
  },

  onToolbarButtonCommand: function(e) {
    // just reuse the function above.  you can change this, obviously!
    comente.onMenuItemCommand(e);
  }
};

window.addEventListener("load", function () { comente.onLoad(); }, false);


comente.onFirefoxLoad = function(event) {
  document.getElementById("contentAreaContextMenu")
          .addEventListener("popupshowing", function (e) {
    comente.showFirefoxContextMenu(e);
  }, false);
};

comente.showFirefoxContextMenu = function(event) {
  // show or hide the menuitem based on what the context menu is on
  document.getElementById("context-comente").hidden = gContextMenu.onImage;
};

window.addEventListener("load", function () { comente.onFirefoxLoad(); }, false);
