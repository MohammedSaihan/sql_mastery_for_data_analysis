create table customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(150) UNIQUE ,
    city VARCHAR(50),
    signup_date DATE
);

create table products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50)  ,
    price DECIMAL(10,2),
    stock INT
);


create table orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE  ,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

create table orders_items (
    order_items_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT  ,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);


create table payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_mod VARCHAR(30),
    amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

