<%-- 
    Document   : viewallstaffappointment
    Created on : Jan 12, 2021, 1:35:16 AM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import ="java.io.PrintWriter"%>
<%@page import ="java.io.StringWriter" %>
<%@page import=" javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("session_username") == null)
        response.sendRedirect("index.jsp");
    else {

%> 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="nav.css" >
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.1/css/materialize.min.css">

        <title>Reservations</title>
        <style>




            #myTable {
                border-collapse: collapse; /* Collapse borders */
                width: 80%; /* Full-width */
                border: 1px solid #ddd; /* Add a grey border */
                font-size: 18px; /* Increase font-size */
                margin-left: 230px;
                margin-top: 20px;
            }

            #myTable th, #myTable td {
                text-align: left; /* Left-align text */
                padding: 12px; /* Add padding */
            }

            #myTable tr {
                /* Add a bottom border to all table rows */
                border-bottom: 1px solid #ddd;
            }

            #myTable tr.header, #myTable tr:hover {
                /* Add a grey background color to the table header and on hover */
                background-color: #f1f1f1;
            }
            input[type=datetime-local], select, textarea {
                width: 100%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                margin-top: 6px;
                margin-bottom: 16px;
                resize: vertical;
            }
            input[type=text], select, textarea {
                width: 100%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                margin-top: 6px;
                margin-bottom: 16px;
                resize: vertical;
            }


            input[type=submit] {
                background-color: #4CAF50;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            input[type=submit]:hover {
                background-color: #45a049;
            }

            .container {
                border-radius: 5px;
                background-color: #f2f2f2;
                padding: 20px;
            }


        </style>
    </head>
    <body>
        <%            String url = "jdbc:mysql://localhost:3306/internetproject";
            String user = "root";
            String password = "root";

            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;
            try {
                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();
                String line = null;
                String userName = session.getAttribute("session_username").toString();
                RS = Stmt.executeQuery("Select id from staff where user_userName=" + "'" + userName + "'");
                RS.next();
                String staff_id = RS.getString("id");
                line = "SELECT DATE_FORMAT(date, '%Y-%m-%d') date FROM   appointment  where staff_id1=" + "'" + staff_id + "' GROUP  BY DATE_FORMAT(date, '%Y-%m-%d')";
                RS = Stmt.executeQuery(line);

        %>
        <div class="sidenav">
            <a href="profile.jsp">Profile</a>
            <a href="chat.jsp">Chat</a>
            <a href="notification.jsp">Notification</a>
            <a href="viewcontact.jsp">Find student </a>
            <a href="viewallstaffappointment.jsp">Reservation </a>
            <a href="history.jsp">Reservation history </a>
            <a href="ManageOffice.jsp">Office hours</a>
            <a href="SignOut">Sign out</a>
        </div>
        <table id="myTable" >
            <tr class="header">
                <th style="width:25%;">Day</th>
                <th style="width:25%;">View reservation</th>
                <th style="width:25%;">Cancel all reservation</th>
            </tr>
            <%        while (RS.next()) {%>
            <tr>
                <td>
                    <%

                        out.print(RS.getString("date"));
                    %>
                </td>
                <td>
                    <form action="veiwstaffreservation.jsp">
                        <%
                            out.print("<input type='hidden' name='day' value=" + RS.getString("date") + ">");
                            out.print("<input type='hidden' name='staff_id' value=" + staff_id + ">");
                            out.print("<input type='submit' value='View all reservation'>");

                        %>
                    </form>
                </td>
                <td>
                    <form action="Deleteappointment">
                        <%                            out.print("<input type='hidden' name='check' value='cancel_all'>");
                            out.print("<input type='hidden' name='day' value=" + RS.getString("date") + ">");
                            out.print("<input type='submit' value='Cancel all reservation '>");

                        %>
                    </form>
                </td>


            </tr>
            <%}%>
        </table>
        <%} catch (Exception cnfe) {
                System.err.println("Exception: " + cnfe);
            }
        %>
    </body>
</html>
<% }%>