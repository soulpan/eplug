<%@page import="org.eplug.ReportServlet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Eplug Web Application</title>
<link rel="shortcut icon" type="image/png" href="images/tabicon.png">

	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {

        var data = google.visualization.arrayToDataTable([
          ['Type', 'Percentage'],
          ['BEV',     ${sessionScope.per1}],
          ['PHEV',      ${sessionScope.per2}]
        ]);

        var options = {
          title: 'Type Percentage of Top10 Best-Selling Electric Cars in the County'
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

        chart.draw(data, options);
      }
    </script>
    
<link rel="stylesheet" href="style.css">
	
</head>
<body>
	<h2>Electric Cars Details in the County of ${sessionScope.county},WA State</h2>
	<script type="text/javascript">
		function getSessionName(){
			var name='<%=session.getAttribute("topcar")%>';
			return name;
		}
		function display_image() {
			var car = getSessionName();
			var image = document.getElementById('demo');
			if (car=="LEAF") {image.src = "images/leaf.jpg"; document.getElementById('demo').style.visibility="visible";}
			else if (car=="MODEL 3") {image.src="images/model3.jpg"; document.getElementById('demo').style.visibility="visible";}
			else if (car=="BOLT") {image.src="images/bolt.jpg"; document.getElementById('demo').style.visibility="visible";}
			else if (car=="VOLT") {image.src="images/volt.jpg"; document.getElementById('demo').style.visibility="visible";}
			else if (car=="C-MAX ENERGI") {image.src="images/cmax.jpg"; document.getElementById('demo').style.visibility="visible";}
			else {image.src="images/sorry.png"; document.getElementById('demo').style.visibility="visible";}
		}
	</script>

    <div class="row">
    	<div class="column" align="center">
    		<h4>Electric Vehicles Top10</h4>
			<!-- table -->
			<%
			//make
		    String[] maketemp= (String[]) session.getAttribute("make");
		    StringBuilder make = new StringBuilder();
		    for(int i=0;i<maketemp.length;i++) 
		        make.append(maketemp[i]+",");
		    //model
		    String[] modeltemp= (String[]) session.getAttribute("model");
		    StringBuilder model = new StringBuilder();
		    for(int i=0;i<modeltemp.length;i++) 
		        model.append(modeltemp[i]+",");
		    //etype
		    String[] etypetemp= (String[]) session.getAttribute("etype");
		    StringBuilder etype = new StringBuilder();
		    for(int i=0;i<etypetemp.length;i++) 
		        etype.append(etypetemp[i]+",");
			//number
		    int[] numbertemp= (int[]) session.getAttribute("number");
		    StringBuilder number = new StringBuilder();
		    for(int i=0;i<numbertemp.length;i++) {
		    	if (numbertemp[i]==0) { number.append("-"+","); }
		    	else {number.append(numbertemp[i]+","); }
		    }
			%>
			
			<script type="text/javascript">
			//make
		    temp="<%=make.toString()%>";
		    var make = new Array();
		    make = temp.split(',','<%=maketemp.length%>');
		    //model
		    temp1="<%=model.toString()%>";
		    var model = new Array();
		    model = temp1.split(',','<%=modeltemp.length%>');
		    //etype
		    temp2="<%=etype.toString()%>";
		    var etype = new Array();
		    etype = temp2.split(',','<%=etypetemp.length%>');
		    //number
		    temp3="<%=number.toString()%>";
		    var number = new Array();
		    number = temp3.split(',','<%=numbertemp.length%>');
		        
		    var table = '';
		    var rows = 10;
		    var columns = 5;
		    var range = new Array("1","2","3","4","5","6","7","8","9","10");
		    var array=[ range,
		    			make,
		    			model,
		    			etype,
		    			number,	    	
		    			];
		    table = table +'<tr>';
		    table = table + '<th>' + "RANK" + '</th>';
		    table = table + '<th>' + "MAKE" + '</th>';
		    table = table + '<th>' + "MODEL" + '</th>';
		    table = table + '<th>' + "TYPE" + '</th>';
		    table = table + '<th>' + "NUMBER" + '</th>';
		    table = table +'</tr>';
		    for (var r=0; r<rows; r++) {
		    	table = table +'<tr>';
		    	for (var c=0; c<columns; c++) {
		    		table = table + '<th>' + array[c][r] + '</th>';
		    	}
		    	table = table + '</tr>';
		    }
		    document.write('<table border=4>' + table + '</table>');
			</script>
			<!-- end of table -->
			<div id="piechart" align="center" style=" margin:5px; width: 750px; height: 500px;"></div>
    	</div>
    	<div class="column" align="center">
    		<h4>How's the best-selling car in the County?</h4>
			<input type="button" value="Check it out" onclick="display_image();"/><br><br>
			<img id="demo" src="" width="60%" height="60%" hspace="50" style="visibility:hidden"/>
    	</div>
    </div>
    
</body>
</html>
