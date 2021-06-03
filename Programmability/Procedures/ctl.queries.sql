SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [ctl].[queries]
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
  SELECT
    *
  FROM ctl.CONTROL c;
  --20210520143303	azure
  --20210520211038	excel

  SELECT
    fhcarga
   ,orcarga
   ,COUNT(*)
  FROM ods.H_SRV_TABLON hst
  GROUP BY fhcarga
          ,orcarga;
  --20210520143303	azure	225853
  --20210520145833	excel	281538
  --20210520211038	excel	281538

  SELECT
    fhcarga
   ,COUNT(*)
  FROM bds.SRV_TABLON
  GROUP BY fhcarga;
  --20210520143303	225853
  --20210520211038	55685

  DELETE ctl.CONTROL
  WHERE FECHOR IN ('20210520211038');
  DELETE ods.H_SRV_TABLON
  WHERE fhcarga IN ('20210520211038', '20210520145833');
  DELETE bds.SRV_TABLON
  WHERE fhcarga IN ('20210520211038');


  SELECT
    CODIGOMALL
   ,COUNT(*)
  FROM stg.SRV_TABLON
  GROUP BY CODIGOMALL;

  SELECT
    CODIGOMALL
   ,COUNT(*)
  FROM ods.SRV_TABLON
  GROUP BY CODIGOMALL;

  SELECT
    CODIGOMALL
   ,COUNT(*)
  FROM ods.H_SRV_TABLON
  GROUP BY CODIGOMALL;



  SELECT
    CODIGOMALL
   ,COUNT(*)
  FROM bds.SRV_TABLON
  GROUP BY CODIGOMALL;

  /***********************************correlativos
  */
  SELECT
    t.srv_codigomall
   ,COUNT(*) AS conta
  FROM (SELECT DISTINCT
      st.srv_codigomall
     ,st.lty_NUMTARJETABONUS
    FROM bds.SRV_lyty st
  -- WHERE st.lty_NUMTARJETABONUS IS NOT NULL
  ) AS t
  GROUP BY t.srv_codigomall;

  --01	3765
  --02	2415

  SELECT
    t.srv_codigomall
   ,COUNT(*) AS conta
  FROM (SELECT DISTINCT
      st.srv_codigomall
     ,st.srv_DNI
    FROM bds.SRV_lyty st
    WHERE st.srv_DNI_Valido = 1) AS t
  GROUP BY t.srv_codigomall;

--01	11248
--02	7160

/***********************************correlativos

SELECT TOP 10 * FROM stg.TABLON_SRV ts;

SELECT ts.CODIGOMALL,
  ts.RUCEMISOR, 
  ts.SERIE, 
  MIN(ts.NUMEROTRANSACCION*1) AS minCorrel,
  MAX(ts.NUMEROTRANSACCION*1) AS maxCorrel,
  MAX(ts.NUMEROTRANSACCION*1)*1 - MIN(ts.NUMEROTRANSACCION)*1 + 1 AS CantEsperadaDocs
  --,COUNT(NUMEROTRANSACCION) AS CantRealDocs
INTO dbo.t_SRV_valCorrel
FROM stg.TABLON_SRV ts
GROUP BY ts.CODIGOMALL,
  ts.RUCEMISOR, 
  ts.SERIE
ORDER BY 1,2,3,4,5;

SELECT TOP 10 * FROM dbo.t_SRV_valCorrel;

SELECT distinct ts.CODIGOMALL,
       ts.RUCEMISOR, 
       ts.SERIE
  INTO dbo.t_SRV_valCorrel_2
  FROM stg.TABLON_SRV ts

SELECT ts.CODIGOMALL,
  ts.RUCEMISOR, 
  ts.SERIE, 
  COUNT(NUMEROTRANSACCION) AS CantRealDocs
INTO dbo.t_SRV_valCorrel_3
FROM stg.TABLON_SRV ts
GROUP BY ts.CODIGOMALL,
  ts.RUCEMISOR, 
  ts.SERIE
ORDER BY 1,2,3;


SELECT * FROM dbo.t_SRV_valCorrel;
SELECT * FROM dbo.t_SRV_valCorrel_1;
SELECT * FROM dbo.t_SRV_valCorrel_3;

SELECT COUNT(*) FROM dbo.t_SRV_valCorrel;
SELECT * FROM dbo.t_SRV_valCorrel_1;
SELECT COUNT(*) FROM dbo.t_SRV_valCorrel_2;

Select [NAME] from sysobjects where type = 'P' and category = 0
  */

  SELECT srv_CODIGOMALL, SUM(st.srv_PRECIOTOTALITEM)
    FROM bds.SRV_lyty st
   -- WHERE st.srv_DNI_Valido = 1
    GROUP BY srv_CODIGOMALL;


  SELECT FHCARGA, CODIGOMALL, SUM(PRECIOTOTALITEM)
    FROM ods.H_SRV_TABLON hst
   -- WHERE st.srv_DNI_Valido = 1
    GROUP BY FHCARGA, CODIGOMALL
    ORDER BY FHCARGA, CODIGOMALL;

  SELECT FHCARGA, CODIGOMALL, SUM(PRECIOTOTALITEM)
    FROM bds.SRV_tablon
   -- WHERE st.srv_DNI_Valido = 1
    GROUP BY FHCARGA, CODIGOMALL;


  SELECT FHCARGA, CODIGOMALL, SUM(PRECIOTOTALITEM)
    FROM bds.SRV_tablon
   -- WHERE st.srv_DNI_Valido = 1
    WHERE fhcarga IN ('20210525124707','20210528232221')
    GROUP BY FHCARGA, CODIGOMALL
    ORDER BY FHCARGA, CODIGOMALL;

--inconsistencias
  SELECT DISTINCT st.RUCEMISOR, st.DNI , st.NOMBRECLIENTE FROM bds.SRV_TABLON st
  WHERE nombrecliente LIKE '%?%';

  SELECT t.RUCEMISOR, t.NOMBRETIENDA, COUNT(*) FROM (
SELECT DISTINCT st.RUCEMISOR, st.NOMBRE, st.RAZONSOCIAL, st.NOMBRETIENDA FROM bds.SRV_TABLON st) AS t
  GROUP BY t.RUCEMISOR, t.NOMBRETIENDA
  HAVING COUNT(*) > 1
  ;

--20101951872	EMPRESAS COMERCIALES S.A Y/O EMCOMER S.A	BATA CCPN	2
--20101951872	EMPRESAS COMERCIALES S.A Y/O EMCOMER S.A	NS CCPN	2
--20101951872	EMPRESAS COMERCIALES S.A Y/O EMCOMER S.A	BATA MDS	3
--20101951872	EMPRESAS COMERCIALES S.A Y/O EMCOMER S.A	BG MDS	2
--20101951872	EMPRESAS COMERCIALES S.A Y/O EMCOMER S.A	BG CCPN	2


SELECT DISTINCT RUCEMISOR, NOMBRE, RAZONSOCIAL, NOMBRETIENDA 
  FROM bds.SRV_TABLON
WHERE RUCEMISOR = '20101951872'
  AND NOMBRETIENDA IN ('BATA CCPN',
                      'NS CCPN',
                      'BATA MDS',
                      'BG MDS',
                      'BG CCPN')
  ORDER BY RUCEMISOR, NOMBRETIENDA;

GO