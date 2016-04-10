// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function ready2(){
  fetchTmcSubmissions();
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


if (window.location.pathname.indexOf("interview_days") >=0) {

  var socket = io.connect('https://mooc-master.jamo.fi:3003');
  socket.on('submission-received', function (data) {
    console.log(data);
  });

  socket.on('submission-done', function (data) {
    console.log(data);
    maybeAppend(data);
  });

  function maybeAppend(data){
    localStorage.setItem("result", data);
    var parsed = JSON.parse(data);
    appendData(parsed.user, parsed.results);
  }

  $(document).on('page:load', fetchTmcSubmissions);

  function appendData(nick, submission) {
    if (nick === 'Jarmo') {nick = 'Jamo';}
    if (document.querySelector("[id='" + nick + "']")) {
      var text = '<dl class="dl-horizontal">';
      ['exercise_name', 'all_tests_passed', 'status','error','submitted_at'].forEach(function(element) {
        text += '<dt>' + element + '</dt><dd>' + submission[element] + '</dd>';
      });
      text += '</dl>';
      var elem = document.querySelector("[id='" + nick + "'] h4");
      var e = document.createElement("div");
      var inner = document.createElement("div");
      inner.innerHTML = text;
      var a = document.createElement('a');
      a.href = 'https://tmc.mooc.fi/mooc/submissions/' + submission.id;
      a.text = "Link to submission";
      a.target = "_blank";
      e.appendChild(inner);
      e.appendChild(a);
      e.classList.add('tmc-results');
      elem.insertAdjacentElement('afterEnd', e)
    }
  }

  function fetchTmcSubmissions() {
    [].forEach.call(document.querySelectorAll('.reserved'), function(e){
      var nick = e.id;
      if (nick === 'Jamo') {nick = 'Jarmo';}
      var request = new XMLHttpRequest();
      request.open('GET', 'https://mooc-master.jamo.fi:3003/' + encodeURI(nick), true);
      request.onload = function() {
        if (request.status >= 200 && request.status < 400) {
          console.log(nick);
          console.log(e);
          var data = JSON.parse(request.responseText);
          console.log(request);
          if (data) {
            data.forEach(function(elem) {
              console.log(nick);
              appendData(nick, elem);
            });
          }
        }
      };
      request.send();
    });
  }
}
