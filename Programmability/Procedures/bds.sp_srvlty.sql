SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [bds].[sp_srvlty]
AS
  /***************************************************************************************************
  Procedure:          [bds].sp_srvlty
  Create Date:        20210521
  Author:             dÁlvarez
  Description:        todo el proceso de tablas LTY/SRV/SRVLTY
                      carga la tabla final (a ser ingestada por SAC).
                      posteriormente la tabla se exporta en CSV usando dbeaver con las sgtes caracteristicas:
                        delimeter: |
                        quote characters: "
                        quote always: string
                        null string: vacio
                        encoding: UTF-8
  Call by:            none
  Affected table(s):  bds.SRV_LYTY
  Used By:            BI
  Parameter(s):       none
  Log:                none
  Prerequisites:      stg.sp_srv_cewData*
                      ods.sp_lty_lytyCli
  ****************************************************************************************************
  SUMMARY OF CHANGES
  Date(YYYYMMDD)      Author              Comments
  ------------------- ------------------- ------------------------------------------------------------
  20210521            dÁlvarez            creación
  20210601            dÁlvarez            se unifican dos SP como mejora (se renombra sp_srvlty_SAC)
  20210610            dÁlvarez            se adiciona lógica del delta
  
  ***************************************************************************************************/

  /*---SRV----------
  stg.SRV_TABLON
  ods.SRV_TABLON
  ods.H_SRV_TABLON
  ods.SRV_TABLON_dlt
  bds.SRV_TABLON  */
  EXEC bds.sp_srv;  

  /*---LTY---------
  stg.LYTY_CLI
  ods.LYTY_CLI_tmp1
  ods.LYTY_CLI_tmp2 */
  EXEC stg.sp_lty_cliente;
  EXEC ods.sp_lty_cliente;

  /*---SRV/LTY-----
  bds.SRV_LYTY   */

  TRUNCATE TABLE bds.SRV_LYTY_tmp;

  INSERT INTO bds.SRV_LYTY_tmp
  SELECT * FROM bds.SRV_LYTY sl;

  TRUNCATE TABLE bds.SRV_LYTY;

  INSERT INTO bds.SRV_LYTY
  SELECT st.ID                           AS srv_ID
        ,st.NOMBRE                       AS srv_NOMBRE
        ,st.RAZONSOCIAL                  AS srv_RAZONSOCIAL
        ,st.NOMBRETIENDA                 AS srv_NOMBRETIENDA
        ,st.CODIGOMALL                   AS srv_CODIGOMALL
        ,st.CODIGOTIENDA                 AS srv_CODIGOTIENDA
        ,st.RUCEMISOR                    AS srv_RUCEMISOR
        ,st.IDENTIFICADORTERMINAL        AS srv_IDENTIFICADORTERMINAL
        ,st.NUMEROTERMINAL               AS srv_NUMEROTERMINAL
        ,st.SERIE                        AS srv_SERIE
        ,st.TIPOTRANSACCION              AS srv_TIPOTRANSACCION
        ,st.NUMEROTRANSACCION            AS srv_NUMEROTRANSACCION
        ,st.FECHA                        AS srv_FECHA
        ,st.HORA                         AS srv_HORA
        ,st.CAJERO                       AS srv_CAJERO
        ,st.VENDEDOR                     AS srv_VENDEDOR
        ,st.DNI                          AS srv_DNI
        ,st.RUC                          AS srv_RUC
        ,ods.fn_validaDNI(st.DNI) AS srv_DNI_Valido
        ,st.NOMBRECLIENTE                AS srv_NOMBRECLIENTE
        ,st.DIRECCIONCLIENTE             AS srv_DIRECCIONCLIENTE
        ,st.BONUS                        AS srv_BONUS
        ,st.MONEDA                       AS srv_MONEDA
        ,st.MEDIOPAGO                    AS srv_MEDIOPAGO
        ,st.TOTALVALORVENTABRUTA         AS srv_TOTALVALORVENTABRUTA
        ,st.DESCUENTOSGLOBAL             AS srv_DESCUENTOSGLOBAL
        ,st.MONTOTOTALIGV                AS srv_MONTOTOTALIGV
        ,st.TOTALVALORVENTANETA          AS srv_TOTALVALORVENTANETA
        ,st.ORDENITEM                    AS srv_ORDENITEM
        ,st.CANTIDADUNIDADESITEM         AS srv_CANTIDADUNIDADESITEM
        ,st.CODIGOPRODUCTO               AS srv_CODIGOPRODUCTO
        ,st.DESCRIPCIONPRODUCTO          AS srv_DESCRIPCIONPRODUCTO
        ,st.PRECIOVENTAUNITARIOITEM      AS srv_PRECIOVENTAUNITARIOITEM
        ,st.CARGODESCUENTOITEM           AS srv_CARGODESCUENTOITEM
        ,st.PRECIOTOTALITEM              AS srv_PRECIOTOTALITEM
        ,lc.CODIGOPERSONA                AS lty_CODIGOPERSONA
        ,lc.ORDTARJETABONUS              AS lty_ORDTARJETABONUS
        ,lc.NUMTARJETABONUS              AS lty_NUMTARJETABONUS
        ,lc.TIPOTARJETA                  AS lty_TIPOTARJETA
        ,lc.CODIGOTIPOPERSONA            AS lty_CODIGOTIPOPERSONA
        ,lc.CODIGOTIPOPERSONA_D          AS lty_CODIGOTIPOPERSONA_D
        ,lc.TIPODEDOCUMENTO              AS lty_TIPODEDOCUMENTO
        ,lc.TIPODEDOCUMENTO_D            AS lty_TIPODEDOCUMENTO_D
        ,lc.NRODOCUMENTO                 AS lty_NRODOCUMENTO
        ,lc.NRORUC                       AS lty_NRORUC
        ,lc.NOMBRES                      AS lty_NOMBRES
        ,lc.APELLIDOPATERNO              AS lty_APELLIDOPATERNO
        ,lc.APELLIDOMATERNO              AS lty_APELLIDOMATERNO
        ,lc.FECHANACIMIENTO              AS lty_FECHANACIMIENTO
        ,lc.EDAD                         AS lty_EDAD
        ,lc.EDAD_RANGO                   AS lty_EDAD_RANGO
        ,lc.SEXO_TIT                     AS lty_SEXO_TIT
        ,lc.SEXO_TIT_D                   AS lty_SEXO_TIT_D
        ,lc.FLAGESTADOCIVIL              AS lty_FLAGESTADOCIVIL
        ,lc.FLAGESTADOCIVIL_D            AS lty_FLAGESTADOCIVIL_D
        ,lc.FLAGTIENEHIJOS               AS lty_FLAGTIENEHIJOS
        ,lc.FLAGTIENEHIJOS_D             AS lty_FLAGTIENEHIJOS_D
        ,lc.FLAGTIENETELEFONO            AS lty_FLAGTIENETELEFONO
        ,lc.FLAGTIENETELEFONO_D          AS lty_FLAGTIENETELEFONO_D
        ,lc.FLAGTIENECORREO              AS lty_FLAGTIENECORREO
        ,lc.FLAGTIENECORREO_D            AS lty_FLAGTIENECORREO_D
        ,lc.FLAGCOMPARTEDATOS            AS lty_FLAGCOMPARTEDATOS
        ,lc.FLAGCOMPARTEDATOS_D          AS lty_FLAGCOMPARTEDATOS_D
        ,lc.FLAGAUTCANJE                 AS lty_FLAGAUTCANJE
        ,lc.FLAGAUTCANJE_D               AS lty_FLAGAUTCANJE_D
        ,lc.FLAGCLTEFALLECIDO            AS lty_FLAGCLTEFALLECIDO
        ,lc.FLAGCLTEFALLECIDO_D          AS lty_FLAGCLTEFALLECIDO_D
        ,lc.RAZONSOCIAL                  AS lty_RAZONSOCIAL
        ,lc.FECHACREACION_PER            AS lty_FECHACREACION_PER
        ,lc.HORACREACION_PER             AS lty_HORACREACION_PER
        ,lc.FECHAULTMODIF_PER            AS lty_FECHAULTMODIF_PER
        ,lc.FECHACARGAINICIAL_PER        AS lty_FECHACARGAINICIAL_PER
        ,lc.FECHACARGAULTMODIF_PER       AS lty_FECHACARGAULTMODIF_PER
        ,lc.CODPOS                       AS lty_CODPOS
        ,lc.DIRECCION                    AS lty_DIRECCION
        ,lc.DEPARTAMENTO                 AS lty_DEPARTAMENTO
        ,lc.PROVINCIA                    AS lty_PROVINCIA
        ,lc.DISTRITO                     AS lty_DISTRITO
        ,lc.FLAGULTIMO_DIR               AS lty_FLAGULTIMO_DIR
        ,lc.REFERENCIA                   AS lty_REFERENCIA
        ,lc.ESTADO                       AS lty_ESTADO
        ,lc.ESTADO_D                     AS lty_ESTADO_D
        ,lc.COORDENADAX                  AS lty_COORDENADAX
        ,lc.COORDENADAY                  AS lty_COORDENADAY
        ,lc.FLAGCOORDENADA               AS lty_FLAGCOORDENADA
        ,lc.NSE                          AS lty_NSE
        ,lc.TELEFONO                     AS lty_TELEFONO
        ,lc.TELEFONO_D                   AS lty_TELEFONO_D
        ,lc.FECHACREACION_TEL            AS lty_FECHACREACION_TEL
        ,lc.EMAIL                        AS lty_EMAIL
        ,lc.FECHACREACION_EML            AS lty_FECHACREACION_EML
        ,lc.HIJ_AS                       AS lty_HIJ_AS
        ,lc.HIJ_OS                       AS lty_HIJ_OS
        ,lc.HIJ_NN                       AS lty_HIJ_NN
        ,lc.HIJ_TOT                      AS lty_HIJ_TOT
  FROM bds.SRV_TABLON st LEFT JOIN bds.LYTY_CLI lc ON st.DNI = lc.NRODOCUMENTO;

  TRUNCATE TABLE bds.SRV_LYTY_dlt;

  INSERT INTO bds.SRV_LYTY_dlt
  SELECT * FROM bds.SRV_LYTY_tmp
  EXCEPT
  SELECT * FROM bds.SRV_LYTY;


GO