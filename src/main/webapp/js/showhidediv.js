/*
*显示和隐藏div
*下方方法调用这个方法
*/
function toggleVisibility(id) {
	const element = document.querySelector(`#${id}`);
	element.style.display = element.style.display === 'block' ? 'none' : 'block';
}

function showEdit() {
	// 显示 editdiv 的 div
	toggleVisibility('editDiv');
}

function hideEdit() {
	// 隐藏 editdiv 的 div
	toggleVisibility('editDiv');
}

function showChangePassword() {
	// 显示 changePassword 的 div
	toggleVisibility('changePassword');
}

function hideChangePassword() {
	// 隐藏 changePassword 的 div
	toggleVisibility('changePassword');
}
function editBook(id, title, author, publisher, publishDate, quantity) {
	document.getElementById('editId').value = id;
	document.getElementById('editTitle').value = title;
	document.getElementById('editAuthor').value = author;
	document.getElementById('editPublisher').value = publisher;
	document.getElementById('editPublishDate').value = publishDate;
	document.getElementById('editQuantity').value = quantity;
	toggleVisibility('editDiv');
}

function cancelEdit() {
	toggleVisibility('editDiv');
}