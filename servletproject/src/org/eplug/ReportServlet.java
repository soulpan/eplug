package org.eplug;

import java.sql.*;
import java.text.DecimalFormat;

import javax.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;


public class ReportServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] make = {"-", "-","-","-","-","-","-","-","-","-"} ;
		String[] model = {"-", "-","-","-","-","-","-","-","-","-"} ;
		String[] etype = {"-", "-","-","-","-","-","-","-","-","-"} ;
		int[] number = {0,0,0,0,0,0,0,0,0,0};
		int sum=0;
		int bev=0;
		int phev=0;
		
		try
		{
			response.setContentType("text/html");
			PrintWriter out=response.getWriter();
			
			try{
				Class.forName("com.mysql.jdbc.Driver");
				String jdbcUrl = "jdbc:mysql://localhost:3306/ecars";
				String username = "root";
				String password = "";
				Connection connection = null;
				
			    connection = DriverManager.getConnection(jdbcUrl, username, password);
				Statement statement = connection.createStatement();
				
				String z=request.getParameter("county");
				String sql = "select Make,Model,EType,COUNT(*) from electric_vehicle_population_data where County='"+z+"' GROUP BY Model ORDER BY COUNT(*) DESC LIMIT 10";
				ResultSet rs = statement.executeQuery(sql);
				
				
				int i=0;
				while (rs.next())
				{
					make[i] = rs.getString("Make");
					model[i] = rs.getString("Model");
					etype[i] = rs.getString("EType");
					number[i] = Integer.parseInt(rs.getString("COUNT(*)"));
					sum=sum+number[i];
					if (etype[i].equals("Battery Electric Vehicle (BEV)")) {
						bev=bev+number[i];
					}
					else {
						phev=phev+number[i];
					}
					i++;
				}
				double per1=bev/ (double) sum;
				double per2=phev/ (double) sum;
				per1=per1*100;
				per2=per2*100;
				per1=Math.round(per1 * 100.0) / 100.0; //percentage of bev
				per2=Math.round(per2 * 100.0) / 100.0; //percentage of phev
				HttpSession session = request.getSession();
				session.setAttribute("topcar", model[0]); //the best-selling car
				session.setAttribute("county", z); //the name of the county
				session.setAttribute("make", make);
				session.setAttribute("model", model);
				session.setAttribute("etype", etype);
				session.setAttribute("number", number);
				session.setAttribute("per1", per1);
				session.setAttribute("per2", per2);
				response.sendRedirect("resultpage.jsp");
			}
			catch (ClassNotFoundException cnfe)
			{
				out.println("class not found");
			}
		}
		catch (SQLException e)
		{
			throw new RuntimeException("Cannot connect the database!", e);
		}		
		
	}
	
}
