<%-- 
    Document   : history
    Created on : Jan 14, 2021, 7:06:33 AM
    Author     : LENOVO
--%>

<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Class.forName("com.mysql.jdbc.Driver").newInstance(); %>
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

        <title>Reservations History</title>
        <style>
            #myform{
                margin-left: 300px;
                margin-top: 70px;

            }
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
        <div class="container" id="myform" >
            <h4>View History</h4>
            <form action="findhistory.jsp" >
               
                <label for="lname">From</label>
                <input type="datetime-local" name="from">
                <label for="lname">To</label>
                <input type="datetime-local" name="to">
                <input type="submit" value="View">
            </form>
        </div>
        
        
       
    </body>
</html>
<% }%>