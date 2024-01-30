<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Client-Side JSP</title>
    <style>
        /* Add your styles for the alert here */
        .alert {
            display: none;
            position: fixed;
            top: 10px;
            right: 10px;
            padding: 15px;
            border: 1px solid #4CAF50;
            background-color: #4CAF50;
            color: #fff;
            border-radius: 5px;
            animation: fadeInOut 2s forwards;
        }

        @keyframes fadeInOut {
            0%, 100% {
                opacity: 0;
            }
            10%, 90% {
                opacity: 1;
            }
        }
    </style>
</head>
<body>

    <!-- JavaScript code to display the alert based on the request parameter -->
    <script>
        // Function to display the alert with a message
        function showAlert(message) {
            var alertElement = document.getElementById('customAlert');
            alertElement.innerHTML = message;
            alertElement.style.display = 'block';
            setTimeout(function () {
                alertElement.style.display = 'none';
            }, 2000); // Hide the alert after 2 seconds
        }

        // Check if the request parameter 'requestMessage' is present
        console.log("xxx")
        var requestMessage = '<%= request.getParameter("requestMessage") %>';
        if (requestMessage !== null && requestMessage !== '') {
            showAlert(requestMessage);
        }
    </script>

    <!-- The alert element -->
    <div id="customAlert" class="alert"></div>

    <!-- Your page content goes here -->

</body>
</html>
