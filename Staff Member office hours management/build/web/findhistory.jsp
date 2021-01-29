<%-- 
    Document   : findhistory
    Created on : Jan 15, 2021, 2:28:40 PM
    Author     : LENOVO
--%>

<%@page import="java.time.LocalDateTime"%>
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
                margin-left: 230px;
                margin-top: 20px;

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
        <%            String url = "jdbc:mysql://localhost:3306/internetproject";
            String user = "root";
            String password = "root";
            String Line;
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;
            Statement Stmt2 = null;
            ResultSet RS2 = null;
            session = request.getSession(true);
            String userName = session.getAttribute("session_username").toString();
            String staff_id = "";
            String from = request.getParameter("from");
            String to = request.getParameter("to");
            LocalDateTime date_from = LocalDateTime.parse(from);
            LocalDateTime dateTime_to = LocalDateTime.parse(to);

            if (date_from.isAfter(dateTime_to) || date_from.isEqual(dateTime_to)) {
                out.print("<script type=text/javascript>"
                        + "alert('Wrong in time range');"
                        + "location='history.jsp';"
                        + "</script>");
            } else {
                try {

                    Con = DriverManager.getConnection(url, user, password);
                    Stmt = Con.createStatement();
                    Stmt2 = Con.createStatement();

                    RS = Stmt.executeQuery("SELECT * FROM staff WHERE user_userName=" + "'" + userName + "'");
                    RS.next();
                    staff_id = RS.getString("id");
                    RS = Stmt.executeQuery("SELECT * from appointment where date between " + "'" + date_from + "' and " + "'" + dateTime_to + "' and staff_id1=" + "'" + staff_id + "'");

                } catch (Exception cnfe) {
                    System.err.println("Exception: " + cnfe);
                }
        %>
        <table id="myTable">
            <tr class="header">
                <th style="width:40%;">Date</th>
                <th style="width:30%;">Slot</th>
                <th style="width:30%;">Student Name</th>

            </tr>
            <%
                while (RS.next()) {
            %>
            <tr>
                <td>
                    <%
                        String date = RS.getString("date");
                        out.print(date);
                    %>
                </td>
                <td>
                    <%
                        String slot = RS.getString("slot");
                        out.print(slot);
                    %>
                </td>
                <td colspan="2">
                    <%
                        String student_id = RS.getString("student_id");
                        RS2 = Stmt2.executeQuery("SELECT * FROM student WHERE id=" + "'" + student_id + "'");
                        RS2.next();
                        out.print(RS2.getString("user_userName"));

                    %>
                </td>

            </tr>
            <%}%>
            <%
                RS.close();
                Stmt.close();
                Con.close();
            %>

        </table>
        <form id="myform" action="clearhistory">
            <input type='hidden' name='staff_id' value="<%=staff_id%>">
            <input type='hidden' name='from' value="<%=date_from%>">
            <input type='hidden' name='to' value="<%=dateTime_to%>">
            <input type='submit' value='Clear'>


        </form>
    </body>
</html>
<% }
    }%>
