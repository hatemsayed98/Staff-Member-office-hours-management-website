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
import java.text.SimpleDateFormat;

/**
 *
 * @author LENOVO
 */
@WebServlet(urlPatterns = {"/reserveAppointment"})
public class reserveAppointment extends HttpServlet {

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
                PreparedStatement preStmt = null;
                ResultSet RS = null;
                javaMail mail = new javaMail();

                HttpSession session = request.getSession(true);

                String userName = session.getAttribute("session_username").toString();

                String slot = request.getParameter("slot");
                String office_id = request.getParameter("office_id");
                String staff_id = request.getParameter("staff_ID");
                String content = null;

                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();
                 
                RS = Stmt.executeQuery("SELECT * FROM staff WHERE id=" + "'" + staff_id + "'");
                RS.next();
                String staff_name = RS.getString("user_userName");

                RS = Stmt.executeQuery("SELECT *  FROM user WHERE userName=" + "'" + staff_name + "'");
                RS.next();
                String staff_email = RS.getString("userEmail");
                RS = Stmt.executeQuery("SELECT officehours.from FROM officehours WHERE id=" + "'" + office_id + "'");
                RS.next();
                String date = RS.getString("officehours.from");
                RS = Stmt.executeQuery("SELECT id FROM student WHERE user_userName=" + "'" + userName + "'");
                RS.next();
                String student_id = RS.getString("id");
                try {
                    String line = "INSERT INTO appointment(date,slot,student_id,staff_id1) VALUES(?,?,?,?);";
                    preStmt = Con.prepareStatement(line);

                    preStmt.setString(1, date);
                    preStmt.setString(2, slot);
                    preStmt.setString(3, student_id);

                    preStmt.setString(4, staff_id);
                    int Row = preStmt.executeUpdate();
                    content = "An appointment with " + userName + " has been reserved at " + date + " in slot " + slot + ".";

                    line = "INSERT INTO notification(content,userName) VALUES(?,?);";
                    preStmt = Con.prepareStatement(line);

                    preStmt.setString(1, content);
                    preStmt.setString(2, staff_name);
                    Row = preStmt.executeUpdate();
                    mail.sendMail(staff_email, "Appointment reservation", content);

                } catch (SQLException ex) {
                    StringWriter sw = new StringWriter();
                    PrintWriter pw = new PrintWriter(sw);
                    ex.printStackTrace(pw);
                    String stackTrace = sw.toString();
                    String replace = stackTrace.replace(System.getProperty("line.separator"), "<br/>\n");
                    out.println(replace);
                }

                out.print("<script type=text/javascript>"
                        + "alert('Reserved successfully');"
                        + "location='viewofficehours.jsp';"
                        + "</script>");
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
