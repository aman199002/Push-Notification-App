# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  PrivatePub.subscribe "/posts", (data, channel) ->    
    $('table#posts tbody').append(data.html_content)
    $('#post_'+data.id).fadeOut().fadeIn()
