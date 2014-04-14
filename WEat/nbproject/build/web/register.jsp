<%@ page language="java" 
    contentType="text/html; charset=windows-1256"
    pageEncoding="windows-1256"
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
            <meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
            
            <title>Register</title>
            <link href="css/bootstrap.css" rel="stylesheet">
            <link href="css/signin.css" rel="stylesheet">
	</head>

	<body>
            
            <div class="container">
                
                <div class="header">
                <center>
                <h3 class="text-muted">WEat</h3>
                </center>
                </div>
                
                <div>
		<form class="form-login" action="RegisterServlet" method ="POST">
                    <input type="hidden" name="pagename" value="register"/>
                    <center>
                    <h2 class="form-login-heading">Please register</h2>
                    </center>
                    <input type="text" name="username" class="form-control" placeholder="Username" required autofocus>
                    <input type="text" name="email" class="form-control" placeholder="Email" required>
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                    <button class="btn btn-lg btn-primary btn-block" type="submit" value="submit">Sign Up</button>
		</form>
                </div>
                
            </div>
	</body>
        
        <script src="js/transition.js" type="text/javascript"></script>
</html>



