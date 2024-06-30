class DynamicTable {
	constructor(selector, options) {
		this.element = document.querySelector(selector);
		this.data = options.data || [];
		this.columns = options.columns;
		this.searchInput = document.querySelector(options.searchInput);
		this.rowsPerPageSelect = document.querySelector(options.rowsPerPageSelect);
		this.paginationContainer = document.querySelector(options.paginationContainer);
		this.paginationInfo = document.querySelector(options.paginationInfo);
		this.sortableColumns = options.sortableColumns || [];
		this.sortColumn = null;
		this.sortDirection = 'asc';

		this.currentPage = 1;
		this.rowsPerPage = parseInt(this.rowsPerPageSelect.value);
		this.totalPages = 0;
		this.filteredData = [];

		this.centerAlignedColumns = options.centerAlignedColumns || [];

		this.init();
	}

	init() {
		this.searchInput.addEventListener("input", () => {
			this.currentPage = 1;
			this.render();
		});

		this.rowsPerPageSelect.addEventListener("change", () => {
			this.rowsPerPage = parseInt(this.rowsPerPageSelect.value);
			this.currentPage = 1;
			this.render();
		});

		// Event listener for sorting
		this.element.addEventListener("click", (event) => {
			const columnHeader = event.target.closest("th");
			if (columnHeader && this.sortableColumns.includes(columnHeader.textContent)) {
				const columnName = columnHeader.textContent;
				if (this.sortColumn === columnName) {
					this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';
				} else {
					this.sortColumn = columnName;
					this.sortDirection = 'asc';
				}
				this.render();
			}
		});

		this.render();
	}

	setData(newData) {
		this.data = newData;
		this.render();
	}

	filterData() {
		const searchLower = this.searchInput.value.toLowerCase();
		this.filteredData = this.data.filter((row) =>
			Object.values(row).some((value) =>
				value.toString().toLowerCase().includes(searchLower)
			)
		);
	}

	sortData() {
		if (this.sortColumn) {
			const start = (this.currentPage - 1) * this.rowsPerPage;
			const end = start + this.rowsPerPage;
			const dataSlice = this.filteredData.slice(start, end);

			dataSlice.sort((a, b) => {
				const valueA = a[this.sortColumn];
				const valueB = b[this.sortColumn];
				if (this.sortDirection === 'asc') {
					return valueA > valueB ? 1 : valueA < valueB ? -1 : 0;
				} else {
					return valueA < valueB ? 1 : valueA > valueB ? -1 : 0;
				}
			});

			// Update the sorted data slice within the filtered data array
			this.filteredData.splice(start, dataSlice.length, ...dataSlice);
		}
	}


	updatePagination() {
		this.totalPages = Math.ceil(this.filteredData.length / this.rowsPerPage);
		this.paginationContainer.innerHTML = "";

		const createButton = (page, content) => {
			const button = document.createElement("button");
			button.textContent = content;
			button.disabled =
				page === this.currentPage || page < 1 || page > this.totalPages;
			button.addEventListener("click", () => {
				this.currentPage = page;
				this.render();
			});
			return button;
		};

		this.paginationContainer.appendChild(createButton(1, "<<"));
		this.paginationContainer.appendChild(
			createButton(this.currentPage - 1, "<")
		);

		const startPage = Math.max(this.currentPage - 2, 1);
		const endPage = Math.min(startPage + 4, this.totalPages);
		for (let page = startPage; page <= endPage; page++) {
			const button = createButton(page, page);
			if (page === this.currentPage) button.classList.add("active");
			this.paginationContainer.appendChild(button);
		}

		this.paginationContainer.appendChild(
			createButton(this.currentPage + 1, ">")
		);
		this.paginationContainer.appendChild(createButton(this.totalPages, ">>"));
	}

	render() {
		this.filterData();
		this.sortData(); // Call sort before rendering

		const start = (this.currentPage - 1) * this.rowsPerPage;
		const visibleData = this.filteredData.slice(
			start,
			start + this.rowsPerPage
		);

		// Check if visibleData is empty and display "No data available" message if true
		const tableContent =
			visibleData.length > 0
				? `<tbody>${visibleData
					.map(
						(row) =>
							`<tr>${this.columns
								.map((column) => {
									// Check if column needs to be center-aligned
									const alignment = this.centerAlignedColumns.includes(column) ? 'text-center' : '';
									return `<td class="${alignment}">${row[column]}</td>`;
								})
								.join("")}</tr>`
					)
					.join("")}</tbody>`
				: `<tbody><tr><td colspan="${this.columns.length}" style="text-align: center;">No data available</td></tr></tbody>`;

		// Render table headers with sorting icons
		const tableHeaders = this.columns.map(column => {
			let iconClass = '';
			if (this.sortableColumns.includes(column)) {
				if (column === this.sortColumn) {
					iconClass = this.sortDirection === 'asc' ? 'th-sort-asc' : 'th-sort-desc';
				} else {
					iconClass = ''; // No default arrow class for non-sorted columns
				}
			}
			return `<th class="${this.sortableColumns.includes(column) ? 'sortable' : ''} ${iconClass}" data-column="${column}">${column}</th>`;
		}).join('');

		this.element.innerHTML = `
        <thead>
            <tr>${tableHeaders}</tr>
        </thead>
        ${tableContent}`;

		const itemsShown = visibleData.length ? start + 1 : 0;
		this.paginationInfo.textContent = `Showing ${itemsShown} to ${start + visibleData.length
			} of ${this.filteredData.length}`;
		this.updatePagination();
	}
}