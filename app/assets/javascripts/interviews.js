// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function ready(){
  $('.change-interview-status').each( function() {
    setListenerOn($(this));
  });
}

function setListenerOn(elem){
  elem.on("ajax:beforeSend", function(evt, xhr, settings){
    console.log("alku");
  }).on("ajax:success", function(evt, xhr, settings) {
    console.log("succ");
  }).on("ajax:error", function(evt, xhr, settings){
    console.log("error");
  }).on("ajax:complete", function(evt, xhr, settings){
    var tr = $(this).closest('tr')
    console.log(xhr);
    var text = $(xhr.responseText);
    tr.replaceWith(text);
    setListenerOn(text);
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);
