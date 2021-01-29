<%-- 
    Document   : findSubjectAjax
    Created on : Jan 1, 2021, 7:22:35 PM
    Author     : LENOVO
--%>

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
<%    String url = "jdbc:mysql://localhost:3306/internetproject";
    String user = "root";
    String password = "root";

    Connection Con = null;
    Statement Stmt = null;
    ResultSet RS = null;

    String Staff_name = request.getParameter("myInput");
    String myType = session.getAttribute("session_userType").toString();
    String userName = session.getAttribute("session_username").toString();

    try {
        Con = DriverManager.getConnection(url, user, password);
        Stmt = Con.createStatement();
        String line = null;
        if (myType.equals("student")) {
            line = "SELECT staff_id,user_userName,slot,officehours.id,officehours.from,officehours.to,officehours.type FROM staff inner join officehours on staff.id=officehours.staff_id And staff.user_userName=" + "'" + Staff_name + "'";
            RS = Stmt.executeQuery(line); %>
<table>
    <tr class="header">

        <th style="width:20%;background-color: #f1f1f1;">Staff Name</th>
        <th style="width:20%;background-color: #f1f1f1;">Slot</th>
        <th style="width:20%;background-color: #f1f1f1;">Type</th>
        <th style="width:20%;background-color: #f1f1f1;">From</th>
        <th style="width:20%;background-color: #f1f1f1;">To</th>
        <th style="width:20%;background-color: #f1f1f1;">Reserve</th>

    </tr>
    <%        while (RS.next()) {%>
    <tr>
        <td>
            <%

                out.print(RS.getString("user_userName"));
            %>
        </td>
        <td>
            <%
                out.print(RS.getString("slot"));
            %>
        </td>
        <td>
            <%
                out.print(RS.getString("type"));
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
            <form action="reserveAppointment">
                <%
                    ResultSet RS2 = null;
                    Statement Stmt2 = null;
                    Con = DriverManager.getConnection(url, user, password);
                    Stmt2 = Con.createStatement();
                    RS2 = Stmt2.executeQuery("SELECT id FROM student WHERE user_userName=" + "'" + userName + "'");
                    RS2.next();
                    String student_id = RS2.getString("id");

                    RS2 = Stmt2.executeQuery("SELECT * FROM appointment WHERE slot=" + "'" + RS.getString("slot") + "' AND date=" + "'" + RS.getString("officehours.from") + "' AND staff_id1=" + "'" + RS.getString("staff_id") + "' AND student_id=" + "'" + student_id + "'");

                    if (!RS2.next()) {
                        out.print("<input type='hidden' name='office_id' value=" + RS.getString("officehours.id") + ">");
                        out.print("<input type='hidden' name='slot' value=" + RS.getString("slot") + ">");
                        out.print("<input type='hidden' name='staff_ID'  value=" + RS.getString("staff_id") + ">");
                        out.print("<input type='submit' value='Reserve'>");
                    } else {
                        out.print("<input type='submit' value='Already Reserved' disabled>");
                    }
                %>
            </form>

        </td>
    </tr>
    <%}%>

</table>

<%
    } else {
// line ="SELECT userName,userEmail FROM user inner join student on user.userName=student.user_userName And user.userName=" + "'" + userName + "'";
    }


%>



<%} catch (Exception cnfe) {
            System.err.println("Exception: " + cnfe);
        }
    }%>

