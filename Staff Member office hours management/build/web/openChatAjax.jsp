<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import ="java.io.PrintWriter"%>
<%@page import ="java.io.StringWriter" %>
<%@page import=" javax.servlet.http.HttpSession"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("session_username") == null)
        response.sendRedirect("index.jsp");
    else {

%> 

<%    String sender = request.getParameter("sender");
    String receiver = request.getParameter("receiver");
    String url = "jdbc:mysql://localhost:3306/internetproject";
    String user = "root";
    String password = "root";

    Connection Con = null;
    Statement Stmt = null;
    ResultSet RS = null;
    Statement Stmt2 = null;
    ResultSet RS2 = null;
    String line = null;

    String time = new Timestamp(System.currentTimeMillis()).toString();

    boolean group = false;
    try {
        Con = DriverManager.getConnection(url, user, password);
        Stmt = Con.createStatement();
        Stmt2 = Con.createStatement();
        String line2 = "select * from subject where name=" + "'" + receiver + "'";
        RS2 = Stmt2.executeQuery(line2);
        if (!RS2.next()) {
            line = "select * from message  where sender=" + "'" + sender
                    + "' and receiver=" + "'" + receiver + "'or sender=" + "'" + receiver + "' and  receiver=" + "'" + sender + "' order by id asc ";
        } else {
            line = "select * from message where receiver=" + "'" + receiver + "'";
            group = true;
        }
        RS = Stmt.executeQuery(line);


%>


<div class="col-md-8 col-xl-6 chat">
    <div class="card" style = "width:700px">

        <div class="card-header msg_head" style="background: DimGrey;">
            <div class="d-flex bd-highlight">
                <div class="img_cont">
                    <img src="user.png"
                         class="rounded-circle user_img">
                </div>
                <div class="user_info">
                    <span><%= receiver%></span>
                </div>
            </div>
        </div>



        <div class="card-body msg_card_body" id="chat">

            <%
                while (RS.next()) {

                    if (RS.getString("sender").equals(sender)) {%>
            <div class="d-flex justify-content-end mb-4">

                <div class="msg_cotainer_send">

                    <% if (group) {%>
                    <%= sender + ":"%>
                    <br>
                    <%=RS.getString("content")%>
                    <%} else {%>
                    <%= RS.getString("content")%> <% }%>
                    <span class="msg_time"  style="  position: absolute; width: 100px;  right:-5px;  bottom: -15px; color: rgba(255,255,255,0.5); font-size: 10px;"><%= RS.getString("time")%></span>


                </div>

            </div>

            <%  } else {%>
            <div class="d-flex justify-content-start mb-4">
                <div class="msg_cotainer">

                    <% if (group) {%>
                    <%=RS.getString("sender")%>:

                    <br>
                    <%=RS.getString("content")%>
                    <%} else {%>
                    <%= RS.getString("content")%> <% }%>
                    <span class="msg_time" style="  position: absolute; width: 100px; left:-5px;  bottom: -15px; color: rgba(255,255,255,0.5); font-size: 10px;"><%= RS.getString("time")%></span>

                </div>

            </div>


            <% }

                }%>
        </div>

        <div class="card-footer" style="background: DimGrey;">
            <div class="input-group">
                <textarea id="content" class="form-control type_msg" placeholder="Type your message..."></textarea>
                <div class="input-group-append">
                    <span class="input-group-text send_btn" onclick="sendmessage('<%=sender%>', '<%=receiver%>', '<%=time%>');"><i class="fas fa-location-arrow"></i></span>
                </div>
            </div>
        </div>




    </div>
</div> 
<%} catch (SQLException ex) {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            ex.printStackTrace(pw);
            String stackTrace = sw.toString();
            String replace = stackTrace.replace(System.getProperty("line.separator"), "<br/>\n");
            out.println(replace);
        }
    }%>
