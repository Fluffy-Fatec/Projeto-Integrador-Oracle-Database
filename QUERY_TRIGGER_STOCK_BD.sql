-- Trigger para acrescentar o estoque após uma venda
CREATE OR REPLACE TRIGGER after_reposicao
AFTER INSERT ON Supplier_Stock
FOR EACH ROW
BEGIN
    -- Atualiza o estoque após receber produtos de um fornecedor
    UPDATE Stock
    SET AMOUNT_AVAILBLE = AMOUNT_AVAILBLE + :NEW.QUANTITY_SUPPLIED
    WHERE stock_id = :NEW.stock_id; -- Supondo que stock_id é a chave primária da tabela Stock
END;

-- Trigger para decrementar o estoque após uma venda
CREATE OR REPLACE TRIGGER after_venda
AFTER INSERT ON product_command
FOR EACH ROW
DECLARE
    quantity_sold INT;
    product_id_sold INT;
    amount_contained DECIMAL(10, 3);
BEGIN
    -- Verifica se o registro na tabela product_command foi inserido
    IF :NEW.PC_QUANTITY IS NOT NULL THEN
        -- Obtém a quantidade e o ID do produto vendido
        quantity_sold := :NEW.PC_QUANTITY;
        product_id_sold := :NEW.PRODUCT_ID;

        -- Declara um cursor para percorrer os resultados da subconsulta
        FOR stock_rec IN (
            SELECT SP_AMOUNT_CONTAINED
            FROM stock_product
            WHERE PRODUCT_ID = product_id_sold
        ) LOOP
            -- Atualiza a quantidade disponível no estoque
            UPDATE stock
            SET AMOUNT_AVAILBLE = AMOUNT_AVAILBLE - (quantity_sold * stock_rec.SP_AMOUNT_CONTAINED)
            WHERE STOCK_ID = product_id_sold;
        END LOOP;
    END IF;
END;
/
