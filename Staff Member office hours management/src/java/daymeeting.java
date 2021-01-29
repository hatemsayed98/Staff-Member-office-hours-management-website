/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(urlPatterns = {"/daymeeting"})
public class daymeeting extends HttpServlet {

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
                String date = java.time.LocalDate.now().toString();
                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();
                RS = Stmt.executeQuery("SELECT * from appointment where(date between " + "'" + date + " 00:00:00' and " + "'" + date + " 23:59:59')");
                while (RS.next()) {

                    Stmt2 = Con.createStatement();
                    RS2 = Stmt2.executeQuery("SELECT * FROM staff WHERE id=" + "'" + RS.getString("staff_id1") + "'");
                    RS2.next();
                    String staff_name = RS2.getString("user_userName");
                    RS2 = Stmt2.executeQuery("SELECT * FROM student WHERE id=" + "'" + RS.getString("student_id") + "'");
                    RS2.next();
                    String student_name = RS2.getString("user_userName");
                    RS2 = Stmt2.executeQuery("SELECT * FROM user WHERE userName=" + "'" + staff_name + "'");
                    RS2.next();
                    String staff_email = RS2.getString("userEmail");
                    RS2 = Stmt2.executeQuery("SELECT * FROM user WHERE userName=" + "'" + student_name + "'");
                    RS2.next();
                    String student_email = RS2.getString("userEmail");

                    String student_content = "You have an appointment today with " + staff_name + " that has been reserved at " + RS.getString("date") + " in slot" + RS.getString("slot") + ".";
                    String staff_content = "You have an appointment today with " + student_name + " that has been reserved at " + RS.getString("date") + " in slot" + RS.getString("slot") + ".";
                    line = "INSERT INTO notification(content,userName) VALUES(?,?);";
                    preStmt = Con.prepareStatement(line);
                    preStmt.setString(1, student_content);
                    preStmt.setString(2, student_name);
                    int Row = preStmt.executeUpdate();
                    line = "INSERT INTO notification(content,userName) VALUES(?,?);";
                    preStmt = Con.prepareStatement(line);
                    preStmt.setString(1, staff_content);
                    preStmt.setString(2, staff_name);
                    Row = preStmt.executeUpdate();
                    mail.sendMail(student_email, "Appointment today", student_content);

                    mail.sendMail(staff_email, "Appointment today", staff_content);

                }

            } catch (Exception e) {
                out.print(e);
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
