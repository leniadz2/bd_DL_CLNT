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

***************************************************************************************************/

TRUNCATE TABLE bds.SRV_TABLON;
    
--cargado anteriormente y no en la nueva carga
INSERT INTO bds.SRV_TABLON
SELECT stt.*
  FROM ods.SRV_TABLON_tmp stt INNER JOIN ods.SRV_TABLON_dlt std
    ON stt.ID = std.ID AND stt.ORDENITEM = std.ORDENITEM;

--nueva carga
INSERT INTO bds.SRV_TABLON
SELECT st.*
  FROM ods.SRV_TABLON st;

GO