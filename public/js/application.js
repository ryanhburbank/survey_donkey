$(document).ready(function() {
  
  if($('#survey-title').text() === "New Survey"){
    $('#question-textarea').hide();
    $('#back-to-survey').hide();
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
    $('#edit-title-text').hide();
    $('#edit-title-btn').hide();
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

});
