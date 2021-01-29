/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import org.json.JSONObject;

/**
 *
 * @author LENOVO
 */
@WebServlet(urlPatterns = {"/signUpAjax"})
public class signUpAjax extends HttpServlet {

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

                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();

                String name = request.getParameter("username");
                String displayName = request.getParameter("displayname");
                String email = request.getParameter("email");
                String type_check = request.getParameter("type_check");

                try {
                    String line = "SELECT userName FROM user WHERE userName=" + "'" + name + "'";
                    RS = Stmt.executeQuery(line);
                } catch (SQLException ex) {
                    StringWriter sw = new StringWriter();
                    PrintWriter pw = new PrintWriter(sw);
                    ex.printStackTrace(pw);
                    String stackTrace = sw.toString();
                    String replace = stackTrace.replace(System.getProperty("line.separator"), "<br/>\n");
                    out.println(replace);
                }

                if (RS.next()) {
                    out.print("Account already registered!");
                    Stmt.close();
                    Con.close();
                } else {

                    if (isCaptchaValid("6Le9ixgaAAAAAC3zQsotzacchfpzpZ0wCyvlm2J6", request.getParameter("g-recaptcha-response"))) {
                        try {
                            int Row = 0;
                            String line = null;
                            javaMail mail = new javaMail();
                            String UserPassword = mail.getPassword();
                            HttpSession session = request.getSession(true);
                            session.setAttribute("session_name", name);

                            Con = DriverManager.getConnection(url, user, password);
                            try {
                                line = "INSERT INTO user(userEmail,userName,password,displayName) VALUES(?,?,?,?);";
                                preStmt = Con.prepareStatement(line);

                                preStmt.setString(1, email);
                                preStmt.setString(2, name);
                                preStmt.setString(3, UserPassword);
                                preStmt.setString(4, displayName);
                                Row = preStmt.executeUpdate();
                            } catch (SQLException ex) {
                                StringWriter sw = new StringWriter();
                                PrintWriter pw = new PrintWriter(sw);
                                ex.printStackTrace(pw);
                                String stackTrace = sw.toString();
                                String replace = stackTrace.replace(System.getProperty("line.separator"), "<br/>\n");
                                out.println(replace);
                            }
                            try {
                                if (type_check.equals("student")) {
                                    line = "INSERT INTO student(user_userName) VALUES(?);";
                                    preStmt = Con.prepareStatement(line);
                                    preStmt.setString(1, name);

                                    Row = preStmt.executeUpdate();
                                } else {
                                    line = "INSERT INTO staff(user_userName,type) VALUES(?,?);";
                                    preStmt = Con.prepareStatement(line);
                                    preStmt.setString(1, name);
                                    preStmt.setString(2, type_check);

                                    Row = preStmt.executeUpdate();

                                }

                                String message = "Dear user,\n"
                                        + "Your email was provided for registration on Staff Member office hours management and you were successfully registered.\n"
                                        + "You can login into the system.\n"
                                        + "Kindly find your password :"
                                        + UserPassword + "\n"
                                        + "Visit this link http://localhost:8084/internetApplication/ any time to manage your profile."
                                        + "If it was not you, just ignore this letter.\n"
                                        + "Please DO NOT reply to this e-mail message. This is an automated response.";
                                mail.sendMail(email, "Registration Confirmation", message);
                                if (Row == 0) {
                                    out.print("not added");
                                }
                            } catch (SQLException ex) {
                                StringWriter sw = new StringWriter();
                                PrintWriter pw = new PrintWriter(sw);
                                ex.printStackTrace(pw);
                                String stackTrace = sw.toString();
                                String replace = stackTrace.replace(System.getProperty("line.separator"), "<br/>\n");
                                out.println(replace);
                            }

                            Stmt.close();
                            Con.close();
                        } catch (Exception ex) {

                            ex.printStackTrace();

                        }

                    }
                }

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

    public synchronized boolean isCaptchaValid(String secretKey, String response) {
        try {
            String url = "https://www.google.com/recaptcha/api/siteverify",
                    params = "secret=" + secretKey + "&response=" + response;

            HttpURLConnection http = (HttpURLConnection) new URL(url).openConnection();
            http.setDoOutput(true);
            http.setRequestMethod("POST");
            http.setRequestProperty("Content-Type",
                    "application/x-www-form-urlencoded; charset=UTF-8");
            OutputStream out = http.getOutputStream();
            out.write(params.getBytes("UTF-8"));
            out.flush();
            out.close();

            InputStream res = http.getInputStream();
            BufferedReader rd = new BufferedReader(new InputStreamReader(res, "UTF-8"));

            StringBuilder sb = new StringBuilder();
            int cp;
            while ((cp = rd.read()) != -1) {
                sb.append((char) cp);
            }
            JSONObject json = new JSONObject(sb.toString());
            res.close();

            return json.getBoolean("success");
        } catch (Exception e) {
            //e.printStackTrace();
        }
        return false;
    }
}
