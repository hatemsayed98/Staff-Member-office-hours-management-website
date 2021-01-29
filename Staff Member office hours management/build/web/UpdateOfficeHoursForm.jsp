<%-- 
    Document   : UpdateOfficeHoursForm
    Created on : Jan 2, 2021, 4:55:39 AM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession" %>
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
        <title>Update Office Hours</title>
        <link rel="stylesheet" href="nav.css" >

        <style>
            #content{
                margin-left: 230px;
                margin-top: 20px;
                margin-right: 20px;
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

        <%String OfficeID = request.getParameter("officeID");%>

        <div id="content">

            <h3>Update Office Hour</h3>
            <div class="container">
                <form action="UpdateOfficeHours">
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
                    <input type='hidden' name='officeID' value="<%=OfficeID%>">
                    <input type="submit" value="Update">
                </form>
            </div>
        </div>
    </body>
</html>
<%}%>