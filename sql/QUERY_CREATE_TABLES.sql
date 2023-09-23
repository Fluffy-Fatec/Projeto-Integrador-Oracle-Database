-- TABLES
-- Table: COMMANDS
CREATE TABLE COMMANDS (
    COMMAND_ID INTEGER  NOT NULL,
    COMMAND_NUMBER INTEGER   NULL,
    COMMAND_VALUE NUMBER(10,2) NOT NULL,
    DATETIME_COMMAND TIMESTAMP,
    CONSTRAINT COMMANDS_PK PRIMARY KEY (COMMAND_ID)
) ;

-- Table: PRODUCTS
CREATE TABLE PRODUCTS (
    PRODUCT_ID INTEGER  NULL,
    PRODUCT_NAME VARCHAR2(255)   NULL,
    PRODUCT_VALUE NUMBER(10,2)   NULL,
    PRODUCT_TYPE VARCHAR2(50)   NULL,
    CONSTRAINT PRODUCTS_PK PRIMARY KEY (PRODUCT_ID)
) ;

-- Table: PRODUCT_COMMAND
CREATE TABLE PRODUCT_COMMAND (
    PRODUCT_DEMAND_ID INTEGER  NOT NULL,
    PC_QUANTITY NUMBER(10,2)  NULL,
    PC_DATETIME_ORDER DATE  NULL,
    PRODUCT_ID INTEGER   NULL,
    COMMAND_ID INTEGER   NULL,
    PC_MEASUREMENT VARCHAR(2) NULL,
    CONSTRAINT PRODUCT_COMMAND_PK PRIMARY KEY (PRODUCT_DEMAND_ID)
) ;


-- FOREIGN KEYS

ALTER TABLE PRODUCT_COMMAND
ADD CONSTRAINT FK_PRODUCT_COMMAND_COMMANDS
FOREIGN KEY (COMMAND_ID)
REFERENCES COMMANDS(COMMAND_ID);

-- Adicione a chave estrangeira na tabela PRODUCT_COMMAND para relacioná-la com a tabela PRODUCTS
ALTER TABLE PRODUCT_COMMAND
ADD CONSTRAINT FK_PRODUCT_COMMAND_PRODUCTS
FOREIGN KEY (PRODUCT_ID)
REFERENCES PRODUCTS(PRODUCT_ID);