USE [FactureProfesores]
GO
/****** Object:  Table [dbo].[Lecciones]    Script Date: 8/02/2022 1:30:12 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lecciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Codigo_Curso] [varchar](50) NOT NULL,
	[Horas] [int] NULL,
	[Fecha] [datetime] NULL,
	[Id_Profesor] [int] NULL,
 CONSTRAINT [PK_Lecciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profesor]    Script Date: 8/02/2022 1:30:12 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profesor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Identificacion] [varchar](50) NOT NULL,
	[Fecha_Nacimiento] [date] NOT NULL,
	[Tipo_Moneda] [varchar](50) NULL,
	[Tarifa_Horaria] [numeric](18, 2) NULL,
	[Tipo_Profesor] [nchar](10) NULL,
	[Equivalencia] [numeric](18, 2) NULL,
 CONSTRAINT [PK_Profesor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Lecciones]  WITH CHECK ADD  CONSTRAINT [FK_Lecciones_Profesor] FOREIGN KEY([Id_Profesor])
REFERENCES [dbo].[Profesor] ([Id])
GO
ALTER TABLE [dbo].[Lecciones] CHECK CONSTRAINT [FK_Lecciones_Profesor]
GO
/****** Object:  StoredProcedure [dbo].[ProfesoresCrear]    Script Date: 8/02/2022 1:30:12 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Isaias Asis
-- Create date: 7/02/2022
-- Description:	Sp de crear profesor
-- =============================================
CREATE   PROCEDURE [dbo].[ProfesoresCrear](
	
	@nombre varchar(50),
	@identificacion varchar(50),
	@fecha_nacimiento DATETIME,
	@tipo_moneda varchar(50),
	@tarifa_horaria numeric(18,2),
	@tipo_profesor varchar(50),
	@Equivalencia numeric(18,2)
)
AS
BEGIN
	DECLARE
	@ErrorMessage VARCHAR(MAX)
	IF(ISNULL(@nombre, '') = '')
	BEGIN
		RAISERROR('El campo nombre es requerido.', 16,2);
		RETURN
	END

	IF(ISNULL(@identificacion, '') = '')
	BEGIN
		RAISERROR('El campo identificacion es requerido.', 16,2);
		RETURN
	END

	IF(ISNULL(@tipo_moneda, '') = '')
	BEGIN
		RAISERROR('El campo tipo moneda horaria es requerido.', 16,2);
		RETURN
	END

	IF(ISNULL(@tipo_profesor, '') = '')
	BEGIN
		RAISERROR('El campo tipo profesor es requerido.', 16,2);
		RETURN
	END

	IF(UPPER(@tipo_profesor) <> 'PLANTA' AND UPPER(@tipo_profesor) <> 'EXTRANJERO')
	BEGIN
		SET @ErrorMessage = 'Tipo profesor debe ser: PLANTA O EXTRANJERO'
		RAISERROR(@ErrorMessage, 16,2);
		RETURN
	END

	IF(UPPER(@tipo_profesor) = 'PLANTA' AND @tipo_moneda <> 'COP')
	BEGIN
		SET @ErrorMessage = CONCAT('No es posible pagar a trabajadores de planta con moneda: ' ,  @tipo_moneda)
		RAISERROR(@ErrorMessage, 16,2);
		RETURN
	END

	IF(EXISTS(SELECT TOP 1 Identificacion FROM [dbo].[profesor] WHERE Identificacion = @identificacion))
	BEGIN
		SET @ErrorMessage = CONCAT('La identificación: ', @identificacion, ' ya existe')
		RAISERROR(@ErrorMessage, 16,2);
		RETURN
	END
    
	BEGIN TRY
		INSERT INTO 
			[dbo].[profesor](
			nombre,
			identificacion,
			fecha_nacimiento,
			tipo_moneda,
			tarifa_Horaria,
			tipo_profesor,
			Equivalencia)
		VALUES(
			@nombre,
			@identificacion,
			@fecha_Nacimiento,
			@tipo_moneda,
			@tarifa_horaria,
			@tipo_profesor,
			@Equivalencia)

	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		RAISERROR(@ErrorMessage, 16, 2);
	END CATCH
END
GO
