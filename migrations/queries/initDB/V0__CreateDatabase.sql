/****** Create Database based on manual production backup ******/
CREATE DATABASE [localDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'localDB', FILENAME = N'/var/opt/mssql/data/localDB.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'localDB_log', FILENAME = N'/var/opt/mssql/data/localDB_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 COLLATE SQL_Latin1_General_CP1_CI_AS
GO
ALTER DATABASE [localDB] SET COMPATIBILITY_LEVEL = 120
GO
ALTER DATABASE [localDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [localDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [localDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [localDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [localDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [localDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [localDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [localDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [localDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [localDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [localDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [localDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [localDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [localDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [localDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [localDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [localDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [localDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [localDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [localDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [localDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [localDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [localDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [localDB] SET  MULTI_USER 
GO
ALTER DATABASE [localDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [localDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [localDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [localDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [localDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [localDB] SET QUERY_STORE = OFF
GO