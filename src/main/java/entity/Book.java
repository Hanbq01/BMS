package entity;

public class Book {
	// 图书编号
	public int id;
	// 书名
	public String title;
	// 作者
	public String author;
	// 出版社
	public String publisher;
	// 出版日期
	public String publishDate;
	// 库存数量
	public int quantity;

	// 构造方法
	public Book(int id, String title, String author, String publisher, String publishDate, int quantity) {
		this.id = id;
		this.title = title;
		this.author = author;
		this.publisher = publisher;
		this.publishDate = publishDate;
		this.quantity = quantity;
	}

	public Book() {
		// TODO Auto-generated constructor stub
	}

	// getter 和 setter 方法
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getPublishDate() {
		return publishDate;
	}

	public void setPublishDate(String publishDate) {
		this.publishDate = publishDate;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}
