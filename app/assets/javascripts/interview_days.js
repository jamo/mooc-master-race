// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function ready2(){
  $('.toggle-arrival-status').each( function() {
    setListenerOn2($(this));
    console.log("moi");
  });
}

function setListenerOn2(elem){
  elem.on("ajax:beforeSend", function(evt, xhr, settings){
    console.log("alku");
  }).on("ajax:success", function(evt, xhr, settings) {
    console.log("succ");
  }).on("ajax:error", function(evt, xhr, settings){
    console.log("error");
  }).on("ajax:complete", function(evt, xhr, settings){
    var tr = $(this).closest('.interview_details');
    console.log(xhr);
    console.log(tr);
    var text = $(xhr.responseText);
    tr.replaceWith(text);
    setListenerOn2(text);
  });
}

$(document).ready(ready2);
$(document).on('page:load', ready2);
