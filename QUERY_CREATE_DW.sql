CREATE TABLE Products (
  product_id INTEGER PRIMARY KEY,
  product_name VARCHAR2(255) NOT NULL,
  product_type VARCHAR2(255) NOT NULL,
  product_value NUMBER(10,2) NOT NULL,
  datetime_upload TIMESTAMP NOT NULL
);

CREATE TABLE Temporal (
  temporal_id INTEGER PRIMARY KEY,
  datetime_creation TIMESTAMP NOT NULL
);

CREATE TABLE Sales_Fact (
  temporal_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  datetime_upload TIMESTAMP NOT NULL,
  sf_value NUMBER(10,2) NOT NULL,
  CONSTRAINT fk_temporal FOREIGN KEY (temporal_id) REFERENCES Temporal (temporal_id),
  CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES Products (product_id)
);
CREATE TABLE Suppliers (
  suppliers_id INTEGER PRIMARY KEY,
  supplier_name VARCHAR2(255) NOT NULL,
  supplier_segment NUMBER(10, 2) NOT NULL,
  delivery_forecast NUMBER(10, 2) NOT NULL,
  datetime_upload TIMESTAMP NOT NULL
);

CREATE TABLE Feedstock (
  feedstock_id INTEGER PRIMARY KEY,
  feedstock_name VARCHAR2(255) NOT NULL,
  amount_available NUMBER(10, 2) NOT NULL,
  pc_measurement VARCHAR2(2) NOT NULL,
  datetime_upload TIMESTAMP NOT NULL
);

CREATE TABLE Feedstocks_Offered (
  suppliers_id INTEGER,
  feedstock_id INTEGER,
  temporal_id INTEGER,
  quantity_offered NUMBER(10, 2) NOT NULL,
  pc_measurement NUMBER(10, 2) NOT NULL,
  value_offered NUMBER(10, 2) NOT NULL,
  datetime_upload TIMESTAMP NOT NULL,
  CONSTRAINT fk_temporal_offer FOREIGN KEY (temporal_id) REFERENCES Temporal(temporal_id),
  CONSTRAINT fk_suppliers_offer FOREIGN KEY (suppliers_id) REFERENCES Suppliers(suppliers_id),
  CONSTRAINT fk_feedstock_offer FOREIGN KEY (feedstock_id) REFERENCES Feedstock(feedstock_id)
);

CREATE TABLE Feedstocks_Acquired (
  suppliers_id INTEGER,
  feedstock_id INTEGER,
  temporal_id INTEGER,
  quantity_acquired NUMBER(10, 2) NOT NULL,
  pc_measurement NUMBER(10, 2) NOT NULL,
  time_arrived VARCHAR2(30),
  Field VARCHAR2(255),
  datetime_upload TIMESTAMP NOT NULL,
  CONSTRAINT fk_temporal_acquired FOREIGN KEY (temporal_id) REFERENCES Temporal(temporal_id),
  CONSTRAINT fk_suppliers_acquired FOREIGN KEY (suppliers_id) REFERENCES Suppliers(suppliers_id),
  CONSTRAINT fk_feedstock_acquired FOREIGN KEY (feedstock_id) REFERENCES Feedstock(feedstock_id)
);

CREATE TABLE Feedstock_Utilized (
  temporal_id INTEGER,
  feedstock_id INTEGER,
  product_id INTEGER,
  feedstock_value NUMBER(10, 2) NOT NULL,
  datetime_upload TIMESTAMP NOT NULL,
  CONSTRAINT fk_temporal_utilized FOREIGN KEY (temporal_id) REFERENCES Temporal(temporal_id),
  CONSTRAINT fk_feedstock_utilized FOREIGN KEY (feedstock_id) REFERENCES Feedstock(feedstock_id),
  CONSTRAINT fk_product_utilized FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


CREATE SEQUENCE temporal_id_sequence
  START WITH 1
  INCREMENT BY 1;


CREATE OR REPLACE TRIGGER trigger_temporal_id
BEFORE INSERT ON Temporal
FOR EACH ROW
BEGIN
  SELECT temporal_id_sequence.NEXTVAL INTO :NEW.temporal_id FROM DUAL;
END;
/
