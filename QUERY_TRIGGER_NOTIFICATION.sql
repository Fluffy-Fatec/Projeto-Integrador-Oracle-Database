CREATE OR REPLACE TRIGGER notification
AFTER UPDATE OR INSERT ON Stock
FOR EACH ROW
BEGIN
    -- Adiciona condições específicas para a quantidade disponível e unidade de medida
    IF :NEW.AMOUNT_AVAILBLE < 25 AND :NEW.PC_MEASUREMENT = 'NU' THEN
        -- Condição para quantidade menor que 25 e medida 'UN'
        UPDATE NOTIFICATION_STOCK
        SET NS_STATUS = 'ABERTO',
            NS_DATETIME = SYSDATE,
            STOCK_ID = :NEW.stock_id
        WHERE stock_id = :NEW.stock_id;

        -- Se não houver correspondência, insere um novo registro
        IF SQL%NOTFOUND THEN
            INSERT INTO NOTIFICATION_STOCK (NS_STATUS, NS_DATETIME, STOCK_ID)
            VALUES ('ABERTO', SYSDATE, :NEW.stock_id);
        END IF;
    
    ELSIF :NEW.AMOUNT_AVAILBLE < 10 AND :NEW.PC_MEASUREMENT = 'CX' THEN
        -- Condição para quantidade menor que 10 e medida 'CX'
        UPDATE NOTIFICATION_STOCK
        SET NS_STATUS = 'ABERTO',
            NS_DATETIME = SYSDATE,
            STOCK_ID = :NEW.stock_id
        WHERE stock_id = :NEW.stock_id;

        -- Se não houver correspondência, insere um novo registro
        IF SQL%NOTFOUND THEN
            INSERT INTO NOTIFICATION_STOCK (NS_STATUS, NS_DATETIME, STOCK_ID)
            VALUES ('ABERTO', SYSDATE, :NEW.stock_id);
        END IF;
    
    ELSIF :NEW.AMOUNT_AVAILBLE < 30 AND :NEW.PC_MEASUREMENT = 'KG' THEN
        -- Condição para quantidade menor que 30 e medida 'KG'
        UPDATE NOTIFICATION_STOCK
        SET NS_STATUS = 'ABERTO',
            NS_DATETIME = SYSDATE,
            STOCK_ID = :NEW.stock_id
        WHERE stock_id = :NEW.stock_id;

        -- Se não houver correspondência, insere um novo registro
        IF SQL%NOTFOUND THEN
            INSERT INTO NOTIFICATION_STOCK (NS_STATUS, NS_DATETIME, STOCK_ID)
            VALUES ('ABERTO', SYSDATE, :NEW.stock_id);
        END IF;
    END IF;
END;