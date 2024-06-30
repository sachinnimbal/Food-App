
<%@ include file="alertPop.jsp"%>


</section>


</section>



<script>
window.onload = function() {
    var now = new Date();
    var oneHourLater = new Date(now.getTime() + 60 * 60 * 1000); // Adds 1 hour to current time

    // Format the current and one hour later times to HH:MM for the time input
    var formattedHour = now.getHours().toString().padStart(2, '0');
    var formattedMinutes = now.getMinutes().toString().padStart(2, '0');
    var minTime = formattedHour + ':' + formattedMinutes; // Current time as minimum time

    var formattedMaxHour = oneHourLater.getHours().toString().padStart(2, '0');
    var formattedMaxMinutes = oneHourLater.getMinutes().toString().padStart(2, '0');
    var maxTime = formattedMaxHour + ':' + formattedMaxMinutes; // One hour from now as maximum time

    // Set attributes for the time input
    var estimatedTimeInput = document.getElementById('estimatedDeliveryTime');
    estimatedTimeInput.min = minTime;
    estimatedTimeInput.max = maxTime;
};
</script>


</body>

</html>