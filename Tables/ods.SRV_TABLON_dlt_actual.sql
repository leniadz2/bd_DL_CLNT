CREATE TABLE [ods].[SRV_TABLON_dlt_actual] (
  [ID] [varchar](30) NULL,
  [ORDENITEM] [varchar](20) NULL
)
ON [PRIMARY]
GO

CREATE INDEX [IX1_SRV_TABLON_dlt_actual]
  ON [ods].[SRV_TABLON_dlt_actual] ([ID], [ORDENITEM])
  ON [PRIMARY]
GO