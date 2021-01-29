<%-- 
   Document   : LogIn
   Created on : Dec 29, 2020, 3:11:13 AM
   Author     : user
--%>
 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <script type="text/javascript">

        function Auth() {
            var username = document.getElementById("username").value;
            var password = document.getElementById("password").value;
             if (username==""||password == "") {
                alert("Please fill all fields!");
                return false;
            } 
            else{
            var xmlhttp = new XMLHttpRequest();

            xmlhttp.open("GET", "loginValidate?username=" + username + "&" + "password=" + password, true);
            xmlhttp.send();

            xmlhttp.onreadystatechange = function ()
            {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                {
                    let check = xmlhttp.responseText;

                    if (check == "") {
                        location = 'profile.jsp';
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
        <title>Login</title>
        <!-- CORE CSS-->

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.1/css/materialize.min.css">

        <style type="text/css">
            html,
            body {
                height: 100%;
                background: #4CAF50;
            }
            #my_button{
                background: #4CAF50;
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
    </head>

    <body>
        <div id="login-page" class="row">
            <div class="col s12 z-depth-6 card-panel">
                <form class="login-form">
                    <div class="row">
                        <div class="input-field col s12 center">
                            <img src="http://w3lessons.info/logo.png" alt="" class="responsive-img valign profile-image-login">
                            <p class="center login-form-text">Welcome to Staff - Student Manager</p>
                        </div>
                    </div>
                    <div class="row margin">
                        <div class="input-field col s12">
                            <i class="mdi-social-person-outline prefix"></i>
                            <input id="username" name="username" type="text" placeholder="Username" class="validate">

                        </div>
                    </div>
                    <div class="row margin">
                        <div class="input-field col s12">
                            <i class="mdi-action-lock-outline prefix"></i>
                            <input id="password" name="password" type="password" placeholder="Password">
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12">
                            <input id="my_button" class="btn waves-effect waves-light col s12" type="button" onclick="Auth()"  value="Login"/>
                            <td><div id="show_response"></div></td>
                            <!--                            <a href="profile.jsp" class="btn waves-effect waves-light col s12">Login</a>-->
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s6 m6 l6">
                            <p class="margin medium-small"><center><a href="SignUp.jsp">Register Now!</a></center></p>
                        </div>         
                    </div>
                </form>
            </div>
        </div>
    </body>

</html>