SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [bds].[sp_srv_tablon]
AS
/***************************************************************************************************
Procedure:          [bds].[sp_srv_tablon]
Create Date:        20210601
Author:             dÁlvarez
Description:        tbd
Call by:            none
Affected table(s):  bds.SRV_TABLON
Used By:            BI
Parameter(s):       tbd
Log:                tbd
Prerequisites:      [ods].[sp_srv_carga]
****************************************************************************************************
SUMMARY OF CHANGES
Date(YYYYMMDD)      Author              Comments
------------------- ------------------- ------------------------------------------------------------
20210601            dÁlvarez            creación
20210617            dÁlvarez            se agrega RUC y CE

***************************************************************************************************/

TRUNCATE TABLE bds.SRV_TABLON;

DROP INDEX bds.SRV_TABLON.IX1_SRV_TABLON;

--cargado anteriormente y no en la nueva carga
INSERT INTO bds.SRV_TABLON
SELECT stt.ID
      ,stt.NOMBRE
      ,stt.RAZONSOCIAL
      ,stt.NOMBRETIENDA
      ,stt.CODIGOMALL
      ,stt.CODIGOTIENDA
      ,stt.RUCEMISOR
      ,stt.IDENTIFICADORTERMINAL
      ,stt.NUMEROTERMINAL
      ,stt.SERIE
      ,stt.TIPOTRANSACCION
      ,stt.NUMEROTRANSACCION
      ,stt.FECHA
      ,stt.HORA
      ,stt.CAJERO
      ,stt.VENDEDOR
      ,stt.DNI
      ,stt.RUC
      ,stt.CE
      ,stt.DUIval
      ,stt.NOMBRECLIENTE
      ,stt.DIRECCIONCLIENTE
      ,stt.BONUS
      ,stt.MONEDA
      ,stt.MEDIOPAGO
      ,stt.TOTALVALORVENTABRUTA
      ,stt.DESCUENTOSGLOBAL
      ,stt.MONTOTOTALIGV
      ,stt.TOTALVALORVENTANETA
      ,stt.ORDENITEM
      ,stt.CANTIDADUNIDADESITEM
      ,stt.CODIGOPRODUCTO
      ,stt.DESCRIPCIONPRODUCTO
      ,stt.PRECIOVENTAUNITARIOITEM
      ,stt.CARGODESCUENTOITEM
      ,stt.PRECIOTOTALITEM
      ,stt.FHCARGA
  FROM ods.SRV_TABLON_tmp stt INNER JOIN ods.SRV_TABLON_dlt std
    ON stt.ID = std.ID AND stt.ORDENITEM = std.ORDENITEM;

--nueva carga
INSERT INTO bds.SRV_TABLON
SELECT st.ID
      ,st.NOMBRE
      ,st.RAZONSOCIAL
      ,st.NOMBRETIENDA
      ,st.CODIGOMALL
      ,st.CODIGOTIENDA
      ,st.RUCEMISOR
      ,st.IDENTIFICADORTERMINAL
      ,st.NUMEROTERMINAL
      ,st.SERIE
      ,st.TIPOTRANSACCION
      ,st.NUMEROTRANSACCION
      ,st.FECHA
      ,st.HORA
      ,st.CAJERO
      ,st.VENDEDOR
      ,IIF(LEN(st.DNI)=8,st.DNI,NULL)
      ,IIF(LEN(st.RUC)=11,st.RUC,NULL)
      ,IIF(LEN(st.DNI)=9,st.DNI,IIF(LEN(st.DNI)=10,st.DNI,NULL))
      ,CASE LEN(st.DNI)
         WHEN 8  THEN ods.fn_validaDNI(st.DNI)
         WHEN 9  THEN ods.fn_validaCE(st.DNI)
         WHEN 10 THEN ods.fn_validaCE(st.DNI)
         WHEN 11 THEN ods.fn_validaRUC(st.RUC)
         ELSE NULL END AS DUIval
      ,st.NOMBRECLIENTE
      ,st.DIRECCIONCLIENTE
      ,st.BONUS
      ,st.MONEDA
      ,st.MEDIOPAGO
      ,st.TOTALVALORVENTABRUTA
      ,st.DESCUENTOSGLOBAL
      ,st.MONTOTOTALIGV
      ,st.TOTALVALORVENTANETA
      ,st.ORDENITEM
      ,st.CANTIDADUNIDADESITEM
      ,st.CODIGOPRODUCTO
      ,st.DESCRIPCIONPRODUCTO
      ,st.PRECIOVENTAUNITARIOITEM
      ,st.CARGODESCUENTOITEM
      ,st.PRECIOTOTALITEM
      ,st.FHCARGA
  FROM ods.SRV_TABLON st;

CREATE INDEX IX1_SRV_TABLON
ON bds.SRV_TABLON(DNI);

/*

TRUNCATE TABLE ods.SRV_TABLON_dlt_actual;
TRUNCATE TABLE ods.SRV_TABLON_regActual_v1;
TRUNCATE TABLE ods.SRV_TABLON_regNews_v1;
TRUNCATE TABLE bds.SRV_TABLON_v1;

--lo cargado anteriormente y no en la nueva carga
INSERT INTO ods.SRV_TABLON_dlt_actual
SELECT * FROM ods.SRV_TABLON_dlt_excptIZ
UNION
SELECT * FROM ods.SRV_TABLON_dlt_intrsct;

CREATE INDEX IX1_SRV_TABLON_tmp_v1 ON ods.SRV_TABLON_tmp_v1(ID, ORDENITEM);
CREATE INDEX IX1_SRV_TABLON_dlt_actual ON ods.SRV_TABLON_dlt_actual(ID, ORDENITEM);

INSERT INTO ods.SRV_TABLON_regActual_v1
SELECT stt.*
  FROM ods.SRV_TABLON_tmp_v1 stt INNER JOIN ods.SRV_TABLON_dlt_actual std
    ON stt.ID = std.ID AND stt.ORDENITEM = std.ORDENITEM;

DROP INDEX ods.SRV_TABLON_tmp_v1.IX1_SRV_TABLON_tmp_v1;
DROP INDEX ods.SRV_TABLON_dlt_actual.IX1_SRV_TABLON_dlt_actual;

--lo no cargado anteriormente (los nuevos registros)
CREATE INDEX IX1_SRV_TABLON ON ods.SRV_TABLON(ID, ORDENITEM);
CREATE INDEX IX1_SRV_TABLON_dlt_excptDE ON ods.SRV_TABLON_dlt_excptDE(ID, ORDENITEM);

INSERT INTO ods.SRV_TABLON_regNews_v1
SELECT st.*
  FROM ods.SRV_TABLON st INNER JOIN ods.SRV_TABLON_dlt_excptDE stde
    ON st.ID = stde.ID AND st.ORDENITEM = stde.ORDENITEM;

DROP INDEX ods.SRV_TABLON.IX1_SRV_TABLON;
DROP INDEX ods.SRV_TABLON_dlt_excptDE.IX1_SRV_TABLON_dlt_excptDE;

--todo
DROP INDEX bds.SRV_TABLON_v1.IX1_SRV_TABLON_v1;

INSERT INTO bds.SRV_TABLON_v1
SELECT * FROM ods.SRV_TABLON_regActual_v1
UNION ALL
SELECT * FROM ods.SRV_TABLON_regNews_v1;

CREATE INDEX IX1_SRV_TABLON_v1
ON bds.SRV_TABLON_v1(DNI);

*/
--
--TRUNCATE TABLE ods.SRV_TABLON_dlt_actual;
--TRUNCATE TABLE ods.SRV_TABLON_regActual;
--TRUNCATE TABLE ods.SRV_TABLON_regNews;
--TRUNCATE TABLE bds.SRV_TABLON;
--
----lo cargado anteriormente y no en la nueva carga
--INSERT INTO ods.SRV_TABLON_dlt_actual
--SELECT * FROM ods.SRV_TABLON_dlt_excptIZ
--UNION
--SELECT * FROM ods.SRV_TABLON_dlt_intrsct;
--
--CREATE INDEX IX1_SRV_TABLON_tmp ON ods.SRV_TABLON_tmp(ID, ORDENITEM);
--CREATE INDEX IX1_SRV_TABLON_dlt_actual ON ods.SRV_TABLON_dlt_actual(ID, ORDENITEM);
--
--INSERT INTO ods.SRV_TABLON_regActual
--SELECT stt.*
--  FROM ods.SRV_TABLON_tmp stt INNER JOIN ods.SRV_TABLON_dlt_actual std
--    ON stt.ID = std.ID AND stt.ORDENITEM = std.ORDENITEM;
--
--DROP INDEX ods.SRV_TABLON_tmp.IX1_SRV_TABLON_tmp;
--DROP INDEX ods.SRV_TABLON_dlt_actual.IX1_SRV_TABLON_dlt_actual;
--
----lo no cargado anteriormente (los nuevos registros)
--CREATE INDEX IX1_SRV_TABLON ON ods.SRV_TABLON(ID, ORDENITEM);
--CREATE INDEX IX1_SRV_TABLON_dlt_excptDE ON ods.SRV_TABLON_dlt_excptDE(ID, ORDENITEM);
--
--INSERT INTO ods.SRV_TABLON_regNews
--SELECT st.*
--  FROM ods.SRV_TABLON st INNER JOIN ods.SRV_TABLON_dlt_excptDE stde
--    ON st.ID = stde.ID AND st.ORDENITEM = stde.ORDENITEM;
--
--DROP INDEX ods.SRV_TABLON.IX1_SRV_TABLON;
--DROP INDEX ods.SRV_TABLON_dlt_excptDE.IX1_SRV_TABLON_dlt_excptDE;
--
----todo
--DROP INDEX bds.SRV_TABLON.IX1_SRV_TABLON;
--
--INSERT INTO bds.SRV_TABLON
--SELECT * FROM ods.SRV_TABLON_regActual
--UNION ALL
--SELECT * FROM ods.SRV_TABLON_regNews;
--
--CREATE INDEX IX1_SRV_TABLON
--ON bds.SRV_TABLON(DNI);


GO