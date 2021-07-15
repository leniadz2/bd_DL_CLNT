SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [bds].[sp_srv_tablon_v1]
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

***************************************************************************************************/

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

GO