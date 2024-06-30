


</section>


</section>

<script>
	function toggleView(view) {
		const gridView = document.querySelector('.grid-view');
		const tableView = document.querySelector('.table-view');
		const gridButton = document
				.querySelector('.toggle-buttons button:nth-child(1)');
		const tableButton = document
				.querySelector('.toggle-buttons button:nth-child(2)');

		if (view === 'grid') {
			gridView.classList.add('active');
			tableView.classList.remove('active');
			gridButton.classList.add('active');
			tableButton.classList.remove('active');
		} else {
			tableView.classList.add('active');
			gridView.classList.remove('active');
			tableButton.classList.add('active');
			gridButton.classList.remove('active');
		}
	}
</script>

</body>

</html>