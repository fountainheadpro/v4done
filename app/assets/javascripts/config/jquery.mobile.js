$(document).bind("mobileinit", function(){
  $.extend(  $.mobile , {
    linkBindingEnabled: false,
    hashListeningEnabled: false,
    pushStateEnabled: false,
    loadingMessage: false,
    ajaxEnabled: false,
    autoInitializePage: false
  });
});
