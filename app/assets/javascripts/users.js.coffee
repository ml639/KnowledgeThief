# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


  $ ->
    $(".userTabLink_resource").click ->
       $("#userPaths").show("slow")
       $("#userResources").hide()

  $ ->
    $(".userTabLink_path").click ->
       $("#userResources").show("slow")
       $("#userPaths").hide()