// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function importedUsersReady() {
  $('#imported_users-header th').each(function(){
    var name = $(this).attr('id');
    if (undefined != name){
      var checkbox = $('#' + name + '_checkbox')
      if (checkbox.prop("checked") ){
        $(this).addClass("checked");
        $(this).removeClass("unchecked");
      } else if (!checkbox.prop("checked") ) {
        $(this).removeClass("checked");
        $(this).addClass("unchecked");
      }
    }
    $(this).on('click', function(){
      var name = $(this).attr('id');
      if (undefined != name){
        $(this).toggleClass("checked");
        $(this).toggleClass("unchecked");
        var checkbox = $('#' + name + '_checkbox')
      checkbox.prop( "checked", !checkbox.prop("checked") );
      }
    });

  });

}

$(document).ready(importedUsersReady);
$(document).on('page:load', importedUsersReady);
