<%-- 
    Document   : viewcontact
    Created on : Jan 2, 2021, 1:13:35 AM
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

        <title>Office Hours</title>
        <style>


            #content{
                margin-left: 230px;
                margin-top: 20px;
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

            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;

            String userName = session.getAttribute("session_username").toString();

            try {
                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();
                String line = null;

                line = "SELECT * FROM officehours inner join staff on staff.id=officehours.staff_id And staff.user_userName=" + "'" + userName + "'";

                try {
                    RS = Stmt.executeQuery(line);
                } catch (SQLException ex) {
                    StringWriter sw = new StringWriter();
                    PrintWriter pw = new PrintWriter(sw);
                    ex.printStackTrace(pw);
                    String stackTrace = sw.toString();
                    String replace = stackTrace.replace(System.getProperty("line.separator"), "<br/>\n");
                    out.println(replace);
                }


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
        <div id="content">
            <h3>My Office Hours:</h3>
            <table id="myTable">
                <tr class="header">
                    <th style="width:20%;">Slot</th>
                    <th style="width:20%;">From</th>
                    <th style="width:20%;">To</th>
                    <th style="width:20%;">Type</th>
                    <th style="width:20%;">Delete</th>
                    <th style="width:20%;">Update</th>


                </tr>
                <%        while (RS.next()) {%>
                <tr>
                    <td>
                        <%

                            out.print(RS.getString("slot"));
                        %>
                    </td>
                    <td>
                        <%
                            out.print(RS.getString("officehours.from"));
                        %>
                    </td>
                    <td>
                        <%
                            out.print(RS.getString("officehours.to"));
                        %>
                    </td>
                     <td>
                        <%
                            out.print(RS.getString("officehours.type"));
                        %>
                    </td>
                    <td>
                        <form action="DeleteOfficeHours">
                            <%
                                out.print("<input type='hidden' name='officeID' value=" + RS.getString("id") + ">");
                                out.print("<input type='submit' value='Delete'>");
                            %>
                        </form>
                    </td>
                    <td>
                        <form action="UpdateOfficeHoursForm.jsp">
                            <%
                                out.print("<input type='hidden' name='officeID' value=" + RS.getString("id") + ">");
                                out.print("<input type='submit' value='Update'>");
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

            <h3>Add New Office Hour</h3>

            <div class="container">
                <form action="addOfficeHours">
                    <label for="country">Slot</label>
                    <select id="country" name="slot">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>

                    </select>
                    
                     <label for="country">Type</label>
                    <select id="country" name="type">
                        <option value="Online">Online</option>
                        <option value="Offline">Offline</option>
                    </select>
                     
                    
                    <label for="lname">From</label>
                    <input type="datetime-local" name="from">
                    <label for="lname">To</label>
                    <input type="datetime-local" name="to">
                    <input type="submit" value="Add">
                </form>
            </div>
        </div>
    </body>
</html>
<% }%>