// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
document.addEventListener('DOMContentLoaded', function(event) {
  //the event occurred

  function initialize() {
      if(!my_location){
        return
      }
      var myCoords = new google.maps.LatLng(my_location.latitude,my_location.longitude);

      var mapOptions = {
         zoom: 12,
         scrollwheel: false,   
         center: myCoords
      }
      //create the base map
      var map = new google.maps.Map(document.getElementById('bus-map'), mapOptions);

      //drop the user's location marker 
      var my_marker = new google.maps.Marker({
        position: myCoords,
        map: map,
        title: "You're at " + my_location.address,
        icon: {
          url: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png"
        }
      });
      var my_infowindow = new google.maps.InfoWindow({
        content: my_location.address
        });
      google.maps.event.addListener(my_marker, 'click', function() {
        my_infowindow.open(map,my_marker);
        });

      //drop the buses markers 
      buses.forEach(bus => {
        var cords = new google.maps.LatLng(bus.latitude,bus.longitude);
        var contentString = '<h2>'+ bus.address  + '</h2>' + "<img src='" + bus.image + "'/>"
  
        var infowindow = new google.maps.InfoWindow({
        content: contentString
        });
        var marker = new google.maps.Marker({
            position: cords,
            map: map,
            title: bus.title,
            icon: {
              url: bus.image
            }
        });
        google.maps.event.addListener(marker, 'click', function() {
        infowindow.open(map,marker);
        });
      });
  }
  
  google.maps.event.addDomListener(window, 'load', initialize);
  });