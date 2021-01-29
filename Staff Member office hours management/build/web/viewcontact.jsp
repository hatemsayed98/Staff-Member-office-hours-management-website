<%-- 
    Document   : viewcontact
    Created on : Jan 2, 2021, 1:13:35 AM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        <title>Find contact</title>

        <style>

            #myInput {
                background-image: url('https://www.w3schools.com/css/searchicon.png');
                background-position: 10px 12px; /* Position the search icon */
                background-repeat: no-repeat; /* Do not repeat the icon image */
                width: 75.5%; /* Full-width */
                font-size: 16px; /* Increase font-size */
                padding: 12px 20px 12px 40px; /* Add some padding */
                border: 1px solid #ddd; /* Add a grey border */
                margin-bottom: 12px; /* Add some space below the input */
                margin-left: 230px;
                margin-top: 20px;

            }

            #myTable {
                border-collapse: collapse; /* Collapse borders */
                width: 80%; /* Full-width */
                border: 1px solid #ddd; /* Add a grey border */
                font-size: 18px; /* Increase font-size */
                margin-left: 230px;

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


        </style>
        <script type="text/javascript">

            function viewcontact() {
                var Staff_name = document.getElementById("myInput").value;



                var xmlhttp = new XMLHttpRequest();

                xmlhttp.open("GET", "findContactAjax.jsp?myInput=" + Staff_name, true);
                xmlhttp.send();

                xmlhttp.onreadystatechange = function ()
                {

                    // console.log(xmlhttp.responseText);
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {


                        let check = xmlhttp.responseText;


                        document.getElementById("myTable").innerHTML = check;
                    }

                }
            }
        </script>
    </head>
    <body>
        <%            String type = session.getAttribute("session_userType").toString();

            if (type.equals("staff")) { %>
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
        <%} else {%>
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
        <%}%>

        <form onkeyup="viewcontact()">
            <input type="text" id="myInput"  placeholder="Search for contact.." title="Type in a name">

        </form>
        <table id="myTable">
            <tr class="header">
                <th style="width:50%;">Name</th>
                <th style="width:50%;">Email</th>

            </tr>
            <tr>

            </tr>

        </table>
    </body>
</html>
<% }%>