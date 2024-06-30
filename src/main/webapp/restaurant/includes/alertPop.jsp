<%
    System.out.println("Session: " + session);
    System.out.println("Needs Update: " + session.getAttribute("needsUpdate"));
    if (session != null && session.getAttribute("needsUpdate") != null && request.getAttribute("hideAlert") == null) {
%>
<script>
    Swal.fire({
        title: '',
        text: 'Please update your restaurant details immediately.',
        icon: 'warning',
        allowOutsideClick: false,
        confirmButtonText: 'Update Now'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = 'AddRestaurant';
        }
    });
</script>
<%
    }
%>
