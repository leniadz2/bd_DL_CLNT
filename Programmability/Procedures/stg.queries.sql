﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [stg].[queries]
AS
  /***************************************************************************************************
  Procedure:          stg.queries
  Create Date:        20210521
  Author:             dÁlvarez
  Description:        queries varios.
  Call by:            none
  Affected table(s):  var
  Used By:            BI
  Parameter(s):       nore
  Log:                none
  Prerequisites:      var
  ****************************************************************************************************
  SUMMARY OF CHANGES
  Date(YYYYMMDD)      Author              Comments
  ------------------- ------------------- ------------------------------------------------------------
  20210521            dÁlvarez            creación
  
  ***************************************************************************************************/

 /*REPROCESO*/
SELECT * FROM ctl.CONTROL c;
--20210520143303	azure
--20210520211038	excel

SELECT fhcarga, orcarga, COUNT(*) FROM ods.H_SRV_TABLON hst GROUP BY fhcarga, orcarga;
--20210520143303	azure	225853
--20210520145833	excel	281538
--20210520211038	excel	281538

SELECT fhcarga, COUNT(*) FROM bds.SRV_TABLON GROUP BY fhcarga;
--20210520143303	225853
--20210520211038	55685

DELETE ctl.CONTROL      WHERE FECHOR  IN ('20210520211038');
DELETE ods.H_SRV_TABLON WHERE fhcarga IN ('20210520211038','20210520145833');
DELETE bds.SRV_TABLON   WHERE fhcarga IN ('20210520211038');

GO