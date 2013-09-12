$(document).ready(function(){
  //store nodepath value to clipboard (copy to top of page)
  $('li').live('click', function(){
  //console.log($('#pathtonode').html()+ " copied to window");
    var path = $('#pathtonode').html();
    path = path.replace(/ &amp;gt; /g,".");
    //console.log(path);
    addtoppath(path);
  });
  //initially hide copy window
   $('#toppathwrap').hide();

   function addtoppath(path) {
    //console.log(path);
    $('#copypath').val(path);
    $('#toppathwrap').show();
    $('#copypath').focus();
    $('#copypath').select();
  }
});
