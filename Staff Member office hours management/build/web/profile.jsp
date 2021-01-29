<%-- 
    Document   : profile
    Created on : Dec 31, 2020, 2:22:35 AM
    Author     : user
--%>

<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.sql.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);

  if( session.getAttribute("session_username")==null)
      response.sendRedirect("index.jsp");
  else{
  %> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <!--        <title>Login form using Material Design - Demo by W3lessons</title>-->
        <!-- CORE CSS-->
        <title>My Profile</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.1/css/materialize.min.css">
        <link rel="stylesheet" href="nav.css" >
        <style type="text/css">
            html,
            body {
                height: 100%;

            }
            html {
                display: table;
                margin: auto;
            }
             #my_button{
                background: #4CAF50;
            }
            body {
                display: table-cell;
                vertical-align: middle;
            }
            .margin {
                margin: 0 !important;
            }

        </style>
    </head>
    <%
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/internetproject";
        String user = "root";
        String password = "root";
        String Line;
        Connection Con = null;
        Statement Stmt = null;
        ResultSet RS = null;
        String username = session.getAttribute("session_username").toString();
        String mytype = session.getAttribute("session_userType").toString();
        String email = null;
        String disName = null;
        try {
            Con = DriverManager.getConnection(url, user, password);
            Stmt = Con.createStatement();
            RS = Stmt.executeQuery("SELECT * FROM user WHERE userName='" + username + "';");
            RS.first();
            email = RS.getString("userEmail");
            RS.first();
            disName = RS.getString("displayName");
            RS.close();
            Stmt.close();
            Con.close();
        } catch (Exception e) {
            out.print(e);
        }

    %>
    <body >
        <%     if (mytype.equals("staff")) { %>
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
        <%} %>

        <div class="main">
            <div class="col s12 z-depth-6 card-panel" style="width:700px;">
                <form  action="updateInfo.jsp">
                    <div class="row margin">
                        <div class="input-field col s12 center">
                            <p ><h5>Account Information</h5></p>

                            <div>
                                <p style="  font-size: 20px; color: rgb(136,136,136);">Display Name:</p>
                                <div class="card-panel" style="  font-size: 25px;"><%out.print(disName);%></div>
                                <p style="  font-size: 20px; color: rgb(136,136,136);" >User Name:</p>
                                <div class="card-panel" style="  font-size: 25px;"><%out.print(username);%></div>
                                <p style="  font-size: 20px; color: rgb(136,136,136);">Email:</p>
                                <div class="card-panel" style="  font-size: 25px;"><%out.print(email);%></div>    
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12">
                            <input id="my_button" type="submit" class="btn waves-effect waves-light col s12" value="Update information"/>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </body>
</html>
<% }%>