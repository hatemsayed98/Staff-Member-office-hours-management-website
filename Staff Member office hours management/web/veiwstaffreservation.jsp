<%-- 
    Document   : veiwstaffreservation
    Created on : Jan 11, 2021, 4:02:17 AM
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

        <title>Reservation</title>
    </head>
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
    <body>
        <%            String url = "jdbc:mysql://localhost:3306/internetproject";
            String user = "root";
            String password = "root";

            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;

            String day = request.getParameter("day");
            String staff_id = request.getParameter("staff_id");

            try {

                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();
                String line = "select * from appointment where(date between " + "'" + day + " 00:00:00' and " + "'" + day + " 23:59:59') and staff_id1=" + "'" + staff_id + "'";
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
        <table id="myTable">

            <tr class="header">


                <th style="width:25%;background-color: #f1f1f1;">Slot</th>
                <th style="width:25%;background-color: #f1f1f1;">Date</th>
                <th style="width:25%;background-color: #f1f1f1;">Student Name</th>
                <th style="width:25%;background-color: #f1f1f1;">Cancel</th>

            </tr>
            <%                if (!RS.isBeforeFirst()) {
                    out.print("<script type=text/javascript>"
                            + "alert('There is no reservation yet for this slot');"
                            + "location='viewallstaffappointment.jsp';"
                            + "</script>");
                } else {

                    while (RS.next()) {%>
            <tr>
                <td>
                    <%

                        out.print(RS.getString("slot"));
                    %>
                </td>
                <td>
                    <%
                        String time = RS.getString("date");
                        String[] arr = time.split(" ");
                        out.print(arr[1]);
                    %>
                </td>
                <td>
                    <%
                        Statement Stmt2 = null;
                        ResultSet RS2 = null;
                        Stmt2 = Con.createStatement();
                        String student_id = RS.getString("student_id");

                        RS2 = Stmt2.executeQuery("select user_userName from student where id=" + "'" + student_id + "'");
                        RS2.next();
                        out.print(RS2.getString("user_userName"));


                    %>
                </td>
                <td>
                    <form action="Deleteappointment" >
                        <%  out.print("<input type='hidden' name='check' value='cancel'>");
                            out.print("<input type='hidden' name='appointment_id' value=" + RS.getString("appointment.id") + ">");
                            out.print("<input type='submit' value='Cancel'>");

                        %>
                    </form>

                </td>
            </tr>
            <%}

                    }
                } catch (SQLException ex) {
                    StringWriter sw = new StringWriter();
                    PrintWriter pw = new PrintWriter(sw);
                    ex.printStackTrace(pw);
                    String stackTrace = sw.toString();
                    String replace = stackTrace.replace(System.getProperty("line.separator"), "<br/>\n");
                    out.println(replace);
                }%>

        </table>
    </body>
</html>
<% }%>