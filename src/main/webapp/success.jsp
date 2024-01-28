<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Order Success</title>
    <!-- Add your existing head content here -->

    <!-- Add your modal styles here -->
    <style>
        /* ... existing styles ... */

        .modal {
            /* ... modal styles ... */
        }

        .modal-content {
            /* ... modal content styles ... */
        }

        .update-button,
        .cancel-button {
            display: none;
            margin-top: 10px;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .update-button {
            background-color: #008CBA;
        }

        @keyframes fadeInOut {
            /* ... fadeInOut keyframes ... */
        }
    </style>

    <!-- Add your modal scripts here -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var confirmMessage = "<%= request.getAttribute("confirmMessage") %>";

            if (confirmMessage.includes("update") || confirmMessage.includes("cancel")) {
                var confirmModal = document.getElementById("confirmModal");
                if (confirmModal) {
                    confirmModal.style.display = "block";
                    confirmModal.querySelector(".confirmation-message").innerHTML = confirmMessage;

                    var updateButton = confirmModal.querySelector(".update-button");
                    var cancelButton = confirmModal.querySelector(".cancel-button");

                    // Display the "Update" and "Cancel" buttons
                    updateButton.style.display = "inline-block";
                    cancelButton.style.display = "inline-block";
                }
            } else {
                // If it's a success message, show the success modal with a timeout
                var successMessage = "<%= request.getAttribute("successMessage") %>";
                if (successMessage) {
                    var successModal = document.getElementById("successModal");
                    if (successModal) {
                        successModal.style.display = "block";
                        document.getElementById("successMessage").innerHTML = successMessage;

                        // Set timeout only for success modal
                        setTimeout(function() {
                            successModal.style.display = "none";
                            window.location.href = "index.jsp";
                        }, 2000);
                    }
                }
            }
        });
    </script>
</head>
<body>

<!-- ... existing body content ... -->

<!-- Confirmation Modal -->
<div id="confirmModal" class="modal">
    <div class="modal-content">
        <p class="confirmation-message"></p>
        <button class="update-button" style="display: none;">
<a href="<%= request.getContextPath() %>/editOrder?orderId=<%= session.getAttribute("orderId") %>&quantity=<%= session.getAttribute("quantity") %>">Update</a>
</button>
        

        <button class="cancel-button" style="display: none;">Cancel</button>
    </div>
</div>

<!-- Success Modal -->
<div id="successModal" class="modal">
    <div class="modal-content">
        <p id="successMessage"></p>
    </div>
</div>

<!-- ... existing body content ... -->

</body>
</html>
