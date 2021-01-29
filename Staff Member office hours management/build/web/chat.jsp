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
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <title>Chat</title>
        <link href="style.css" rel="stylesheet" id="bootstrap-css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="nav.css" >
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.1/css/materialize.min.css">

        <style>
            body{
                background: white;
            }
        </style>

        <script>
            function openchat(sender, receiver) {

                var xmlhttp = new XMLHttpRequest();

                xmlhttp.open("GET", "openChatAjax.jsp?sender=" + sender + "&" + "receiver=" + receiver, true);
                xmlhttp.send();

                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        let check = xmlhttp.responseText;

//                        if (check == "") {
//                            location = 'chat.jsp';
//                        }
                        document.getElementById("show_response").innerHTML = check;

                    }
                }


            }

            function sendmessage(sender, receiver, time) {
                var content = document.getElementById("content").value;
                document.getElementById("content").value = "";
                var xmlhttp = new XMLHttpRequest();

                xmlhttp.open("GET", "sendMessageAjax?sender=" + sender + "&" + "receiver=" + receiver + "&" + "content=" + content + "&" + "time=" + time, true);
                xmlhttp.send();

                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        let check = xmlhttp.responseText;
                        console.log(check);
                        document.getElementById("chat").insertAdjacentHTML('beforeend', this.responseText);



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
        <%} %>
        <div class="container-fluid h-100" >
            <div class="row justify-content-center h-100" >
                <div class="col-md-4 col-xl-3 chat main" >
                    <div class="card mb-sm-3 mb-md-0 contacts_card" >
                        <div class="card-header" style="background: DimGrey;"></div>
                        <div class="card-body contacts_body"style="background: DimGrey;" >
                            <ui class="contacts" >
                                <%

                                    String url = "jdbc:mysql://localhost:3306/internetproject";
                                    String user = "root";
                                    String password = "root";

                                    Connection Con = null;
                                    Statement Stmt = null;
                                    ResultSet RS = null;
                                    String myType = session.getAttribute("session_userType").toString();
                                    String username = session.getAttribute("session_username").toString();

                                    try {
                                        Con = DriverManager.getConnection(url, user, password);
                                        Stmt = Con.createStatement();
                                        if (myType.equals("staff")) {

                                            String line = "select id from staff where user_userName=" + "'" + username + "'";
                                            RS = Stmt.executeQuery(line);
                                            RS.next();
                                            String staff_id = RS.getString("id");
                                            line = "Select * from user where userName!=" + "'" + username + "'";
                                            RS = Stmt.executeQuery(line);
                                            while (RS.next()) {
                                                String receiver = RS.getString("userName");


                                %>

                                <li  onclick="openchat('<%=username%>', '<%=receiver%>');">
                                    <div class="d-flex bd-highlight">
                                        <div class="img_cont">

                                            <img src="user.png"
                                                 class="rounded-circle user_img">
                                        </div>
                                        <div class="user_info">
                                            <span><%=RS.getString("userName")%></span>
                                        </div>
                                    </div>
                                </li>
                                <%}
                                    String line2 = "select * from staff_has_subject where staff_id=" + "'" + staff_id + "'";
                                    RS = Stmt.executeQuery(line2);
                                    while (RS.next()) {

                                        String receiver = RS.getString("subject_name");
                                %>

                                <li  onclick="openchat('<%=username%>', '<%=receiver%>');">
                                    <div class="d-flex bd-highlight">
                                        <div class="img_cont">
                                            <img src="group.jpg"
                                                 class="rounded-circle user_img">
                                        </div>
                                        <div class="user_info">
                                            <span><%=RS.getString("subject_name")%></span>
                                        </div>
                                    </div>
                                </li>
                                <%}
                                } else {

                                    String line = "Select * from staff";
                                    RS = Stmt.executeQuery(line);
                                    while (RS.next()) {

                                        String receiver = RS.getString("user_userName");

                                %>

                                <li  onclick="openchat('<%=username%>', '<%=receiver%>');">
                                    <div class="d-flex bd-highlight">
                                        <div class="img_cont">
                                            <img src="user.png"
                                                 class="rounded-circle user_img">
                                        </div>
                                        <div class="user_info">
                                            <span><%=RS.getString("user_userName")%></span>
                                        </div>
                                    </div>
                                </li>
                                <%}

                                        }
                                    } catch (SQLException ex) {
                                        StringWriter sw = new StringWriter();
                                        PrintWriter pw = new PrintWriter(sw);
                                        ex.printStackTrace(pw);
                                        String stackTrace = sw.toString();
                                        String replace = stackTrace.replace(System.getProperty("line.separator"), "<br/>\n");
                                        out.println(replace);
                                    }


                                %>

                            </ui>
                        </div>
                        <div class="card-footer" style="background: DimGrey;"></div>
                    </div>

                </div>


                <!--                  start of right-->

                <div class="col-md-8 col-xl-6 chat" id="show_response">


                </div> 
                <!--                  end of right              -->














            </div>
        </div>


    </body>
</html>
<% }%>