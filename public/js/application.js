$(document).ready(function() {

  $('#question-textarea').hide();
  $('#back-to-survey').hide();
  $('#edit-title-btn').val('Save');
  

 //  // Makes sure user can't create a survey with an empty title
 //  $('input[type="submit"]').attr('disabled','disabled');
   
 // $('input[type="text"]').keyup(function() {
 //    if($(this).val() != '') {
 //       $('input[type="submit"]').removeAttr('disabled');
 //    }
 //  });

 
  
  $('#edit-title-form').submit(function(updateTitle){
    updateTitle.preventDefault();
   
    var url = $(this).attr('action');
    var data = $(this).serialize();

    $.post(url, data, function(response){
      $('#survey-title').html($(response).find('#survey-title').text());
    });
  });

 //    $('#edit-title-text').hide();
 //    $('#edit-title-btn').hide();
 //    $('#question-textarea').show();
 //    $('#add-question-btn').show();
 //    $('#')
});
