-- EXERCICIO INSERT

-- EXCLUI AS TABELAS CASO EXISTAM

DROP TABLE CIENTISTA CASCADE CONSTRAINTS PURGE;
DROP TABLE CLIENTE CASCADE CONSTRAINTS PURGE;

--CRIA A TABELA CIENTISTA

CREATE TABLE
    CIENTISTA (
        CODIGO NUMBER(4) CONSTRAINT PK_CIENTISTA_CODIGO PRIMARY KEY,
        NOME VARCHAR2(50) CONSTRAINT NN_CIENTISTA_NOME NOT NULL,
        DT_NAS DATE,
        SEXO CHAR(1) CONSTRAINT CK_CIENTISTA_SEXO CHECK (SEXO IN ('F', 'M'))
        );
        
INSERT INTO CIENTISTA 
    (CODIGO, NOME, DT_NAS, SEXO)
    VALUES (1010, 'STEPHEN HAWKIN', '08/01/1942', 'M');
    
INSERT INTO CIENTISTA 
    (CODIGO, NOME, DT_NAS, SEXO)
    VALUES (1011, 'ALBERT EISTEN', '14/03/1879', 'M');
    
INSERT INTO CIENTISTA 
    VALUES (1012, 'ISAAC NEWTON', '08/01/1643', 'M'); 
    
INSERT INTO CIENTISTA 
    VALUES (1013, 'GALILEU GALIELI', '15/02/1564', 'M');
    
INSERT INTO CIENTISTA 
    VALUES (1014, 'NICOLAU COPERNICO', '19/02/1473', 'M');
    
COMMIT;

-- EXIBINDO TODOS OS DADOS DE CIENTISTA

SELECT * FROM CIENTISTA;

    
-- DESAFIO INSERT

-- EX1

CREATE TABLE 
    CLIENTE (
        CODIGO NUMBER(4) CONSTRAINT PK_CLIENTE_CODIGO PRIMARY KEY,
        NOME VARCHAR2(50) CONSTRAINT NN_CLIENTE_NOME NOT NULL
        );
        
-- EX2

INSERT INTO CLIENTE
SELECT CODIGO, NOME FROM CIENTISTA;
        
COMMIT;        
        
SELECT * FROM CLIENTE;       

-- EX1
        
ALTER TABLE CIENTISTA
    ADD DT_OBTO DATE;
    
-- EX2    
    
UPDATE CIENTISTA
    SET DT_OBTO = '14/03/2018'
        WHERE CODIGO = 1010;
        
UPDATE CIENTISTA
    SET DT_OBTO = '18/04/1955'
        WHERE CODIGO = 1011;

UPDATE CIENTISTA
    SET DT_OBTO = '31/03/1727'
        WHERE CODIGO = 1012;        
        
UPDATE CIENTISTA
    SET DT_OBTO = '08/01/1642'
        WHERE CODIGO = 1013;          
        
UPDATE CIENTISTA
    SET DT_OBTO = '24/05/1543'
        WHERE CODIGO = 1014;          

-- EX3
        
UPDATE CIENTISTA
    SET NOME = 'EINSTEN'
        WHERE CODIGO = 1011; 
        
UPDATE CIENTISTA
    SET NOME = 'NEWTON'
        WHERE CODIGO = 1012;  
        
COMMIT;        
        
-- DESAFIO UPDATE
-- EX1

ALTER TABLE CLIENTE
    ADD DT_NASC DATE;
    
DESC CLIENTE;
        
-- EX2

UPDATE CLIENTE CL
    SET CL.DT_NASC = (
        SELECT CI.DT_NAS
        FROM CIENTISTA CI
        WHERE CI.CODIGO = CL.CODIGO
        );

COMMIT;

UPDATE CLIENTE CL
    SET CL.DT_NASC = NULL
    WHERE CL.CODIGO > 0
    ;
      
UPDATE CLIENTE CL
    SET CL.DT_NASC = (
        SELECT CI.DT_NAS
        FROM CIENTISTA CI
        WHERE CI.NOME = CL.NOME
        );        
        
-- DELETE
-- EX1
-- EXECUTAR PRIMEIRO COMANDOS PARA ALTERNAR A FORMATACAO DE DATA E IDIOMA DA SESSAO

ALTER SESSION
    SET NLS_DATE_FORMAT = 'DD/MM/YYYY';
    
ALTER SESSION
    SET NLS_DATE_LANGUAGE = 'PORTUGUESE';    

DELETE FROM CIENTISTA
    WHERE TO_CHAR(DT_NAS, 'MM') = '02';

SELECT * FROM CIENTISTA;

ROLLBACK;

-- EX1 - SOLUCAO 2

DELETE FROM CIENTISTA
    WHERE EXTRACT(MONTH FROM DT_NAS) = '02';

-- EX3 - SOLUCAO 3 - NAO RECOMENDADO POIS QUE SE INCIAM COMO 02 E ANO QUE TERMINEM COM 02 SERAO EXCLUIDOS

DELETE FROM CIENTISTA
    WHERE DT_NASC LIKE '%02%';

SELECT * FROM CIENTISTA
    WHERE DT_NAS LIKE '%02%';
    
-- DESAFIO

DELETE FROM CLIENTE
    WHERE CODIGO NOT IN (
        SELECT CODIGO FROM CIENTISTA
        );

COMMIT;    



































        
        
        
        
        