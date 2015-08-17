$(document).ready(function(event){
  // Initialize Sidebar
  $(".button-collapse").sideNav();

  // Initialize Selects
  $('.input-field select').material_select();

  // Set the start date to first day of the week
  $("#start-date, #map-start-date").data("value", moment().startOf('week').format("YYYY-MM-DD"));

  // Set the end date to today
  $("#end-date, #map-end-date").data("value", moment().format("YYYY-MM-DD"));

  // Initialize DatePicker
  $('.datepicker').pickadate({
    container: "body",
    formatSubmit: 'yyyy-mm-dd',
    hiddenName: true,
    selectYears: 15,
    onSet: function(context) {
      if($("main").hasClass("map")){
        initializeMap();
      } else {
        initializeGraph();
      }
    },
    onClose: function() {
      $(document.activeElement).blur();
    }
  });

  $("#report-type").change(function(){
    initializeGraph();
  });

  $("#map-report-type").change(function(){
    initializeMap();
  });

  $(window).resize(function(){
    initializeGraph();
  });

  // Initialize the report
  initializeGraph();

  if($('#google-map').length > 0){
    $("#drawer").removeClass("fixed").attr("style", "");
    $('.button-collapse').addClass('show-on-large').sideNav('hide');
  }

  // Initialize the map
  initializeMap();

  // Toggle Filter
  $("#toggle-filter").click(function(){
    if($("#map-filter-form form").css("display") == "none"){
      $("#map-filter-form form").show();
      $("i.right").addClass("hide");
      $("i.left").removeClass("hide");
    } else {
      $("#map-filter-form form").hide();
      $("i.right").removeClass("hide");
      $("i.left").addClass("hide");
    }
  });

  // Labels for ciricles
  // $('.gmnoprint').tipsy({
  //   gravity: 'w',
  //   html: true,
  //   title: function() {
  //     return "Location:" + $(this).attr("original-title").split(";")[0] + "<br/>Value:" + $(this).attr("original-title").split(";")[1];
  //   }
  // });

});

var svg = null,
yAxisGroup = null,
xAxisGroup = null,
dataCirclesGroup = null,
dataLinesGroup = null;

initializeGraph = function(){
  var selectedReport = $("#report-type");
  var startDate = $("input[name=start_date]");
  var endDate = $("input[name=end_date]");

  // Set the Title of Graph
  //$("#graph-title").html(selectedReport.val());

  if(selectedReport.length){
    // Get data about the selected option
    $.ajax({
      url: selectedReport.val(),
      data: {
        start_date: startDate.val(),
        end_date: endDate.val()
      },
      success: function(response){
        if(response.data.length > 0){
          drawGraph(response.data);
        }
        $("#total-phone-numbers-count").html(response.total_phone_numbers_count);
        $("#total-sms-sent-count").html(response.total_sms_sent_count);
        $("#average-sms-per-person").html(response.average_sms_per_person);
        $("#successful-connections-count").html(response.successful_connections_count);
      },
      dataType: 'json'
    });
  }
};

drawGraph = function(data){
  // Set the containing div
  var w = $("#current-usage-graph").width(),
  h = parseInt($("#current-usage-graph").width()/2);

  var monthNames = [ "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December" ];

  var maxDataPointsForDots = 50,
  transitionDuration = 1000;

  var margin = 40;
  var max = d3.max(data, function(d) {return d.value});
  var min = 0;
  var pointRadius = 4;
  // Create x and y axis scales
  var x = d3.time.scale().range([0, w - margin * 2]).domain([new Date(data[0].date), new Date(data[data.length -1].date)]);
  var y = d3.scale.linear().range([h - margin * 2, 0]).domain([min, max]);

  // Create x and y axis
  var xAxis = d3.svg.axis().scale(x).tickSize(h - margin * 2).tickPadding(10).ticks(7);
  var yAxis = d3.svg.axis().scale(y).orient('left').tickSize(-w + margin * 2).tickPadding(10);
  // Transition
  var t = null;

  // SVG Container
  svg = d3.select('#current-usage-graph').select('svg').select('g');
  if(svg.empty()){
    svg = d3.select('#current-usage-graph')
    .append('svg:svg')
    .attr('width', "100%")
    .attr('height', h)
    .attr('class', 'usage-graph')
    .append('svg:g')
    .attr('transform', 'translate('+ margin + ',' + margin + ')');
  }

  t = svg.transition().duration(transitionDuration);

  // y ticks and labels
  if(!yAxisGroup){
    yAxisGroup = svg.append('svg:g')
    .attr('class', 'yTick')
    .call(yAxis);
  } else {
    t.select('.yTick').call(yAxis);
  }

  // x ticks and labels
  if(!xAxisGroup){
    xAxisGroup = svg.append('svg:g')
    .attr('class', 'xTick')
    .call(xAxis);
  } else {
    t.select('.xTick').call(xAxis);
  }

  // Draw the lines
  if(!dataLinesGroup){
    dataLinesGroup = svg.append('svg:g')
  }

  var dataLines = dataLinesGroup.selectAll('.data-line')
  .data(data);

  var line = d3.svg.line()
  // assign the X & Y functions to plot the line
  .x(function(d){ return x(new Date(d.date)); })
  .y(function(d){ return y(d.value); })
  .interpolate("linear");

  var garea = d3.svg.area()
  .interpolate("linear")
  .x(function(d){ return x(new Date(d.date)); })
  .y0(h - margin * 2)
  .y1(function(d){ return y(d.value); });

  dataLines.enter()
  .append('svg:path')
  .attr('class', 'area')
  .attr('d', garea(data));

  dataLines.enter()
  .append('path')
  .attr('class', 'data-line')
  .style('opacity', 0.3)
  .attr('d', line(data));

  dataLines.transition()
  .attr('d', line)
  .duration(transitionDuration)
  .style('opacity', 1)
  .attr('transform', function(d){
    return 'translate(' + x(new Date(d.date)) + ',' + y(d.value) + ')';
  });

  dataLines.exit()
  .transition()
  .attr("d", line)
  .duration(transitionDuration)
  .attr("transform", function(d){
    return "translate(" + x(new Date(d.date)) + "," + y(0) + ")";
  })
  .style('opacity', 1e-6)
  .remove();

  d3.selectAll('.area').transition()
  .duration(transitionDuration)
  .attr('d', garea(data));

  // Draw the points
  if(!dataCirclesGroup) {
    dataCirclesGroup = svg.append('svg:g');
  }

  var circles = dataCirclesGroup.selectAll('.data-point')
  .data(data);

  circles
  .enter()
  .append('svg:circle')
  .attr('class', 'data-point')
  .style('opacity', 1e-6)
  .attr('cx', function(d){ return x(new Date(d.date)); })
  .attr('cy', function(){ return y(0) })
  .attr('r', function(){ return (data.length <= maxDataPointsForDots) ? pointRadius : 0 })
  .transition()
  .duration(transitionDuration)
  .style('opacity', 1)
  .attr('cx', function(d){ return x(new Date(d.date)); })
  .attr('cy', function(d){ return y(d.value); });

  circles
  .transition()
  .duration(transitionDuration)
  .attr('cx', function(d){ return x(new Date(d.date)); })
  .attr('cy', function(d){ return y(d.value); })
  .attr('r', function() { return (data.length <= maxDataPointsForDots) ? pointRadius : 0; })
  .style('opacity', 1);

  circles
  .exit()
  .transition()
  .duration(transitionDuration)
  .attr('cy', function() { return y(0); })
  .style("opacity", 1e-6)
  .remove();

  $('svg circle').tipsy({
    gravity: 'w',
    html: true,
    title: function() {
      var d = this.__data__;
      var pDate = new Date(d.date);
      return 'Date: ' + pDate.getDate() + ' ' + monthNames[pDate.getMonth()] + ' ' + pDate.getFullYear() + '<br/>Value: ' + d.value;
    }
  });
};

initializeMap = function(){
  var selectedReport = $("#map-report-type");
  var startDate = $("input[name=map_start_date]");
  var endDate = $("input[name=map_end_date]");

  if(selectedReport.length){
    // Get data about the selected option
    $.ajax({
      url: selectedReport.val(),
      data: {
        start_date: startDate.val(),
        end_date: endDate.val()
      },
      success: function(response){
        drawMap(response);
      },
      dataType: 'json'
    });
  }
}

drawMap = function(response){
  // Create the Google Map…
  var map = new google.maps.Map(d3.select("#google-map").node(), {
    zoom: 12,
    center: new google.maps.LatLng(9.005401, 38.763611),
    mapTypeId: google.maps.MapTypeId.TERRAIN
  });

  if(response.data.length > 0){
    var max = d3.max(response.data, function(d) { return d.value; });
    var min = d3.min(response.data, function(d) { return d.value; });
    var total = d3.sum(response.data, function(d) { return d.value; });

    var color = d3.scale.ordinal()
  	.range(["#00387e", "#2698e1", "#cad7ef", "#8d00d0",  "#bc93d2", "#ed21ce", "#00ac31", "#00d73d", "#76f99b", "#d5005a", "#ff7b7b",  "#ff0000",  "#ff9460",  "#ffc300",  "#ffdc00",  "#baff00"]);

    var circleScale = d3.scale.linear()
    .domain([min, max])
    .range([5, 25]);

    $("#google-map-stats table tbody").html("");

    for(var i=0; i < response.data.length; i++){
      var marker = new google.maps.Marker({
        title: response.data[i].location + ";" + (response.data[i].value/total * 100).toFixed(2) + "%",
        dataLocation: response.data[i].location,
        dataValue: (response.data[i].value/total * 100).toFixed(2) + "%",
        position: {lat: response.data[i].location_lat, lng: response.data[i].location_long},
        icon: {
          path: google.maps.SymbolPath.CIRCLE,
          scale: circleScale(response.data[i].value),
          fillColor: color(i),
          fillOpacity: 0.8,
          strokeWeight: 1,
          strokeColor: '#aaa'
        },
        map: map
      });

      attachInfo(marker, "<strong>Location:</strong> " + response.data[i].location + "<br/><strong>Value:</strong> " + response.data[i].value);

      $("#google-map-stats table tbody")
        .append("<tr><td>" + (i+1) + "</td>" +
                "<td>" + response.data[i].location + "</td>" +
                "<td>" + getLocationValue( response.data[i].location, response.total_phone_numbers) + "</td>" +
                "<td>" + getLocationValue( response.data[i].location, response.total_sms_sent) + "</td>" +
                "<td>N/A</td></tr>");
    }


  }

};

attachInfo  = function(marker, info) {
  var infowindow = new google.maps.InfoWindow({
    content: info
  });

  marker.addListener('click', function() {
    infowindow.open(marker.get('map'), marker);
  });
}

getLocationValue = function(location,list){
  for(var i=0; i < list.length; i++){
    if(location == list[i].location){
      return list[i].value;
    }
  }
  return 0;
};
