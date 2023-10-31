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
AFTER INSERT ON Stock_Product
FOR EACH ROW
BEGIN
    -- Atualiza o Stock_Product após a conclusão de um pedido de produto
    UPDATE Stock
    SET AMOUNT_AVAILBLE = AMOUNT_AVAILBLE - :NEW.SP_AMOUNT_CONTAINED
    WHERE stock_id = :NEW.stock_id;
END;