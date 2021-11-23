/**
 * 
 */

$(document).ready(function(){ 
	  $('#button1').click(function(){ 
	    alert($('#kind :selected').text());
	  });
	});
	
$('.tab-content').on('click', function (e) {
  e.preventDefault()
  $(this).tab('show')
})