--Clinics
CREATE TABLE clinics (
    cid         VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(150),
    city        VARCHAR(100),
    state       VARCHAR(100),
    country     VARCHAR(100)
);

--Customers
CREATE TABLE customer (
    uid    VARCHAR(50) PRIMARY KEY,        
    name   VARCHAR(150),
    mobile VARCHAR(20)
);

--Clinic_Sales
CREATE TABLE clinic_sales (
    oid           VARCHAR(50) PRIMARY KEY,  
    uid           VARCHAR(50),             
    cid           VARCHAR(50),              
    amount        DECIMAL(12,2),
    datetime      DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

--Expenses
CREATE TABLE expenses (
    eid         VARCHAR(50) PRIMARY KEY,     
    cid         VARCHAR(50),                
    description VARCHAR(255),
    amount      DECIMAL(12,2),
    datetime    DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);
