USE [master]
GO
/****** Object:  Database [FactureProfesores]    Script Date: 18/04/2022 12:09:58 a. m. ******/
CREATE DATABASE [FactureProfesores]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FactureProfesores', FILENAME = N'C:\Users\isaia\FactureProfesores.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FactureProfesores_log', FILENAME = N'C:\Users\isaia\FactureProfesores_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [FactureProfesores] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FactureProfesores].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FactureProfesores] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FactureProfesores] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FactureProfesores] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FactureProfesores] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FactureProfesores] SET ARITHABORT OFF 
GO
ALTER DATABASE [FactureProfesores] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FactureProfesores] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FactureProfesores] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FactureProfesores] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FactureProfesores] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FactureProfesores] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FactureProfesores] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FactureProfesores] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FactureProfesores] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FactureProfesores] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FactureProfesores] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FactureProfesores] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FactureProfesores] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FactureProfesores] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FactureProfesores] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FactureProfesores] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FactureProfesores] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FactureProfesores] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FactureProfesores] SET  MULTI_USER 
GO
ALTER DATABASE [FactureProfesores] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FactureProfesores] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FactureProfesores] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FactureProfesores] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FactureProfesores] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FactureProfesores] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [FactureProfesores] SET QUERY_STORE = OFF
GO
USE [FactureProfesores]
GO
/****** Object:  Table [dbo].[Lecciones]    Script Date: 18/04/2022 12:09:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lecciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Codigo_Curso] [varchar](50) NOT NULL,
	[Horas] [int] NULL,
	[Fecha] [date] NULL,
	[Id_Profesor] [int] NULL,
	[Valor_Leccion] [numeric](18, 2) NULL,
 CONSTRAINT [PK_Lecciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profesor]    Script Date: 18/04/2022 12:09:58 a. m. ******/
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
/****** Object:  StoredProcedure [dbo].[GetLecciones]    Script Date: 18/04/2022 12:09:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Isaias Asis
-- Create date: 16/04/2022
-- Description:	Sp para obtener informacion de las lecciones
-- =============================================
CREATE PROCEDURE [dbo].[GetLecciones](
	
	@fecha_inicial DATETIME,
	@fecha_final DATETIME

)
AS
BEGIN
	IF(ISNULL(@fecha_inicial, '') = '')
	BEGIN
		RAISERROR('El campo fecha inicial es requerido.', 16,2);
		RETURN
	END

	IF(ISNULL(@fecha_final, '') = '')
	BEGIN
		RAISERROR('El campo fecha final es requerido.', 16,2);
		RETURN
	END

	SELECT
		Codigo_Curso,
		Horas,
		Id_Profesor,
		Valor_Leccion,
		num_TotalFilas = COUNT(1) OVER()
	FROM [FactureProfesores].[dbo].[Lecciones] WHERE Fecha BETWEEN @fecha_inicial AND @fecha_final
	ORDER BY Fecha DESC
END
GO
/****** Object:  StoredProcedure [dbo].[GetProfesores]    Script Date: 18/04/2022 12:09:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Isaias Asis
-- Create date: 16/04/2022
-- Description:	Obtener todos los profesores registrados
-- =============================================
CREATE PROCEDURE [dbo].[GetProfesores]
AS
BEGIN
	SELECT
		Nombre,
		Identificacion,
		Tipo_Moneda,
		Tarifa_Horaria,
		Tipo_Profesor,
		Equivalencia,
		num_TotalFilas = COUNT(1) OVER()
	FROM [FactureProfesores].[dbo].[Profesor]
	ORDER BY Id DESC
END
GO
/****** Object:  StoredProcedure [dbo].[LeccionesCrear]    Script Date: 18/04/2022 12:09:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Isaias Asis
-- Create date: 15/04/2022
-- Description:	Sp de crear lección
-- =============================================
CREATE PROCEDURE [dbo].[LeccionesCrear](
	@codigo_curso varchar(50),
	@horas int,
	@fecha_leccion DATETIME,
	@id_profesor varchar(50)
)
AS
BEGIN
	DECLARE
	@ErrorMessage VARCHAR(MAX),
	@result numeric(18,2),
	@resultTimeXCurs numeric(18,2),
	@tarifaProfesor numeric(18,2)
	IF(ISNULL(@fecha_leccion, '') = '')
	BEGIN
		RAISERROR('El campo fecha es requerido.', 16,2);
		RETURN
	END

	IF(ISNULL(@id_profesor, '') = '')
	BEGIN
		RAISERROR('El campo id profesor es requerido.', 16,2);
		RETURN
	END

	IF(NOT EXISTS(SELECT TOP 1 Identificacion FROM [dbo].[Profesor] WHERE Identificacion = @id_profesor))
	BEGIN
		SET @ErrorMessage = CONCAT('No existe un profesor con identificación: ', @id_profesor)
		RAISERROR(@ErrorMessage, 16,2);
		RETURN
	END

	IF(ISNULL(@horas, '') = '')
	BEGIN
		RAISERROR('El campo horas es requerido.', 16,2);
		RETURN
	END

	IF(ISNULL(@codigo_curso, '') = '')
	BEGIN
		RAISERROR('El campo codigo curso es requerido.', 16,2);
		RETURN
	END

	SELECT @result = SUM(dbo.Lecciones.Horas) FROM [dbo].Lecciones WHERE Id_Profesor = @id_profesor
	IF (@result >= 160)
	BEGIN
		RAISERROR('El máximo de horas acumuladas por profesor no puede ser mayor a 160', 16,2);
		RETURN
	END

	SELECT @resultTimeXCurs = SUM([FactureProfesores].[dbo].[Lecciones].[Horas]) FROM [FactureProfesores].[dbo].[Lecciones] 
	WHERE Id_Profesor = @id_profesor AND Codigo_Curso = @codigo_curso

	IF (@resultTimeXCurs >= 20 OR @horas > 20)
	BEGIN
		RAISERROR('El máximo de horas por curso al mes no puede ser mayor a 20', 16,2);
		RETURN
	END

	IF(EXISTS(SELECT TOP 1 Codigo_Curso FROM [FactureProfesores].[dbo].[Lecciones] WHERE Codigo_Curso = @codigo_curso))
	BEGIN
		SET @ErrorMessage = CONCAT('El curso con codigo: ', @codigo_curso, ' ya existe')
		RAISERROR(@ErrorMessage, 16,2);
		RETURN
	END

	BEGIN
	SELECT @tarifaProfesor = Tarifa_Horaria FROM [dbo].[Profesor] WHERE Identificacion = @id_profesor
	
	END

	BEGIN TRY
		INSERT INTO 
			[dbo].[Lecciones](
			Codigo_Curso,
			Horas,
			Fecha,
			Id_Profesor,
			Valor_Leccion)
		VALUES(
			@codigo_curso,
			@horas,
			@fecha_leccion,
			@id_profesor,
			@tarifaProfesor * @horas)

	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		RAISERROR(@ErrorMessage, 16, 2);
	END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[ProfesoresCrear]    Script Date: 18/04/2022 12:09:58 a. m. ******/
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
USE [master]
GO
ALTER DATABASE [FactureProfesores] SET  READ_WRITE 
GO
