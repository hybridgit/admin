$(document).ready(function(){
  // Initialize Sidebar
  $(".button-collapse").sideNav();
  // Initialize Selects
  $('select').material_select();

  // Set the start date to first day of the week
  $("#start-date").data("value", moment().startOf('week').format("YYYY-MM-DD"));

  // Set the end date to today
  $("#end-date").data("value", moment().format("YYYY-MM-DD"));

  // Initialize DatePicker
  $('.datepicker').pickadate({
    container: "body",
    formatSubmit: 'yyyy-mm-dd',
    hiddenName: true,
    selectYears: 15,
    onSet: function(context) {
      initializeGraph();
    },
    onClose: function() {
      $(document.activeElement).blur();
    }
  });

  $("#report-type").change(function(){
    initializeGraph();
  });

  $(window).resize(function(){
    initializeGraph();
  });

  // Initialize the report
  initializeGraph();
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
