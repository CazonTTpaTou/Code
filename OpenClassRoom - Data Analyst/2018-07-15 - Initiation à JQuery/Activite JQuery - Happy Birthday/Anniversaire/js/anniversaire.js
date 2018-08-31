$(function() {  

  var listeMessage = ["It is a swampy day...","It is a wet day...","It is a sunny day...","It's your CROC day !!! "]

  var $list = $('ul');

  var $message = $('#clic');

  const rollSound = new Audio("songs/Happy_Birthday_song.mp3");

  $message.on('click',function(event) {
     var text = listeMessage[0]; 
     $list.append('<li class="item" id="first">' + text + '</li>');
     var $firstParagraph = $('#first');
     $message.off('click')

     $firstParagraph.on('click',function(event) {
         var text = listeMessage[1]; 
         $list.append('<li class="item" id="second">' + text + '</li>');
         var $secondParagraph = $('#second');
         $firstParagraph.off('click')

         $secondParagraph.on('click',function(event) {
            var text = listeMessage[2]; 
            $list.append('<li class="item" id="third">' + text + '</li>');
            var $thirdParagraph = $('#third');
            $secondParagraph.off('click')

            $thirdParagraph.on('click',function(event) {
                var imageUrl = 'pictures/Crocs.PNG'
                $('#CrocPicture').height(400);
                $('#CrocPicture').width(700);
                $('h1').text(listeMessage[3]);
                            
                $('#CrocPicture').css('background-image', 'url("' + imageUrl + '")');
                $('body').css("background-color","green");  
                $thirdParagraph.off('click')  
                rollSound.play();            
                });
          });   
      });
  });

});