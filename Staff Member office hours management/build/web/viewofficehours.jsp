<%-- 
    Document   : viewofficehours
    Created on : Jan 2, 2021, 1:13:35 AM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import ="java.io.PrintWriter"%>
<%@page import ="java.io.StringWriter" %>
<%@page import=" javax.servlet.http.HttpSession"%>
<!DOCTYPE html
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
    <link rel="stylesheet" href="nav.css" 
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.1/css/materialize.min.css">

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
    <script type="text/javascript">

        function viewoffice() {
            var Staff_name = document.getElementById("myInput").value;



            var xmlhttp = new XMLHttpRequest();

            xmlhttp.open("GET", "findOfficeHours.jsp?myInput=" + Staff_name, true);
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
    <%            String myType = session.getAttribute("session_userType").toString();
        if (myType.equals("student")) {%>
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
    <div id ="content" >
        <form onkeyup="viewoffice()">
            <input type="text" id="myInput"  placeholder="Search for office hours schedule for the staff member.." title="Type in a name">

        </form>
        <table id="myTable">
            <tr class="header">
                <th style="width:20%;">Staff Name</th>
                <th style="width:20%;">Slot</th>
                <th style="width:20%;">Type</th>
                <th style="width:20%;">From</th>
                <th style="width:20%;">To</th>
                <th style="width:20%;">Reserve</th>

            </tr>

        </table>
    </div>
    <% }%>

</body>
</html>
<% }%>