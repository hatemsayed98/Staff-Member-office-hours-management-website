<%-- 
    Document   : viewstudentappointment
    Created on : Jan 11, 2021, 2:27:54 AM
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
        <link rel="stylesheet" href="nav.css" >
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.1/css/materialize.min.css">


        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            #content{
                margin-left: 230px;
                margin-top: 20px;
                margin-right: 20px;
            }
            #myInput {
                background-image: url('https://www.w3schools.com/css/searchicon.png');
                background-position: 10px 12px; /* Position the search icon */
                background-repeat: no-repeat; /* Do not repeat the icon image */
                width: 100%; /* Full-width */
                font-size: 16px; /* Increase font-size */
                padding: 12px 20px 12px 40px; /* Add some padding */
                border: 1px solid #ddd; /* Add a grey border */
                margin-bottom: 12px; /* Add some space below the input */
            }

            #myTable {
                border-collapse: collapse; /* Collapse borders */
                width: 100%; /* Full-width */
                border: 1px solid #ddd; /* Add a grey border */
                font-size: 18px; /* Increase font-size */
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
            String Line;
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;
            session = request.getSession(true);
            String userName = session.getAttribute("session_username").toString();

            try {

                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();
                RS = Stmt.executeQuery("SELECT id FROM student WHERE user_userName=" + "'" + userName + "'");
                RS.next();
                String student_id = RS.getString("id");
                RS = Stmt.executeQuery("SELECT * FROM appointment WHERE student_id=" + "'" + student_id + "'");

            } catch (Exception cnfe) {
                System.err.println("Exception: " + cnfe);
            }
        %>
        <div class="sidenav">
            <a href="profile.jsp">Profile</a>
            <a href="chat.jsp">Chat</a>
            <a href="notification.jsp">Notification</a>
            <a href="viewsubject.jsp">Find subject</a>
            <a href="viewcontact.jsp">Find staff</a>
            <a href="viewofficehours.jsp">View office hours</a>
            <a href="viewstudentappointment.jsp">Appointments</a>
            <a href="SignOut">Sign out</a>
        </div>
        <div id="content">
            <h2>List of appointment</h2>
            <table id="myTable">
                <tr class="header">
                    <th style="width:25%;">Date</th>
                    <th style="width:25%;">Slot</th>
                    <th style="width:25%;">Staff Name</th>
                    <th style="width:25%;">Cancel</th>


                </tr>
                <%
                    while (RS.next()) {
                %>
                <tr>
                    <td>
                        <%                            String date = RS.getString("date");

                            out.print(date);
                        %>
                    </td>
                    <td>
                        <%
                            String slot = RS.getString("slot");

                            out.print(slot);
                        %>
                    </td>
                    <td>

                        <%
                            ResultSet RS2 = null;
                            Statement Stmt2 = null;
                            Con = DriverManager.getConnection(url, user, password);
                            Stmt2 = Con.createStatement();
                            RS2 = Stmt2.executeQuery("SELECT user_userName FROM staff WHERE id=" + "'" + RS.getString("staff_id1") + "'");
                            RS2.next();
                            String staff_name = RS2.getString("user_userName");
                            out.print(staff_name);
                        %>
                    </td>
                    <td>
                        <form action="Deleteappointment">

                            <%
                                String appointment_id = RS.getString("id");
                                out.print("<input type='hidden' name='check' value='cancel'>");
                                out.print("<input type='hidden' name='appointment_id' value=" + appointment_id + ">");
                                out.print("<input type='submit' value='Cancel'>");

                            %>
                        </form>
                    </td>


                </tr>
                <%}%>
                <%
                    RS.close();
                    Stmt.close();
                    Con.close();
                %>

            </table>
        </div>
    </body>
</html>
<% }%>