$(document).ready(function() {

  if($('#survey-title').text() === "New Survey"){

    $('#add-question-btn').hide();
    $('.survey-nav-buttons').hide();
  }

  $('#edit-title-form').submit(function(updateTitle){
    updateTitle.preventDefault();
   
    var url = $(this).attr('action');
    var data = $(this).serialize();

    $.post(url, data, function(response){
      $('#survey-title').html($(response).find('#survey-title').text());
    });
  
    $('#question-textarea').show();
    $('#add-question-btn').show();
    $('.survey-nav-buttons').show();
  });

  $('#add-question-form').submit(function(addQuestion){
    addQuestion.preventDefault();

    var url = $(this).attr('action');
    var data = $(this).serialize();
    
    $.post(url, data, function(response){
      console.log(response);
      $('.question-container').html($(response).find('.question-container'));

      $('#question-textarea').val("");
      $('.survey-nav-buttons').show();
    });
  });

  $('.new-response-form').submit(function(addQuestion){
    addQuestion.preventDefault();

      var url = $(this).attr('action');
      var data = $(this).serialize();

      $.post(url, data, function(response){
        $('#responses').html($(response).find('#responses'));
      });



  });



});
