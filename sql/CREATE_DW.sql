

CREATE TABLE Products (
  product_id INTEGER PRIMARY KEY,
  product_name VARCHAR2(255) NOT NULL,
  product_type VARCHAR2(255) NOT NULL,
  product_value NUMBER(10,2) NOT NULL,
  datetime_upload TIMESTAMP NOT NULL
);

CREATE TABLE Temporal (
  temporal_id INTEGER PRIMARY KEY,
  datetime_quantity NUMBER NOT NULL,
  datetime_unity VARCHAR2(30)
);

CREATE TABLE Sales_Fact (
  temporal_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  datetime_upload TIMESTAMP NOT NULL,
  sf_value NUMBER(10,2) NOT NULL,
  CONSTRAINT fk_temporal FOREIGN KEY (temporal_id) REFERENCES Temporal (temporal_id),
  CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES Products (product_id)
);
