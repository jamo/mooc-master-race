// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


function applicantsReady() {
  $('#applicants-header th').each(function(){
    var name = $(this).attr('id');
    var checkbox = $('#' + name + '_checkbox')
    if (checkbox.prop("checked") ){
      $(this).addClass("checked");
      $(this).removeClass("unchecked");
    } else {
      $(this).removeClass("checked");
      $(this).addClass("unchecked");
    }

  $(this).on('click', function(){
    $(this).toggleClass("checked");
    $(this).toggleClass("unchecked");
    var name = $(this).attr('id');
    var checkbox = $('#' + name + '_checkbox')
    checkbox.prop( "checked", !checkbox.prop("checked") );
  });

  });

}

$(document).ready(applicantsReady);
$(document).on('page:load', applicantsReady);
