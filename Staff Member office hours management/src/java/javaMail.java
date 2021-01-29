/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author LENOVO
 */
import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class javaMail {

    private String temporaryPassword = "";

    public void sendMail(String receiver,String sending_subject, String sending_message) throws Exception {
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        String ourAccount = "savitarleo7@gmail.com";
        String ourPassword = "12345678leo";
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(ourAccount, ourPassword);
                //To change body of generated methods, choose Tools | Templates.
            }

        });

        Message message = getMessage(session, ourAccount, receiver,sending_subject, sending_message);
        Transport.send(message);

    }

    private Message getMessage(Session session, String ourAccount, String receiver,String sending_subject, String sending_message) {
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(ourAccount));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
            message.setSubject(sending_subject);
            message.setText(sending_message);


            return message;

        } catch (Exception ex) {
            System.out.print(ex);
        }
        return null;

    }

    private char[] generatePassword(int length) {
        String capitalCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
        String numbers = "1234567890";
        String combinedChars = capitalCaseLetters + lowerCaseLetters + numbers;
        Random random = new Random();
        char[] password = new char[length];

        password[0] = lowerCaseLetters.charAt(random.nextInt(lowerCaseLetters.length()));
        password[1] = capitalCaseLetters.charAt(random.nextInt(capitalCaseLetters.length()));
        password[2] = numbers.charAt(random.nextInt(numbers.length()));

        for (int i = 3; i < length; i++) {
            password[i] = combinedChars.charAt(random.nextInt(combinedChars.length()));
        }
        return password;
    }

    String getPassword() {
        return temporaryPassword = new String(generatePassword(8));
    }

}
/*

 try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(ourAccount));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(receiver)
            );
            message.setSubject("Testing Gmail TLS");
            message.setText("Dear Mail Crawler,"
                    + "\n\n Please do not spam my email!");

            Transport.send(message);

            System.out.println("Done");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
 */
