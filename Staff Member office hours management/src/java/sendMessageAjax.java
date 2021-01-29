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
import java.util.Date;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author LENOVO
 */
@WebServlet(urlPatterns = {"/sendMessageAjax"})
public class sendMessageAjax extends HttpServlet {

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
            String sender = request.getParameter("sender");
            String receiver = request.getParameter("receiver");
            String content = request.getParameter("content");
            String not_content = null;
            String url = "jdbc:mysql://localhost:3306/internetproject";
            String user = "root";
            String password = "root";

            String time = request.getParameter("time");

            Connection Con = null;
            PreparedStatement preStmt = null;
            ResultSet RS = null;
            Statement Stmt = null;
            javaMail mail = new javaMail();

            try {
                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();

                String line = "INSERT INTO message(content,sender,receiver,time) VALUES(?,?,?,?);";
                preStmt = Con.prepareStatement(line);

                preStmt.setString(1, content);
                preStmt.setString(2, sender);
                preStmt.setString(3, receiver);
                preStmt.setString(4, time);
                int Row = preStmt.executeUpdate();

                RS = Stmt.executeQuery("select * from staff where user_userName=" + "'" + receiver + "'");

                if (RS.next()) {
                    RS = Stmt.executeQuery("select * from user where userName=" + "'" + receiver + "'");
                    RS.next();
                    String staff_mail = RS.getString("userEmail");
                    not_content = "You have a new message!\n"
                            + "From: " + sender + ",\n"
                            + "Message: " + content;

                    line = "INSERT INTO notification(content,userName) VALUES(?,?);";
                    preStmt = Con.prepareStatement(line);
                    preStmt.setString(1, not_content);
                    preStmt.setString(2, receiver);
                    Row = preStmt.executeUpdate();
                     mail.sendMail(staff_mail, "New message arrived", not_content);

                }
                RequestDispatcher rd = request.getRequestDispatcher("sendMessageAjax.jsp");
                rd.forward(request, response);
            } catch (SQLException ex) {
                StringWriter sw = new StringWriter();
                PrintWriter pw = new PrintWriter(sw);
                ex.printStackTrace(pw);
                String stackTrace = sw.toString();
                String replace = stackTrace.replace(System.getProperty("line.separator"), "<br/>\n");
                out.println(replace);
            } catch (Exception ex) {
                Logger.getLogger(sendMessageAjax.class.getName()).log(Level.SEVERE, null, ex);
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
