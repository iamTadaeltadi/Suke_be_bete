<!DOCTYPE html>
<html>
	<head>
		
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
	</head>
	<body>
		<form action="EmailServlet" method="post">
			<div align="center"> <h1>Enter the Credentials: </h1>
			<input type="hidden" name="action" value="add">
			
			
			
			
			
			
			
			<label for="sub">Subject :</label> <br>
			<input id="sub" type="text" name="subject"> <br>
			
			<label for="message">Message :</label> <br>
			<input id="message" type="text" name="message"><br>
			<input type="submit" value="Send">
			
			</div>
		</form>
	</body>
</html>
