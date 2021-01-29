/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

/**
 *
 * @author LENOVO
 */
@WebServlet(urlPatterns = {"/Deleteappointment"})
public class Deleteappointment extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/internetproject";
                String user = "root";
                String password = "root";
                Connection Con = null;
                Statement Stmt = null;
                ResultSet RS = null;
                Statement Stmt2 = null;
                ResultSet RS2 = null;
                PreparedStatement preStmt = null;
                String line = null;
                javaMail mail = new javaMail();

                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();
                Stmt2 = Con.createStatement();
                String check = request.getParameter("check");
                if (check.equals("cancel")) {

                    String appointment_id = request.getParameter("appointment_id");
                    HttpSession session = request.getSession(true);
                    String myType = session.getAttribute("session_userType").toString();

                    String line2 = "select  * from appointment WHERE id=" + "'" + appointment_id + "'";
                    RS = Stmt.executeQuery(line2);

                    if (myType.equals("student")) {
                        RS.next();
                        String staff_id = RS.getString("staff_id1");
                        String slot = RS.getString("slot");
                        String date = RS.getString("date");
                        RS = Stmt.executeQuery("select * from staff where id=" + "'" + staff_id + "'");
                        RS.next();
                        String staffName = RS.getString("user_userName");
                        RS = Stmt.executeQuery("select * from user where userName=" + "'" + staffName + "'");
                        RS.next();
                        String staffemail = RS.getString("userEmail");

                        String username = session.getAttribute("session_username").toString();
                        String content = "Your appointment at slot " + slot + " at date " + date + " has been cancelled by the student " + username + ".";
                        try {
                            line = "INSERT INTO notification(content,userName) VALUES(?,?);";
                            preStmt = Con.prepareStatement(line);
                            preStmt.setString(1, content);
                            preStmt.setString(2, staffName);
                            int Row = preStmt.executeUpdate();
                        } catch (SQLException ex) {
                            StringWriter sw = new StringWriter();
                            PrintWriter pw = new PrintWriter(sw);
                            ex.printStackTrace(pw);
                            String stackTrace = sw.toString();
                            String replace = stackTrace.replace(System.getProperty("line.separator"), "<br/>\n");
                            out.println(replace);
                        }

                        out.print("<script type=text/javascript>"
                                + "alert('Deleted successfully');"
                                + "location='viewstudentappointment.jsp';"
                                + "</script>");
                        mail.sendMail(staffemail, "Reservation canceled", content);
                    } else {
                        RS.next();
                        String student_id = RS.getString("student_id");
                        String slot = RS.getString("slot");
                        String date = RS.getString("date");
                        RS = Stmt.executeQuery("select * from student where id=" + "'" + student_id + "'");
                        RS.next();
                        String studentname = RS.getString("user_userName");
                        RS = Stmt.executeQuery("select * from user where userName=" + "'" + studentname + "'");
                        RS.next();
                        String studentemail = RS.getString("userEmail");

                        String username = session.getAttribute("session_username").toString();
                        String content = "Your appointment at slot " + slot + " at date " + date + " has been cancelled by the staff " + username + ".";
                        line = "INSERT INTO notification(content,userName) VALUES(?,?);";
                        preStmt = Con.prepareStatement(line);
                        preStmt.setString(1, content);
                        preStmt.setString(2, studentname);
                        int Row = preStmt.executeUpdate();
                        out.print("<script type=text/javascript>"
                                + "alert('Deleted successfully');"
                                + "location='viewallstaffappointment.jsp';"
                                + "</script>");
                        mail.sendMail(studentemail, "Reservation canceled", content);

                    }
                    line = "DELETE  FROM appointment WHERE id=" + "'" + appointment_id + "'";
                    int Rows = Stmt.executeUpdate(line);
                } else {

                    String day = request.getParameter("day");
                    HttpSession session = request.getSession(true);
                    try {
                        String username = session.getAttribute("session_username").toString();
                        RS = Stmt.executeQuery("SELECT id from staff where user_userName=" + "'" + username + "'");
                    } catch (SQLException ex) {
                        StringWriter sw = new StringWriter();
                        PrintWriter pw = new PrintWriter(sw);
                        ex.printStackTrace(pw);
                        String stackTrace = sw.toString();
                        String replace = stackTrace.replace(System.getProperty("line.separator"), "<br/>\n");
                        out.println(replace);
                    }
                    RS.next();
                    String userid = RS.getString("id");

                    RS = Stmt.executeQuery("SELECT * from appointment where(date between " + "'" + day + " 00:00:00' and " + "'" + day + " 23:59:59') and staff_id1=" + "'" + userid + "'");

                    while (RS.next()) {

                        String student_id = RS.getString("student_id");
                        String slot = RS.getString("slot");
                        String date = RS.getString("date");
                        RS2 = Stmt2.executeQuery("select * from student where id=" + "'" + student_id + "'");
                        RS2.next();
                        
                        String studentname = RS2.getString("user_userName");
                        RS2 = Stmt2.executeQuery("select * from user where userName=" + "'" + studentname + "'");
                        RS2.next();
                        String studentemail = RS2.getString("userEmail");

                        String username = session.getAttribute("session_username").toString();
                        String content = "Your appointment at slot " + slot + " at date " + date + " has been cancelled by the staff " + username + ".";
                        line = "INSERT INTO notification(content,userName) VALUES(?,?);";
                        preStmt = Con.prepareStatement(line);
                        preStmt.setString(1, content);
                        preStmt.setString(2, studentname);
                        int Row = preStmt.executeUpdate();
                        mail.sendMail(studentemail, "Reservation canceled", content);

                    }
                    line = "Delete from appointment where(date between " + "'" + day + " 00:00:00' and " + "'" + day + " 23:59:59') and staff_id1=" + "'" + userid + "'";
                    int Rows = Stmt.executeUpdate(line);
                    out.print("<script type=text/javascript>"
                            + "alert('Deleted successfully');"
                            + "location='viewallstaffappointment.jsp';"
                            + "</script>");

                }
                Stmt.close();
                Con.close();

            } catch (Exception ex) {
                ex.printStackTrace();

            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
