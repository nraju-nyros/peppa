$(document).ready(function () {

  // Sort by price and average rating onchange dishes in searchpage
  $('.sort').on('change', function (e) {
    var name = getUrlVars()["search"];  
    var selected = this.value;
    var data = "";

    if(selected == "ratings"){
      data = {name:name, ratings: this.value}
    }
    else if(selected == "price"){
      data = {name:name, price: this.value}
    }
    
      
    e.preventDefault();
    $.ajax({
        type: "GET",
        url: $(this).attr('href'),
        data: data,
        dataType: "script",
        success: function () {
        }
    });
  });




  // Sorting by average ratings(5+, 4+, 3+) in searchpage
  $('.sort_rating').on('change', function (e) {
    var name = getUrlVars()["search"];
    var selected = this.value;
    var data = {name:name, ratings_filter: this.value}
    e.preventDefault();
    $.ajax({
      type: "GET",
      url: $(this).attr('href'),
      data: data,
      dataType: "script",
      success: function () {

      }
    });
  });


  // Sorting onchange dietary checkboxes in searchpage
  $('.sort_dietary').on('change', function (e) {
    var category = [];

    $.each($("input[type='checkbox']:checked"), function(){            
      category.push($(this).val());
      $.ajax({
        type: "GET",
        url: $(this).attr('href'),
        data: {category: category},
        dataType: "script",
        success: function () {

        }
      });
    });
  });


  // Sorting onchange dietary checkboxes in searchpage
  $('.sort_dish_dietary').on('change', function (e) {
 
    var selected = this.value;

    if(selected == "all"){
      data = {all: this.value}
    }

  
    else if(selected == "1"){
      data = {veg: this.value}
    }
    else if(selected == "2"){
      data = {nonveg: this.value}
    }
     else if(selected == "3"){
      data = {drinks: this.value}
    }
     else if(selected == "4"){
      data = {desserts: this.value}
    }
    
    console.log("data", data)
    e.preventDefault();
    $.ajax({
        type: "GET",
        url: $(this).attr('href'),
        data: data,
        dataType: "script",
        success: function () {
        }
    });
  });

   // Home page scroll loading
   if ($('.pagination').length) {
    $(window).scroll(function() {
      var url = $('.pagination .next_page').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 400) {
        $('.pagination').text("Please Wait...");
        return $.getScript(url);
      }
    });
    return $(window).scroll();
  }
  

  
  
 // select box checkbox list hide when click on body
  $(document).on('click', function () {
      $('#checkboxes').hide();
  });
    
  //element will not Hide on click some specific control inside document
  $('.selectBox, label').on('click', function (e) {
      e.stopPropagation();
  });

});


//Checkboxes in deitary select box 
var expanded = false;
function showCheckboxes() {
  var checkboxes = document.getElementById("checkboxes");
  if (!expanded) {
    checkboxes.style.display = "block";
    expanded = true;
  } else {
    checkboxes.style.display = "none";
    expanded = false;
  }
}



function getUrlVars() {
  var vars = {};
  var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
    vars[key] = value;
  });
 return vars;
}

// google maps of restaurant locations
function initMap() {
  var map = new google.maps.Map(document.getElementById('map_canvas'),{
    center: {lat: 20.5937, lng: 78.9629} ,
    zoom: 5,
  });

  var location = gon.locations
  var restaurant = gon.restaurant
  var restaurant_dish = gon.restaurant_dish
  var pictures = gon.pictures

  for(var i = 0 ; i < location.length; i++ ){
    var marker = new google.maps.Marker({
      position: {lat: location[i].latitude, lng: location[i].longitude},
      map: map,
      title: restaurant[i].name,
       label: {color:'white', fontWeight: "bold"},
      icon: {
        path: 'M22-48h-44v43h16l6 5 6-5h16z',
        fillColor: '#697f8c',
        fillOpacity: 1,
        strokeColor: '#FFFFFF',
        strokeWeight: 5,
        title: 'fdf',
        labelClass: "label",// the CSS class for the label
        labelOrigin: new google.maps.Point(0, -25),
        size: new google.maps.Size(32,32),
        anchor: new google.maps.Point(16,32) 
      } 
    });
     
    marker.content = '<p><img width ="80px" height = "60px" src='+pictures[i].image.url+' ><b> &nbsp;&nbsp;'+ restaurant[i].name+'</b><br><br><b class="location_address">'+location[i].street+','+location[i].city+
                     ','+location[i].state+','+location[i].pincode+','+location[i].country+'<b>';
    
    
    // var markerCluster = new MarkerClusterer(map, marker)


    //Marker onclick show info window and show all dishes related restaurant 
    var infoWindow = new google.maps.InfoWindow();
    google.maps.event.addListener(marker, 'click',(function (marker, i) {
      return function(){
        infoWindow.setContent(this.content);
        infoWindow.open(map, this);
        var restaurant_id =restaurant[i].id;
          $.ajax({
              type: "GET",
              url: $(this).attr('href'),
              data: {restaurant_id: restaurant_id},
              dataType: "script",
              success: function () {
              }
          });
      }
    })(marker,i));
  }
}



  

  
    
    

