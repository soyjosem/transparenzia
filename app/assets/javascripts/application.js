// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require jquery.ui.autocomplete
//= require turbolinks
//= require jquery.smooth-scroll
//= require d3.v3
//= require charts
//= require_tree .


var geocoder
$(function() {
  /*by_place_graph();
  by_department_graph();
  by_tipology_graph();
  */
  number_of_agreements_by_month();

  /*$("#signatories").autocomplete({
    source: '/convenios/buscar',
    minLength: 3
  });*/

  $(".toggler").each(function(){
    var id = $(this).data('toggle-input');
    var elem = $('#'+id);
    var visible = false;
    if (elem.is( "input, select" )){
      if (elem.val()){
        visible = true;
      }
    }else{
        $(elem).find('input, select').each(function(){
          if ($(this).val()){
            visible = true;
          }
      });
    }

    if (visible){
      $(this).addClass("active");
      elem.show();  
    }

    $(this).on('click', function(){
      elem.toggle();
      if(elem.is(":visible")){
        $(this).addClass("active");
      }else{
        $(this).removeClass("active");
      }
      return false;
    });
  });

  $('#cuantitatives a').on('click', function(){
    $('#loading').show();
  });

  $("#filter").on('submit', function(){
    $('#loading').show();
    $(this).find('input, select').each(function(){
      if(!$(this).is(":visible")){
        $(this).val('');
      }
    });
  });

  /*geocoder = new google.maps.Geocoder();
  var map = initialize_map();
  move_to('La Jacetania, Aragón', map);*/
});

function initialize_map() {
    var mapOptions = {
      center: new google.maps.LatLng(41.5976275, -0.9056623),
      zoom: 7,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    return new google.maps.Map(document.getElementById("map"), mapOptions);
}

function move_to(place, map){
	geocoder.geocode( { 'address': place}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      map.setZoom(9)
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}