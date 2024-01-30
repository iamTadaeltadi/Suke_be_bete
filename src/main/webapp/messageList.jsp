<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <title>Message List</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }

        h2 {
            color: #333;
        }

        p {
            background-color: #fff;
            padding: 10px;
            border: 1px solid #ddd;
            margin: 5px 0;
            border-radius: 5px;
        }

        .no-messages {
            color: #777;
        }
    </style>
</head>
<body>

<h2>Message List</h2>

<%
    // Retrieve the list of messages from the session
    List<String> messages = (List<String>) session.getAttribute("MessageList");

    // Display the messages
    if (messages != null && !messages.isEmpty()) {
        for (String message : messages) {
            out.println("<p>" + message + "</p>");
        }
    } else {
        out.println("<p class=\"no-messages\">No messages found.</p>");
    }
%>

</body>
</html>
