DELIMITER //
DROP PROCEDURE IF EXISTS VinayUpdateCounteries;
CREATE PROCEDURE VinayUpdateCounteries(
    oldCountry varchar(255),
    newCountry varchar(255),
    threshold int 
)
BEGIN
    DECLARE totalcount int ;
    SET threshold = threshold;
    SET @totalcount = (SELECT COUNT(*) FROM leads WHERE country = oldCountry);
    SELECT 'Before Update Total rows count:', @totalcount;
    DRE: WHILE @totalcount >0 DO
        UPDATE leads SET country = newCountry WHERE id IN ( SELECT id FROM ( SELECT id FROM leads WHERE country = oldCountry ORDER BY id ASC LIMIT threshold )l );
        DO SLEEP(1);
        SET @totalcount = (SELECT COUNT(*) FROM leads WHERE country = oldCountry);
        SELECT 'Upate is in progress Total rows count:', @totalcount;
        IF (@totalcount = 0 ) THEN
           LEAVE DRE;
        END IF;

    END WHILE DRE ;
    SET @totalcount = (SELECT COUNT(*) FROM leads WHERE country = oldCountry);
    SELECT 'Before Update Total rows count:', @totalcount;
END //
DELIMITER ;


