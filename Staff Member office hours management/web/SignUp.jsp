<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="net.tanesha.recaptcha.ReCaptcha" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaFactory" %>


<html>
    <script type="text/javascript">

        function sendajax() {
            var captcha = document.getElementById("g-recaptcha-response").value;
            var email = document.getElementById("email").value;
            var name = document.getElementById("username").value;
            var displayName = document.getElementById("displayname").value;
            var type = document.getElementById("type").value;
            var type_check = type.toLowerCase();
            if (type_check != "dr" && type_check != "ta" && type_check != "student") {
                alert("Invaild type");
                return false;
            }
            if (captcha == "" || email == "" || name == "" || displayName == "") {
                alert("Please fill all fields!");
                return false;
            } else {

                var xmlhttp = new XMLHttpRequest();

                xmlhttp.open("GET", "signUpAjax?username=" + name + "&" + "email=" + email + "&" + "displayname=" + displayName + "&" + "g-recaptcha-response=" + captcha + "&" + "type_check=" + type_check, true);

                xmlhttp.send();

                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        let check = xmlhttp.responseText;

                        if (check == "") {
                            alert("Created successfully");
                            location = 'index.jsp';
                        }
                        document.getElementById("show_response").innerHTML = check;
                    }
                }
            }
        }
    </script>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>SignUp</title>
        <!-- CORE CSS-->

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.1/css/materialize.min.css">

        <style type="text/css">
            html,
            body {
                height: 100%;
                background: LightSeaGreen;
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
            #show_response{
                color: red;

            }
        </style>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    </head>
    <body >

        <div id="login-page" class="row">
            <div class="col s12 z-depth-6 card-panel">
                <form class="login-form" >
                    <center>  <img src="http://w3lessons.info/logo.png" width="150" height="150" alt="" class="responsive-img valign profile-image-login">
                        <p class="center login-form-text">Welcome to Staff - Student Manager </p>


                    </center>

                    <div class="row margin">
                        <div class="input-field col s12">
                            <i class="mdi-social-person-outline prefix"></i>
                            <input id="username" name="username" type="text" placeholder="Username" class="validate">

                        </div>
                    </div>
                    <div class="row margin">
                        <div class="input-field col s12">
                            <i class="mdi-social-person-outline prefix"></i>
                            <input id="displayname" name="displayname" type="text" placeholder="Display name" class="validate">

                        </div>
                    </div>

                    <div class="row margin">
                        <div class="input-field col s12">
                            <i class="mdi-communication-email prefix"></i>
                            <input id="email" type="email" name="email" placeholder="Email" class="validate">
                        </div>
                    </div>
                    <div class="row margin">
                        <div class="input-field col s12">
                            <i  class="mdi-social-group prefix"></i>
                            <input id="type" name="type" type="text" placeholder="DR-Student-TA" class="validate">

                        </div>
                    </div>



                    <center><div class="g-recaptcha" data-sitekey="6Le9ixgaAAAAABUX9HeMX0Jliw8r8smtTisn2Lxm"></div></center>
                    <div class="row">
                        <div class="input-field col s12">

                            <input type="button"   class="btn waves-effect waves-light col s12" value="Register Now " onclick="sendajax()"/>
                            <td><div id="show_response"></div></td>

                        </div>

                        <div class="input-field col s12">

                            <p class="margin center medium-small sign-up">Already have an account? <a href="index.jsp">Login</a></p>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
