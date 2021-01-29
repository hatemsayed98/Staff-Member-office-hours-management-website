<%-- 
   Document   : LogIn
   Created on : Dec 29, 2020, 3:11:13 AM
   Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
 <%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);

  if(session.getAttribute("session_username")==null)
      response.sendRedirect("index.jsp");
  else{

  %> 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Login form using Material Design - Demo by W3lessons</title>
        <!-- CORE CSS-->

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.1/css/materialize.min.css">
        <link rel="stylesheet" href="nav.css" >
        <style type="text/css">
            html,
            body {
                height: 100%;
                width: 40%;
            }
            html {
                display: table;
                margin: auto;
            }
            body {
                display: table-cell;
                vertical-align: middle;
            }
            .margin {
                margin: 0 !important;
            }
             #my_button{
                background: #4CAF50;
            }
            
        </style>
        <script type="text/javascript">
            function validate() {
                var name = document.forms["myForm"]["displayName"].value;
                var password = document.forms["myForm"]["password"].value;
                var email = document.forms["myForm"]["email"].value;
                
                if (name == "" || password == "" || email=="") {
                    alert("Please fill all fields!");
                    return false;
                }


            }
        </script>
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
        String userName = session.getAttribute("session_username").toString();
        String userEmail = null;
        String disName = null;
        try {
            Con = DriverManager.getConnection(url, user, password);
            Stmt = Con.createStatement();
            RS = Stmt.executeQuery("SELECT * FROM user WHERE userName='" + userName + "';");
            RS.first();
            userEmail = RS.getString("userEmail");
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
        
        <%

            String type = session.getAttribute("session_userType").toString();

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
        <%} %>
        <div class="main">
            <div class="col s12 z-depth-6 card-panel" style="width:500px;">
                <form   name="myForm" action="updateUser"  onsubmit="return validate()" >
                    <div class="row">
                        <div class="input-field col s12 center">
                            <p class="center login-form-text">Update information</p>
                        </div>
                    </div>
                    <div class="row margin">
                        <div class="input-field col s12">
                            <i class="mdi-social-person-outline prefix"></i>
                            <input id="username" name="displayName" type="text" placeholder="New Display Name" value="<%out.print(disName);%>" class="validate">
                        </div>
                    </div>
                    <div class="row margin">
                        <div class="input-field col s12">
                            <i class="mdi-communication-email prefix"></i>
                            <input class="validate" name="email" id="email" placeholder="New Email" value="<%out.print(userEmail);%>" type="email">
                        </div>
                    </div>
                    <div class="row margin">
                        <div class="input-field col s12">
                            <i class="mdi-action-lock-outline prefix"></i>
                            <input id="password" name="password" type="password" placeholder="New Password">
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12">
                            <input id="my_button"  type="submit" class="btn waves-effect waves-light col s12" value="Confirm update"/>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </body>

</html>
<% }%>